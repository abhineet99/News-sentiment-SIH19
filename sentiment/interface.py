#!/usr/bin/env python3

import json
import numpy as np
import keras.preprocessing.text as kpt
from keras.preprocessing.text import Tokenizer
from keras.models import model_from_json
import pandas as pd
import math
import sys

SOURCE =   "news_from_scrapper.csv"
DESTINATION = "tempOutput.csv"

def convert_text_to_index_array(text):
	words = kpt.text_to_word_sequence(text)
	wordIndices = []
	for word in words:
		if word in dictionary:
			wordIndices.append(dictionary[word])
	return wordIndices
labels = [0,1]
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
inputMatrix['SentimentScore'] = np.nan
 
inputMatrix['Uploaded'] = np.nan
inputMatrix['Category'] = np.nan
y_pred_pos = []
sentiment_ = []
print (clen)
for i in range(clen):
	try:
		headLine = inputMatrix['Headline'][i]
		testArr = convert_text_to_index_array(headLine)
		if (np.nan== inputMatrix['SentimentScore'][i]):
			y_pred_pos.append(inputMatrix['SentimentScore'][i])
			sentiment_.append(inputMatrix['Sentiment'][i])
			continue
		headLineInp = tokenizer.sequences_to_matrix([testArr], mode='binary')
		pred = model.predict(headLineInp)
		y_pred_pos.append(pred[0][0])
		sentiment_.append(np.argmax(pred))
		# y_pred_neg.append(pred[0][1])
	except AttributeError:
		break
    

print(len(y_pred_pos))
raw_data = {'Source': inputMatrix['Source'] , 'Headline': inputMatrix['Headline'], 'SourceURL':inputMatrix['SourceURL'], 'Date' : inputMatrix['Date'], 'Description' : inputMatrix['Details'], 'ImageURL' : inputMatrix['ImageURL'] , 'Sentiment': sentiment_, 'SentimentScore':y_pred_pos , 'Uploaded' : inputMatrix['Uploaded']  }
df = pd.DataFrame(raw_data, columns = ['Source', 'Headline' , 'SourceURL', 'Date', 'Details', 'ImageURL', 'Sentiment', 'SentimentScore', 'Uploaded'  ])
df.to_csv(DESTINATION, sep = ',' , index= False)
