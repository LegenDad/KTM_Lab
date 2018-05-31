# -*- coding: utf-8 -*-
"""
Created on Thu May 31 09:09:26 2018

@author: Jeon
"""

!pip search pymongo
!pip install pymongo

import pymongo
mgclient = pymongo.MongoClient("localhost", 27017)

# check start mogodb (mongod)
mgclient.database_names()
testdb = mgclient.testdb
testdb_col = testdb.items


data= { "name":"cola", "pty":5, "price":500}
testdb_col.insert(data)

testdb.supermarket.insert(data)

print(mgclient.database_names())

for doc in testdb.supermarket.find():
    print(doc)

games
heros Tracer
userNum


tracer = {"games":"Overwatch", "hero":"Tracer", "userNum":8888}
testdb.games.insert(tracer)

for doc in testdb.games.find():
    print(doc)
