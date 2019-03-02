#this is a scrapper of ndtv website
import requests
import csv
source="NDTV"
from bs4 import BeautifulSoup as bsp #pip install beautifulsoup4
page = requests.get('https://www.ndtv.com/topic/railways') #ndtv railways topic link
data = page.text
soup= bsp(data,'html.parser')
#print(soup)

results = soup.findAll("li", {"style" :"padding: 5px;"})
#print (results)
with open("news_from_scrapper.csv","a") as csvfile:
	for tag in results:
	# #  	#soup=bsp(tag)
		headline = tag.find("strong")
		#print(headline.string)
		date_time= tag.find("p",{"class" : "list_dateline"})
		headline_url=tag.find("a")
		headline_url=headline_url['href']
		details=tag.find("p",{"class" : "intro"})
		image_tag=tag.find("img",{"alt" : True})
		try:
			image_url=image_tag['src']
		except:
			image_url="none"
		print(image_url)		
		#print(headline_url)
		details=details.string
		#print(details)
		my_string=date_time.contents[1]
		to_print=my_string[-38:]
		to_print=to_print[0:20]
		writer=csv.writer(csvfile)
		try:
			writer.writerow([source,headline.string,headline_url,to_print,details,image_url])
		except UnicodeEncodeError:
			continue
		#print(to_print)
		# 	#date_time_formatted= date_time.string
		#print('\n')
