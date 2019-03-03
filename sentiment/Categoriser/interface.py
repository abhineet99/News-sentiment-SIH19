import pandas as pd
import cat
SOURCE = "../tempOutput.csv"
DESTINATION = "../Output.csv"

inputMatrix = pd.read_csv(SOURCE)
# print(inputMatrix)
# exit(0)
# sent = "Accident "
# print(cat.)

cat_ = [] 
# textData = inputMatrix['Headline']
clen = len (inputMatrix['Headline'])
for i in range(clen):
	if not pd.isnull(inputMatrix['PredictedCat'][i]):
		cat_.append(inputMatrix['PredictedCat'][i])
		continue
	else:
		text = inputMatrix['Headline'][i]
		new_date = inputMatrix['Date'][i].lstrip()
		print(new_date)
		if (cat.isUrgent(text,new_date)):
			cat_.append('U')
		elif (cat.isPositive(text)):
			cat_.append('P')
		elif (cat.isCleanliness(text)):
			cat_.append('C')
		elif (cat.isNeg(text,new_date)):
			cat_.append('N')
		else:
			cat_.append('O')
	
raw_data = {'Source': inputMatrix['Source'] , 'Headline': inputMatrix['Headline'], 'SourceURL':inputMatrix['SourceURL'], 'Date' : inputMatrix['Date'], 'Details' : inputMatrix['Details'], 'ImageURL' : inputMatrix['ImageURL'] , 'Sentiment': inputMatrix['Sentiment'], 'SentimentScore':inputMatrix['SentimentScore'] , 'Uploaded' : inputMatrix['Uploaded'] , 'PredCat' : cat_  }
df = pd.DataFrame(raw_data, columns = ['Source', 'Headline' , 'SourceURL', 'Date', 'Description', 'ImageURL', 'Sentiment', 'SentimentScore', 'Uploaded', 'PredictedCat'  ])
df.to_csv(DESTINATION, sep = ',' , index= False)

	
	





