#this is a scrapper of finexpress website
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
# # #print (results)
with open("news_from_scrapper.csv","a") as csvfile:
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
		#print(url)
		#print(headline)
		#print(details)
		date_tag=tag.find("span", {"class" :"minsago"})
		date_time=date_tag.string
		date_time=date_time.encode('utf-8')
		#print(date_time)
		#print('\n')
		datetime_object = datetime.strptime(date_time, '%b %d, %Y')
		to_print=datetime_object.strftime('%B %d, %Y')
		to_print=to_print.encode('utf-8')
		writer=csv.writer(csvfile)
		writer.writerow([source,headline,url,to_print,details])


# 		#print(headline.string)
# 		date_time= tag.find("time")
# 		#my_string=date_time.contents[1]
# 		headline_url="https://economictimes.indiatimes.com"
# 		headline_url2=tag.find("a")
# 		headline_url2=headline_url2['href']
# 		headline_url=headline_url+headline_url2
# 		#print(headline_url)
# 		to_print=date_time.string
# 		details=tag.find("p")
# 		details=details.string
# 		#print(details)
# 		try:
# 			to_print=to_print[0:12]
# 			#print(to_print)
# 			datetime_object = datetime.strptime(to_print, '%d %b, %Y')
# 			to_print=datetime_object.strftime('%B %d, %Y')
# 		except ValueError:
 		#	datetime_object = datetime.strptime(to_print, '%d %b, %Y,')
 		#	to_print=datetime_object.strftime('%B %d, %Y')
# 		except TypeError:
# 			to_print=" "

# 		writer=csv.writer(csvfile)
# 		try:
# 			writer.writerow([source,headline.string,headline_url,to_print,details])
# 		except UnicodeEncodeError:
# 			continue
# 		#print(to_print)
# 			#date_time_formatted= date_time.string
# 		#print('\n')
