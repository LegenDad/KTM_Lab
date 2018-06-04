# -*- coding: utf-8 -*-
"""
Created on Mon Jun  4 10:40:40 2018

@author: Jeon
"""

from sklearn.datasets import load_boston
boston = load_boston()
X = boston['data']
y = boston['target']

print(boston['DESCR'])
print(boston['feature_names'])

import pandas as pd
data = pd.DataFrame(X, columns=boston['feature_names'])
data.head()

data['PRICE']=y
data.head()

x1 = data['CRIM'].values
x2 = data['ZN'].values
x3 = data['INDUS'].values
x4 = data['CHAS'].values
x5 = data['NOX'].values
x6 = data['RM'].values
x7 = data['AGE'].values
x8 = data['DIS'].values
x9 = data['RAD'].values
x10 = data['TAX'].values
x11 = data['PTRATIO'].values
x12 = data['B'].values
x13 = data['LSTAT'].values


import numpy as np
w1 = np.random.uniform(low=0.0, high =1.0)
w2 = np.random.uniform(low=0.0, high =1.0)
w3 = np.random.uniform(low=0.0, high =1.0)
w4 = np.random.uniform(low=0.0, high =1.0)
w5 = np.random.uniform(low=0.0, high =1.0)
w6 = np.random.uniform(low=0.0, high =1.0)
w7 = np.random.uniform(low=0.0, high =1.0)
w8 = np.random.uniform(low=0.0, high =1.0)
w9 = np.random.uniform(low=0.0, high =1.0)
w10 = np.random.uniform(low=0.0, high =1.0)
w11 = np.random.uniform(low=0.0, high =1.0)
w12 = np.random.uniform(low=0.0, high =1.0)
w13 = np.random.uniform(low=0.0, high =1.0)


num_epoch = 10000
learning_rate = 0.000005

for epoch in range(num_epoch):
    y_predict = w1*x1 + \
                w2*x2 + \
                w3*x3 + \
                w4*x4 + \
                w5*x5 + \
                w6*x6 + \
                w7*x7 + \
                w8*x8 + \
                w9*x9 + \
                w10*x10 + \
                w11*x11 + \
                w12*x12 + \
                w13*x13
    #err =  ((y_predict-y)**2).mean()
    err = np.abs(y_predict-y).mean()
    
    if err < 3:
        break
    
    w1 = w1 - learning_rate * ((y_predict - y) * x1).mean()
    w2 = w2 - learning_rate * ((y_predict - y) * x2).mean()
    w3 = w3 - learning_rate * ((y_predict - y) * x3).mean()
    w4 = w4 - learning_rate * ((y_predict - y) * x4).mean()
    w5 = w5 - learning_rate * ((y_predict - y) * x5).mean()
    w6 = w6 - learning_rate * ((y_predict - y) * x6).mean()
    w7 = w7 - learning_rate * ((y_predict - y) * x7).mean()
    w8 = w8 - learning_rate * ((y_predict - y) * x8).mean()
    w9 = w9 - learning_rate * ((y_predict - y) * x9).mean()
    w10 = w10 - learning_rate * ((y_predict - y) * x10).mean()
    w11 = w11 - learning_rate * ((y_predict - y) * x11).mean()
    w12 = w12 - learning_rate * ((y_predict - y) * x12).mean()
    w13 = w13 - learning_rate * ((y_predict - y) * x13).mean()
    
    
    if epoch % 1000 == 0:
        print("{0} error = {1}".format(epoch,err))
