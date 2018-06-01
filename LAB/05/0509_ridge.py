# -*- coding: utf-8 -*-
"""
Created on Wed May  9 11:16:24 2018

@author: ktm
"""

from sklearn.datasets import load_boston
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LinearRegression
from sklearn.preprocessing import MinMaxScaler, PolynomialFeatures
from sklearn.linear_model import Ridge
import matplotlib.pyplot as plt

# 한글
import matplotlib
from matplotlib import font_manager, rc
font_loc = "C:/Windows/Fonts/malgunbd.ttf"
font_name = font_manager.FontProperties(fname=font_loc).get_name()
matplotlib.rc('font', family=font_name)
#%matplotlib inline

def load_extended_boston():
    boston = load_boston() # 데이터 셋 불러오기
    X = boston.data # 입력 데이터
    X = MinMaxScaler().fit_transform(boston.data) # 입력 데이터 정규화
    X = PolynomialFeatures(degree=2, include_bias=False).fit_transform(X)
    return X, boston.target

X, y = load_extended_boston()
print(X.shape, y.shape)

boston_tr, boston_te, y_tr, y_te = train_test_split(X, y, random_state= 42)
lr = LinearRegression().fit(boston_tr, y_tr)
print(f"train set score : {lr.score(boston_tr, y_tr):.2f}")
print(f"test set score : {lr.score(boston_te, y_te):.2f}")

ridge = Ridge().fit(boston_tr, y_tr)
print(f"train set score : {ridge.score(boston_tr, y_tr):.2f}")
print(f"test set score : {ridge.score(boston_te, y_te):.2f}")


ridge2 = Ridge(0.1).fit(boston_tr, y_tr)
print(f"train set score : {ridge2.score(boston_tr, y_tr):.2f}")
print(f"test set score : {ridge2.score(boston_te, y_te):.2f}")


ridge3 = Ridge(5).fit(boston_tr, y_tr)
print(f"train set score : {ridge3.score(boston_tr, y_tr):.2f}")
print(f"test set score : {ridge3.score(boston_te, y_te):.2f}")


ridge4 = Ridge(0.01).fit(boston_tr, y_tr)
print(f"train set score : {ridge4.score(boston_tr, y_tr):.2f}")
print(f"test set score : {ridge4.score(boston_te, y_te):.2f}")

ridge5 = Ridge(0.05).fit(boston_tr, y_tr)
print(f"train set score : {ridge5.score(boston_tr, y_tr):.2f}")
print(f"test set score : {ridge5.score(boston_te, y_te):.2f}")

ridge6 = Ridge(0.00001).fit(boston_tr, y_tr)
print(f"train set score : {ridge6.score(boston_tr, y_tr):.2f}")
print(f"test set score : {ridge6.score(boston_te, y_te):.2f}")

ridge5.coef_

lr.coef_[1:10]
ridge5.coef_[1:10]


plt.plot(lr.coef_, "^", label = "No Ridge")
plt.plot(ridge6.coef_, "^", label = "Ridge alpha = 0.0001")
plt.plot(ridge2.coef_, "^", label = "Ridge alpha = 0.01")
plt.ylim(-25, 25)
plt.hlinse(0,0, len(lr.coef_))
plt.legend()