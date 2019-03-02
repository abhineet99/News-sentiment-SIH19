#this is a scrapper of ndtv website

import similarity_checker
import pandas as pd


import requests
import csv
source="NDTV"
from bs4 import BeautifulSoup as bsp #pip install beautifulsoup4
page = requests.get('https://www.ndtv.com/topic/railways') #ndtv railways topic link
data = page.text
soup= bsp(data,'html.parser')
#print(soup)
months=["January","February","March","April","May","June","July","August","September","October","November","December"]
results = soup.findAll("li", {"style" :"padding: 5px;"})
#print (results)
with open("news_from_scrapper.csv","a") as csvfile:

	headline_file = open("headlines.csv","a")

	for tag in results:
	# #  	#soup=bsp(tag)
		headline = tag.find("strong")
		headline=headline.string
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
		#print(image_url)		
		#print(headline_url)
		details=details.string
		#print(details)
		my_string=date_time.contents[1]
		#print(my_string)
		for each in months:
			check =my_string.find(each)
			if(check!=-1):
				break;
		end_time=check+len(each)+9
		#print(my_string[check:end_time])		


		to_print=my_string[check:end_time]
		#to_print=to_print[0:20]
		writer=csv.writer(csvfile)
		#headline=headline.string
		headline_url=headline_url
		to_print=to_print
		details=details
		image_url=image_url


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
		# 	#date_time_formatted= date_time.string
		#print('\n')
