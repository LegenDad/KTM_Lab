# -*- coding: utf-8 -*-
"""
Created on Tue Jun  5 10:10:05 2018

@author: Jeon
"""

import pandas as pd
tr = pd.read_csv("E:/BigData/Data/House.Price/train.csv")
print(tr.shape, tr.info())
tr.head()
# MSSubClass
# OverallQual
# OverallCond
# BsmtFinSF1
# BsmtFinSF2

selCol = ['MSSubClass' , 'OverallQual', 'OverallCond', 'BsmtFinSF1', 'BsmtFinSF2']
X = tr[selCol]
X.head()

x1 = X['MSSubClass'].values
x2 = X['OverallQual'].values
x3 = X['OverallCond'].values
x4 = X['BsmtFinSF1'].values
x5 = X['BsmtFinSF2'].values


import numpy as np
w1 = np.random.uniform(low=0.0, high =1.0)
w2 = np.random.uniform(low=0.0, high =1.0)
w3 = np.random.uniform(low=0.0, high =1.0)
w4 = np.random.uniform(low=0.0, high =1.0)
w5 = np.random.uniform(low=0.0, high =1.0)

y = tr['SalePrice'].values
print(X.head(),y[1:5] )

num_epoch = 10000
lr_rate = 0.000001

for epoch in range(num_epoch):
    y_predict = x1 * w1 + \
                x2 * w2 + \
                x3 * w3 + \
                x4 * w4 + \
                x5 * w5
    
    error = np.abs(y_predict - y).mean()
    if error < 3:
        break
    w1 = w1 - lr_rate * ((y_predict - y) * x1).mean()
    w2 = w2 - lr_rate * ((y_predict - y) * x2).mean()
    w3 = w3 - lr_rate * ((y_predict - y) * x3).mean()
    w4 = w4 - lr_rate * ((y_predict - y) * x4).mean()
    w5 = w5 - lr_rate * ((y_predict - y) * x5).mean()
    
    if epoch % 1000 == 0:
        print("{0} error = {1}".format(epoch, error))
        print(w1,w2,w3,w4,w5)
        print()
        
print("{0} error={1}".format(epoch, error))
print(w1,w2,w3,w4,w5)

result = tr.copy()
y_predict = x1 * w1 + \
            x2 * w2 + \
            x3 * w3 + \
            x4 * w4 + \
            x5 * w5
            
result["SalePrice(predict)"] = y_predict
result.head()

w = np.random.uniform(low=0.0, high =1.0, size=5)
w.shape
num_epoch = 10000
lr_rate = 0.0000000001

for epoch in range(num_epoch):
    y_predict = X.dot(w)
    error = np.abs(y_predict - y).mean()
    if error < 3:
        break
    w = w - lr_rate * X.T.dot(y_predict - y).mean()
    
    if epoch % 1000 == 0:
        print("{0} error = {1}".format(epoch, error))
        print(w)
        print()

y_predict = X.dot(w)