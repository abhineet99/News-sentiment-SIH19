#this is a scrapper of Times of India news website
import requests
import csv
from datetime import datetime
source="TOI"
from bs4 import BeautifulSoup as bsp #pip install beautifulsoup4
page = requests.get('https://timesofindia.indiatimes.com/topic/indian-railways') #the toi railways topic link
data = page.text
soup= bsp(data,'html.parser')
results = soup.findAll("li", {"class" : "article"},{"itemprop":"itemListElement"})
#print (results)
with open("news_from_scrapper.csv","a") as csvfile:
	for tag in results:
	 	#soup=bsp(tag)
		headline = tag.find("span", {"class" : "title"})
		#print(headline.string)
		date_time= tag.find("span",{"class" : "meta"})
		headline_url="https://timesofindia.indiatimes.com"
		headline_url2=tag.find("span", {"class" : "fb"})
		headline_url2=headline_url2['data-url']
		
		headline_url=headline_url+headline_url2
		#print(headline_url)
		to_print=date_time.string
		to_print=to_print[0:11]
		if to_print[10]=='T':
			datetime_object = datetime.strptime(to_print, '%Y-%m-%dT')
			to_print=datetime_object.strftime('%B %d, %Y')
		else:
			datetime_object = datetime.strptime(to_print, '%d %b %Y')
			to_print=datetime_object.strftime('%B %d, %Y')
		
		#print(to_print[10])
		writer=csv.writer(csvfile)
		page2 = requests.get('https://timesofindia.indiatimes.com/city/kolkata/rajdhani-50th-birthday-treat-for-passengers/articleshow/68209484.cms') #the toi railways topic link
		data2 = page2.text
		details=" "
		soup2= bsp(data2,'html.parser')
		results2 = soup2.findAll("div", {"class" : "Normal"})
		for tag2 in results2:
			for items2 in tag2:
		#print(items.encode('utf-8'))
		#print("abhineet")
				item_string=items2.encode('utf-8')
				if(item_string[0]!='<'):
					if(len(item_string)>1):
						details=details+item_string
		try:
			writer.writerow([source,headline.string,headline_url,to_print,details])
		except UnicodeEncodeError:
			continue	
		#date_time_formatted= date_time.string
		#print('\n')
