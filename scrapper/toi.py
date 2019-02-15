#this is a scrapper of Times of India news website
import requests
from bs4 import BeautifulSoup as bsp #pip install beautifulsoup4
page = requests.get('https://timesofindia.indiatimes.com/topic/indian-railways') #the toi railways topic link
data = page.text
soup= bsp(data,'html.parser')
results = soup.findAll("li", {"class" : "article"},{"itemprop":"itemListElement"})
#print (results)
for tag in results:
 	#soup=bsp(tag)
 	headline = tag.find("span", {"class" : "title"})
	print (headline.string)
	date_time= tag.find("span",{"class" : "meta"})
	print(date_time.string)
	#date_time_formatted= date_time.string
	print('\n')
