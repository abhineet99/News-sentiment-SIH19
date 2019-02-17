#this is a scrapper of ndtv website
import requests
from bs4 import BeautifulSoup as bsp #pip install beautifulsoup4
page = requests.get('https://www.ndtv.com/topic/railways') #ndtv railways topic link
data = page.text
soup= bsp(data,'html.parser')
#print(soup)
results = soup.findAll("li", {"style" :"padding: 5px;"})
#print (results)
for tag in results:
# #  	#soup=bsp(tag)
	headline = tag.find("strong")
	print(headline.string)
	date_time= tag.find("p",{"class" : "list_dateline"})
	my_string=date_time.contents[1]
	to_print=my_string[-38:]
	print(to_print)
	# 	#date_time_formatted= date_time.string
	print('\n')
