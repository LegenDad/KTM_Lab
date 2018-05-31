# -*- coding: utf-8 -*-
"""
Created on Thu May 31 10:03:00 2018

@author: Jeon
"""

from sklearn.datasets import load_iris
import pymongo

iris = load_iris()
iris.data
iris.feature_names
iris.target
iris.target_names

mongo = pymongo.MongoClient("localhost", 27017)
mongo.database_names()

len(iris.data)

for x in range(0, len(iris.data)):
    mongo.testdb.iris.insert({"SepalLength":iris.data[x][0],
                              "SepalWidth":iris.data[x][1], 
                              "PetalLength":iris.data[x][2],
                              "PetalWidth":iris.data[x][3],
                              "Species":int(iris.target[x])})
                              
    
for x in range(0,len(iris.target_names)):
    mongo.testdb.iris.update_many(
            {"Species":x}, {"$set": {"Species":iris.target_names[x]}})

