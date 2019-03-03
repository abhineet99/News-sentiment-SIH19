import inspect
import os
from datetime import datetime
import numpy as np
from adpricing.models import AdData
import pandas as pd

SOURCE_FILE = 'input_to_algo.csv'
data = pd.read_csv(SOURCE_FILE)


abs_path = os.getcwd()


INPUT_FILE = os.path.dirname(os.path.abspath(
    inspect.getfile(inspect.currentframe())))+"/sorted_news.csv"

# when this script is run, the model is updated with the new data
# so there are three more columns in the final_data.csv file...after the source etc,....
# one column deals with whether that particular row has already been uploaded to the server
# this column is named "uploaded" which is a bool


def run():
    # Fetch all questions
    data = pd.read_csv(INPUT_FILE)
    print(data)
    for row_num in range(len(data)):

        # then add the current row to the server

        # then add the current row to the server
        new_edition_area = data['Edition'][row_num]
        new_newspaper_name = data['Name'][row_num]
        new_periodicity = data['Periodicity'][row_num]
        new_state = data['State'][row_num]
        new_size = data['Size'][row_num]

        new_language = data['Language'][row_num]
        new_phone = data['Mobile'][row_num]

        new_readers = data['Readers'][row_num]
        new_rate = data['Rate'][row_num]

        new_circulation_score = data['CirculationScore'][row_num]
        new_circulation = data['Circulation'][row_num]

        # create the new News object
        new_ad_data = AdData(edition_area=new_edition_area, state=new_state, newspaper_name=new_newspaper_name,
                             periodicity=new_periodicity, rate=new_rate, language=new_language, phone=new_phone, size=new_size, circulation_type=new_circulation, circulation_score=new_circulation_score, readers=new_readers)
        # now save the new entry to the database
        new_ad_data.save()
