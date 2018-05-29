# -*- coding: utf-8 -*-
"""
Created on Tue May 29 10:12:44 2018

@author: Jeon
"""

import numpy as np
x = np.array([1.0, 2.0, 3.0])
y = np.array([2.0, 4.0, 6.0])
type(x)
print(x/y)

A = np.array([[1,2], [3,4]])
B = np.array([10, 20])
A*B
C = np.array([[10,20],[10,10]])
A*C

import matplotlib.pyplot as plt
%matplotlib inline


from matplotlib.image import imread
img = imread("./LAB/feellucky.jpg")
print(img.shape)

plt.imshow(img)
img[1:3]
img[252]


plt.imshow(img[150:250])
plt.imshow(img[150:300,200:300])

