# -*- coding: utf-8 -*-
"""
Created on Fri Jun  8 09:34:36 2018

@author: Jeon
"""

import pymongo
import datetime
    
mongo = pymongo.MongoClient("localhost", 27017)
mongo.database_names()
mongo.testdb06.collection_names()

mongo.testdb06.col01.insert({"author":"Tomi", 
                             "text":"MY fist blog post!", 
                             "tags":["mongodb", "python", "data"], 
                             "date": datetime.datetime.utcnow()})

mongo.database_names()
mongo.testdb06.collection_names()

for doc in mongo.testdb06.col01.find():
    print(doc)


mongo.testdb06.posts.insert([{"author" : "Mike", 
                             "text"   : "Another Post!",
                             "tags"   : ["bulk", "insert"],
                             "date"   : datetime.datetime(2018, 6, 8, 10, 11)}, 
                            {"author" : "Eliot",
                             "title"  : "Python is fun!",
                             "text"   : "Today is good!",
                             "date"   : datetime.datetime(2018, 6, 8, 10, 11)}])

mongo.testdb06.collection_names()
for doc in mongo.testdb06.posts.find():
    print(doc)


mongo.testdb06.posts.find_one()

mongo.testdb06.posts.count()
mongo.testdb06.posts.find({"author":"Tomi"}).count()

import pymongo
def get_db():
    mongo = pymongo.MongoClient('localhost', 27017)
    db = mongo.testdb06

def add_country(db):
    db.countries.insert_one({"name":"Canada"})
    
def get_country(db):
    return db.countries.find_one()

if __name__ == "__main__":
    db = get_db() 
    add_country(db)
    print(get_country(db))


