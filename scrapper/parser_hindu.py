#this is a scrapper of The Hindu website, extracts a day's news
import requests
import csv
from datetime import datetime


news_words=["coach","IRCTC","irctc","railway","railways","express","passenger","passengers","coaches","rail","train","trains","rails","track","tracks","engine"]
source="The Hindu"
from bs4 import BeautifulSoup as bsp #pip install beautifulsoup4
try:
	page = requests.get('https://www.thehindu.com/search/?q=railways&order=DESC&sort=publishdate&pd=yesterday&ct=text&page=1') 
except:
	print("A connection error!")
	exit()
data = page.text
soup= bsp(data,'html.parser')
#print(soup)
results = soup.findAll("div", {"class" : "75_1x_StoryCard mobile-padding"})
#print (results)
with open("news_from_scrapper.csv","a") as csvfile:
	for tag in results:
	#  	#soup=bsp(tag)
		headline = tag.find("a", {"class" : "story-card75x1-text"})
		#image_tag=headline = tag.find("img", {"alt" })
		image_tag= tag.find("img", {"alt" :True})
		try:
			image_url= image_tag['data-src-template']
		except:
			image_url=" "
			
		#print(image_url)
	 	#print(headline.string)
		details=tag.find("span", {"class" : "light-gray-color story-card-33-text hidden-xs"})
		details=details.string
		headline_url=headline['href']
		#print(headline_url)
		rail_news_check=0
		headline=headline.string
		headline_words=headline.split()

		for each in news_words:
			if each in headline_words:
				rail_news_check=1
				break
		if rail_news_check==1:		
			date_time= tag.find("span",{"class" : "dateline"})
			to_print=date_time.string
			to_print=to_print.encode('utf-8')
			headline=headline.encode('utf-8')
			#datetime_object = to_print.strptime('Jun 1 2005  1:33PM', '%b %d %Y %I:%M%p')
			details=details.encode('utf-8')
			to_print=to_print.decode('utf-8')
			headline=headline.decode('utf-8')
			#datetime_object = to_print.strptime('Jun 1 2005  1:33PM', '%b %d %Y %I:%M%p')
			details=details.decode('utf-8')
			headline_url=headline_url.decode('utf-8')
			image_url=image_url.decode('utf-8')
			writer=csv.writer(csvfile)
			writer.writerow([source,headline,headline_url,to_print,details,image_url])
			#except UnicodeEncodeError:
			#	continue
	# 	#date_time_formatted= date_time.string
	# 	print('\n')
