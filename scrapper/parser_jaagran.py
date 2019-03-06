#this is a scrapper of Jaagran news website
# -*- coding: utf-8 -*-
import os, requests, uuid, json



# print(json.dumps(response, sort_keys=True, indent=4, separators=(',', ': ')))
import requests
import csv
import datetime
source="Jagran"
from bs4 import BeautifulSoup as bsp #pip install beautifulsoup4
page = requests.get('https://www.jagran.com/search/railway') #the jagran railways topic link
data = page.text
soup= bsp(data,'html.parser')
#print(soup)

subscriptionKey="" #enter sub key
base_url = 'https://api.cognitive.microsofttranslator.com'
path = '/translate?api-version=3.0'
params = '&to=en'
constructed_url = base_url + path + params

headers = {
    'Ocp-Apim-Subscription-Key': subscriptionKey,
    'Content-type': 'application/json',
    'X-ClientTraceId': str(uuid.uuid4())
}

# You can pass more than one object in body.

# body = [{
#     'text' : hi
# }]
#request = requests.post(constructed_url, headers=headers, json=body)
#response = request.json()
results = soup.findAll("li")
with open("news_from_scrapper.csv","a") as csvfile:
	headline_file = open("headlines.csv","a")
	for tag in results:
		find_child=tag.findAll("figure",{"class" : "proimg fl"})
		#print(len(find_child))
		base_headline_url="https://www.jagran.com"
		if(len(find_child)==0):
			continue
		else:
			find_child=tag.findAll("a",{"href" : True})
			#print(find_child)
			headline=find_child[1].string
			headline_url=find_child[1]['href']
			headline_url=base_headline_url+headline_url
			body = [{
			    'text' : headline
					}]
			request = requests.post(constructed_url, headers=headers, json=body)
			response = request.json()		
			json_dump=json.dumps(response, sort_keys=True, indent=4, separators=(',', ': '))
			lol=json.loads(json_dump)
	#print(lol[0])
			headline=lol[0]['translations'][0]['text']
			details=find_child[2].string
			body = [{
			    'text' : details
					}]
			request = requests.post(constructed_url, headers=headers, json=body)
			response = request.json()		
			json_dump=json.dumps(response, sort_keys=True, indent=4, separators=(',', ': '))
			lol=json.loads(json_dump)
			details=lol[0]['translations'][0]['text']
			date=datetime.datetime.now()
			to_print=date.strftime('%B %d, %Y')
			print(type(find_child[0]))
			image_url="none"
			try:
				#Here check if the headline is similar to any of the existing headlines in the csv file

				#use pandas to read the headlines file
				headlines_df = pd.read_csv('headlines.csv')
				is_similar = False
				for row_num in range(len(headlines_df)):
					#compare the headlien to the ones already there in the csv file
					if similarity_checker.similar(headlines_df.at[row_num, 'Headline'], headline):#if its similar
						is_similar = True
				#once out of the loop, check if is_similar is true
				if not is_similar:
					writer=csv.writer(csvfile)
					writer.writerow([source,headline,headline_url,to_print,details,image_url])

				headline_writer=csv.writer(headline_file)
				try:
					#append the new headline to the csv file
					headline_writer.writerow([headline])
					#close the headlines file
					
				except Exception as e:
					print(e)
				
			except Exception as e:
				print(e)
	# 	for items in tag:
	# 		#print(items.encode('utf-8'))
	# 		#print("abhineet")
	# 		item_string=items.encode('utf-8')
	# 		if(item_string[0]!='<'):
	# 			if(len(item_string)>1):
	# 				print(item_string)
				#print(len(item_string))
			#print (items.string.encode('utf-8'))
	#print (soup)
	# with open("news_from_scrapper.csv","a") as csvfile:
	# 	for tag in results:
	# 	 	#soup=bsp(tag)
	# 		headline = tag.find("span", {"class" : "title"})
	# 		#print(headline.string)
	# 		date_time= tag.find("span",{"class" : "meta"})
	# 		headline_url="https://timesofindia.indiatimes.com"
	# 		headline_url2=tag.find("span", {"class" : "fb"})
	# 		headline_url2=headline_url2['data-url']
			
	# 		headline_url=headline_url+headline_url2
	# 		#print(headline_url)
	# 		to_print=date_time.string
	# 		to_print=to_print[0:11]
	# 		if to_print[10]=='T':
	# 			datetime_object = datetime.strptime(to_print, '%Y-%m-%dT')
	# 			to_print=datetime_object.strftime('%B %d, %Y')
	# 		else:
	# 			datetime_object = datetime.strptime(to_print, '%d %b %Y')
	# 			to_print=datetime_object.strftime('%B %d, %Y')
			
	# 		#print(to_print[10])
	 	# 	writer=csv.writer(csvfile)
			# try:
			# 	writer.writerow([source,headline,headline_url,to_print,details,image_url])
			# except UnicodeEncodeError:
			# 	continue	
		#date_time_formatted= date_time.string
		#print('\n')
