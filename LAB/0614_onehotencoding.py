# -*- coding: utf-8 -*-
"""
Created on Thu Jun 14 12:15:50 2018

@author: Jeon
"""

import pandas as pd
data = { "target": ["b","c", "a", "d"], 
        "Value1":[2,3,8,4],
        "Value2":[22,32,82,42]}
df = pd.DataFrame(data)
df

from sklearn import preprocessing
label_encoder = preprocessing.LabelEncoder()
onehot_encoder = preprocessing.OneHotEncoder()

train_y = label_encoder.fit_transform(df['target'])
print(train_y)
print(train_y.shape)

train_y = train_y.reshape(len(train_y),1)
train_y = onehot_encoder.fit_transform(train_y)
print(train_y)
print(train_y.shape)
type(df)
type(train_y)


txt = ['spring', 'summer', 'autumn', 'winter']
txt_y = label_encoder.fit_transform(txt)
print(txt_y.shape)
txt_y = txt_y.reshape(len(txt_y), 1)
txt_y = onehot_encoder.fit_transform(txt_y)
print(txt_y)
print(txt_y.shape)


from numpy import argmax
# define input string
data = 'hello world'
print(data)
# define universe of possible input values
alphabet = 'abcdefghijklmnopqrstuvwxyz '
# define a mapping of chars to integers
char_to_int = dict((c, i) for i, c in enumerate(alphabet))
int_to_char = dict((i, c) for i, c in enumerate(alphabet))
# integer encode input data
integer_encoded = [char_to_int[char] for char in data]
print(integer_encoded)
# one hot encode
onehot_encoded = list()
for value in integer_encoded:
    letter = [0 for _ in range(len(alphabet))]
    letter[value] = 1
    onehot_encoded.append(letter)
print(onehot_encoded)
# invert encoding
inverted = int_to_char[argmax(onehot_encoded[0])]
print(inverted)

from numpy import array
from numpy import argmax
from sklearn.preprocessing import LabelEncoder
from sklearn.preprocessing import OneHotEncoder
data = ['spring', 'spring', 'summer', 'spring', 'autumn',
        'autumn', 'winter', 'spring', 'summer', 'autumn']
values = array(data)
print(values)
# integer encode
label_encoder = LabelEncoder()
integer_encoded = label_encoder.fit_transform(values)
print(integer_encoded)
# binary encode
onehot_encoder = OneHotEncoder(sparse=False)
integer_encoded = integer_encoded.reshape(len(integer_encoded), 1)
onehot_encoded = onehot_encoder.fit_transform(integer_encoded)
print(onehot_encoded)
# LabelEncoder에 입력하여 역변환 4번째 행의 값을 되돌리기
inverted = label_encoder.inverse_transform([argmax(onehot_encoded[4, :])])
print(inverted)


