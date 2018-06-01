# -*- coding: utf-8 -*-
"""
Created on Fri Jun  1 11:13:11 2018

@author: Jeon
"""

import pandas as pd
import pymongo
import json

mongo = pymongo.MongoClient('localhost', 27017)
mongo.database_names()
mongo.testdb.collection_names()

def import_con(filepath):
    data = pd.read_csv(filepath)
    data_json = json.loads(data.to_json(orient='records'))
    mongo.testdb.bike.remove()
    mongo.testdb.bike.insert(data_json)
    
filepath = "E:/BigData/Data/Bike/train.csv"
import_con(filepath)

for doc in mongo.testdb.bike.find().limit(10):
    print(doc)
    

print(mongo.testdb.bike.find(  { "count":   {"$gt":5}  }).count())

for doc in mongo.testdb.bike.find({"count":   {"$gt":5}  }).limit(5):
    print(doc)
