import os
import requests
from bs4 import BeautifulSoup as bsp
page = requests.get('https://timesofindia.indiatimes.com/topic/indian-railways') 
data = page.text
soup= bsp(data,'html.parser')
results = soup.findAll("span", {"class" : "title"})
print (results)