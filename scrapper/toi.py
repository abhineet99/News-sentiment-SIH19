#this is a scrapper of Times of India news website
import requests
from bs4 import BeautifulSoup as bsp
page = requests.get('https://timesofindia.indiatimes.com/topic/indian-railways') #the toi railways topic link
data = page.text
soup= bsp(data,'html.parser')
results = soup.findAll("span", {"class" : "title"})
#print (results)
for tag in results:
	print(tag.string) #headlines will be printed, working on date and time now
