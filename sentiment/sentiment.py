#this file will interface with the ml model
#takes as input the news_from_scrapper in the scrapper folder and generates a new csv file in the data directory
#have another column for sentiment

import pandas as pd

const SOURCE_DB = "../scrapper/news_from_scrapper.csv"

def analyse_sentiment():
    df = pd.read_csv(SOURCE_DB)
    #then ask