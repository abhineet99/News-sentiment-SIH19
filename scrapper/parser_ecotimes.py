#this is a scrapper of economic times website
import requests
import csv
source="Economic Times"
from bs4 import BeautifulSoup as bsp #pip install beautifulsoup4
page = requests.get('https://economictimes.indiatimes.com/topic/indian-railways') #ndtv railways topic link
data = page.text
soup= bsp(data,'html.parser')
#print(soup)

results = soup.findAll("div", {"class" :"flr topicstry"})
# #print (results)
with open("news_from_scrapper.csv","a") as csvfile:
	for tag in results:
	# #  	#soup=bsp(tag)
		headline = tag.find("h3")
		#print(headline.string)
		date_time= tag.find("time")
		#my_string=date_time.contents[1]
		to_print=date_time.string
		try:
			to_print=to_print[0:12]	
		except TypeError:
			to_print=" "	
		writer=csv.writer(csvfile)
		writer.writerow([source,headline.string,to_print])

		#print(to_print)
			#date_time_formatted= date_time.string
		#print('\n')
