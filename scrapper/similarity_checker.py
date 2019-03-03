import paralleldots as pdot
import json
from time import sleep

SIMILARITY_CUTOFF = 0.7

def similar(text1, text2):
    pdot.set_api_key("91cjpk2HkVWLoO0NUfM93AJ66DFM7SHLK7kmbymt4LE")
    
    response=pdot.similarity(text1,text2)
    
    return response['actual_score'] >=SIMILARITY_CUTOFF
