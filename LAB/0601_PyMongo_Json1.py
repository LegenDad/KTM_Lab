# -*- coding: utf-8 -*-
"""
Created on Fri Jun  1 10:30:03 2018

@author: Jeon
"""

import os
import pandas as pd
import pymongo
import json

mongo = pymongo.MongoClient('localhost', 27017)
mongo.database_names()
mongo.testdb.collection_names()

def import_content(filepath):     
    data = pd.read_csv(filepath)
    data_json = json.loads(data.to_json(orient='records'))
    mongo.testdb.items.remove()
    mongo.testdb.items.insert(data_json)
    

filepath = "E:/BigData/R/KTM_Lab/LAB/yelp_business_hours.csv"

import_content(filepath)

for doc in mongo.testdb.items.find().limit(10):
    print(doc)
    
data = pd.read_csv(filepath)
data_json = json.loads(data.to_json(orient='records'))
data_json2 =json.loads(data.to_json)
