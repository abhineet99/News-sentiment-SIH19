#this is a scrapper of finexpress website
import pandas as pd
import similarity_checker


import requests
import csv
from datetime import datetime
source="Financial Express"
from bs4 import BeautifulSoup as bsp #pip install beautifulsoup4
page = requests.get('https://www.financialexpress.com/infrastructure/railways/') #financial express railways topic link
data = page.text
soup= bsp(data,'html.parser')
#print(soup)

results = soup.findAll("div", {"class" :"listitembx"})
#print (results)
with open("news_from_scrapper.csv","a") as csvfile:

	headline_file = open("headlines.csv","a")

	for tag in results:
	# 	# #  	#soup=bsp(tag)
		headline_head = tag.find("h3")
		headline_tag=headline_head.find("a")
		headline=headline_tag['title']
		url=headline_tag['href']
		details_tag=tag.find("h4")
		details=details_tag.string
		details=details.encode('utf-8')
		headline=headline.encode('utf-8')
		details=details.decode('utf-8')
		headline=headline.decode('utf-8')
		image_tag=tag.find("img", {"alt":True})
		#print(image_tag)
		try:
			image_url=image_tag['src']

			#print(image_url)
		except:
			image_url="none"	
		#print(url)
		#print(headline)
		#print(details)
		date_tag=tag.find("span", {"class" :"minsago"})
		date_time=date_tag.string
		#date_time=date_time.encode('utf-8')
		#print(date_time)
		#print('\n')
		#print(type(date_time))
		datetime_object = datetime.strptime(date_time, '%b %d, %Y')
		to_print=datetime_object.strftime('%B %d, %Y')
		to_print=to_print.encode('utf-8')
		to_print=to_print.decode('utf-8')
		date_time=date_time
		headline=headline
		image_url=image_url


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


		writer=csv.writer(csvfile)
		writer.writerow([source,headline,url,to_print,details,image_url])

