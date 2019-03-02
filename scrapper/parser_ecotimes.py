#this is a scrapper of economic times website
import similarity_checker
import pandas as pd


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

#insert the headers into the file
with open("news_from_scrapper.csv","w") as csvfile:
	try:
		#opening the main csv file
		writer=csv.writer(csvfile)
		writer.writerow(['Source','Headline','SourceURL','Date','Details','ImageURL'])
	except Exception as e:
		print(e)

with open("headlines.csv","w") as csvfile:
	try:
		#opening the main csv file
		headline_writer=csv.writer(csvfile)
		headline_writer.writerow(['Headline'])
	except Exception as e:
		print(e)




with open("news_from_scrapper.csv","a") as csvfile:


	headline_file = open("headlines.csv","a")
	
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
		headline=headline.string
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
		headline=headline

		try:
			#Here check if the headline is similar to any of the existing headlines in the csv file

			#use pandas to read the headlines file
			headlines_df = pd.read_csv('headlines.csv')
			is_similar = False
			for row_num in range(len(headlines_df)):
				#compare the headlien to the ones already there in the csv file
				if similarity_checker.similar(headlines_df.at[row_num, 'Headline'], headline):#if its similar
					is_similar = True
			#once out of the loop, check if is_similar is true
			if not is_similar:
				writer=csv.writer(csvfile)
				writer.writerow([source,headline,headline_url,to_print,details,image_url])

			headline_writer=csv.writer(headline_file)
			try:
				#append the new headline to the csv file
				headline_writer.writerow([headline])
				#close the headlines file
				
			except Exception as e:
				print(e)
			
			
			
		except UnicodeEncodeError:
			continue
		#print(to_print)
			#date_time_formatted= date_time.string
		#print('\n')

headline_file.close()
