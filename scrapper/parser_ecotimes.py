#this is a scrapper of economic times website
import requests
import csv
from datetime import datetime
source="Economic Times"
from bs4 import BeautifulSoup as bsp #pip install beautifulsoup4
page = requests.get('https://economictimes.indiatimes.com/topic/indian-railways') #ndtv railways topic link
data = page.text
soup= bsp(data,'html.parser')
#print(soup)

results = soup.findAll("div", {"class" :"flr topicstry"})
#print (results)
with open("news_from_scrapper.csv","a") as csvfile:
	for tag in results:
		image_tag=tag.find("img")
		#print(image_tag)
		try:
			image_url=image_tag['src']
			#print(image_url)
		except:
			image_url="none"	
	# #  	#soup=bsp(tag)
		headline = tag.find("h3")
		#print(headline.string)
		date_time= tag.find("time")
		#my_string=date_time.contents[1]
		headline_url="https://economictimes.indiatimes.com"
		headline_url2=tag.find("a")
		headline_url2=headline_url2['href']
		headline_url=headline_url+headline_url2
		#print(headline_url)
		to_print=date_time.string
		details=tag.find("p")
		details=details.string
		#print(details)
		try:
			to_print=to_print[0:12]
			#print(to_print)
			datetime_object = datetime.strptime(to_print, '%d %b, %Y')
			to_print=datetime_object.strftime('%B %d, %Y')
		except ValueError:
			datetime_object = datetime.strptime(to_print, '%d %b, %Y,')
			to_print=datetime_object.strftime('%B %d, %Y')
		except TypeError:
			to_print=" "

		writer=csv.writer(csvfile)
		try:
			writer.writerow([source,headline.string,headline_url,to_print,details,image_url])
		except UnicodeEncodeError:
			continue
		#print(to_print)
			#date_time_formatted= date_time.string
		#print('\n')
