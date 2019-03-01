#!/usr/bin/env python3

import json
import numpy as np
import keras.preprocessing.text as kpt
from keras.preprocessing.text import Tokenizer
from keras.models import model_from_json
import pandas as pd
import math

SOURCE =   "news_from_scrapper.csv"
DESTINATION = "Output.csv"

def convert_text_to_index_array(text):
	words = kpt.text_to_word_sequence(text)
	wordIndices = []
	for word in words:
		if word in dictionary:
			wordIndices.append(dictionary[word])
	return wordIndices
labels = ['happy','not_happy']
with open('dictionary.json', 'r') as dictionary_file:
	dictionary = json.load(dictionary_file)

json_file = open('model.json', 'r')
loaded_model_json = json_file.read()
json_file.close()
model = model_from_json(loaded_model_json)
model.load_weights('model.h5')



#taking inputs 
inputMatrix = pd.read_csv(SOURCE)
clen = len ( inputMatrix['Headline'] )
tokenizer = Tokenizer(num_words=10000) 

y_pred = []
y_label = []
for i in range(clen):
	try:
		headLine = inputMatrix['Headline'][i]
		testArr = convert_text_to_index_array(headLine)
		if not inputMatrix['Sentiment'][i]:
			y_pred.append(inputMatrix['Sentiment'][i])
			continue
		headLineInp = tokenizer.sequences_to_matrix([testArr], mode='binary')
		pred = model.predict(headLineInp)
		y_pred.append(pred)
	except AttributeError:
		break
raw_data = {'Source': inputMatrix['Source'] ,'Headline': inputMatrix['Headline'], 'Date' : inputMatrix['Date'],  'Sentiment':  y_pred }
df = pd.DataFrame(raw_data, columns = ['Source', 'Headline' , 'Date' , 'Sentiment'])
df.to_csv(DESTINATION, sep = ',' , index= False)

	
