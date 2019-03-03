# -*- coding: utf-8 -*-

import re
from nltk.stem import PorterStemmer
from datetime import datetime, timedelta
ps = PorterStemmer()
from datetime import datetime


def wordPresent(string1):
    s = re.sub(r'[^\w\s]','',string1)
    # print(s)
    mystr = s

    wordList = mystr.split()
    input_stemmed = [ps.stem(elem) for elem in wordList]
    

    list_w=['defect','died','casualities','break','strike','struck','serious','deadly','victim','damage','derailed','helpless','strikes','fail','fell','collision','contamination','disease','fatal','injuries','crash','accident','fire','killed','loses','lost','hit','suicide','pathogen','epidemic','contamination','explosion','problem','suicide']
    list_stemmed = [ps.stem(word) for word in list_w]
    return any(i in list_stemmed for i in input_stemmed)
    

def isCleanliness (string1):
    s = re.sub(r'[^\w\s]','',string1)
    mystr = s

    wordList = mystr.split()
    input_stemmed = [ps.stem(elem) for elem in wordList]
    # 'sanitation','bedroll','dustbin','sweep','garbage','spit','litter','debris','trash','sack','sleep','sanitization','sanitary','medication','prevent','health','infection','sewerage','contamination','drain','waste'
    list_w=['hygine','clean','swachhata','filthy','housekeeping','catering','mouse','Rat','taint','poisioning', 'stale' , 'milk' , 'baby' , 'swachh'  , 'toilet' , 'sanitation' , 'bed']
    list_stemmed = [ps.stem(word) for word in list_w]
    return any(i in list_stemmed for i in input_stemmed)
    
def isPositive(string1):
    s = re.sub(r'[^\w\s]','',string1)
    mystr = s

    wordList = mystr.split()
    input_stemmed = [ps.stem(elem) for elem in wordList]
    
    list_w=['Plan', 'new' , 'Excellent' , 'inauguration' , 'inaugurate' , 'established' , 'employee' , '!' , 'bullet' , 'kmph' , 'swanky' , 'recruit' , 'fast' , 'budget'  ]
    list_stemmed = [ps.stem(word) for word in list_w]
    return any(i in list_stemmed for i in input_stemmed)


def isUrgent(msg,new_date):
    return isLatest(new_date) and wordPresent(msg)

def isLatest(new_date):
    """ Read """
    past = datetime.now() - timedelta(days=1) #CHANGE HERE
    #assumption date is a string
    timeobj = datetime.strptime(new_date, '%B %d, %Y')
    if timeobj > past:
        return True
    else:
        return False
    #date time objecr

def isNeg(msg,new_date):
    past = datetime.now() - timedelta(days=1) #CHANGE HERE
    timeobj = datetime.strptime(new_date, '%B %d, %Y')
    if timeobj > past:
        return False
    else:
        return True


