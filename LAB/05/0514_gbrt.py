# -*- coding: utf-8 -*-
"""
Created on Mon May 14 12:18:48 2018

@author: ktm
"""

from sklearn.model_selection import train_test_split
from sklearn.datasets import load_breast_cancer
import matplotlib.pyplot as plt
import numpy as np
%matplotlib inline


def plot_feature_importances_cancer(model):
    n_features = cancer.data.shape[1]
    plt.barh(range(n_features), model.feature_importances_, align='center')
    plt.yticks(np.arange(n_features), cancer.feature_names)
    plt.xlabel("특성 중요도")
    plt.ylabel("특성")
    plt.ylim(-1, n_features)
### 한글

import matplotlib
from matplotlib import font_manager, rc
font_loc = "C:/Windows/Fonts/malgunbd.ttf"
font_name = font_manager.FontProperties(fname=font_loc).get_name()
matplotlib.rc('font', family=font_name)


from sklearn.ensemble import GradientBoostingClassifier
cancer = load_breast_cancer()
X_train, X_test, y_train, y_test = train_test_split(cancer.data, cancer.target, random_state=0)
gbrt = GradientBoostingClassifier(random_state=0)
gbrt.fit(X_train, y_train)
print("훈련 세트 정확도: {:.3f}".format(gbrt.score(X_train, y_train)))
print("테스트 세트 정확도: {:.3f}".format(gbrt.score(X_test, y_test)))

gbrt = GradientBoostingClassifier(random_state=0, max_depth=1)
gbrt.fit(X_train, y_train)
print("훈련 세트 정확도: {:.3f}".format(gbrt.score(X_train, y_train)))
print("테스트 세트 정확도: {:.3f}".format(gbrt.score(X_test, y_test)))

gbrt = GradientBoostingClassifier(random_state=0, learning_rate=0.01)
gbrt.fit(X_train, y_train)
print("훈련 세트 정확도: {:.3f}".format(gbrt.score(X_train, y_train)))
print("테스트 세트 정확도: {:.3f}".format(gbrt.score(X_test, y_test)))

gbrt = GradientBoostingClassifier(random_state=0, max_depth=1)
gbrt.fit(X_train, y_train)
plot_feature_importances_cancer(gbrt)


for i in range(1,6):
    gbrt = GradientBoostingClassifier(random_state=0, max_depth=i)
    gbrt.fit(X_train, y_train)
    print(f"max_depth : {i}")
    print("훈련 세트 정확도: {:.3f}".format(gbrt.score(X_train, y_train)))
    print("테스트 세트 정확도: {:.3f}".format(gbrt.score(X_test, y_test)))
    

for i in range(1,10):
    gbrt = GradientBoostingClassifier(random_state=0, max_depth=1, learning_rate=i/100)
    gbrt.fit(X_train, y_train)
    print(f"learning_rate : {i/100}")
    print("훈련 세트 정확도: {:.3f}".format(gbrt.score(X_train, y_train)))
    print("테스트 세트 정확도: {:.3f}".format(gbrt.score(X_test, y_test)))



