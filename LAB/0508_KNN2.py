# -*- coding: utf-8 -*-
"""
Created on Tue May  8 12:09:07 2018

@author: ktm
"""

import pandas as pd
import matplotlib.pyplot as plt
from pandas.tools.plotting import scatter_matrix
from sklearn import model_selection
from sklearn.metrics import classification_report
from sklearn.metrics import confusion_matrix
from sklearn.metrics import accuracy_score
from sklearn.linear_model import LogisticRegression
from sklearn.tree import DecisionTreeClassifier
from sklearn.neighbors import KNeighborsClassifier
from sklearn.naive_bayes import GaussianNB
from sklearn.svm import SVC


url = "https://archive.ics.uci.edu/ml/machine-learning-databases/iris/iris.data"
names = ['sepal-length', 'sepal-width', 'petal-length', 'petal-width', 'class']
dataset = pd.read_csv(url, names=names)

dataset.info()
dataset.head()
dataset.describe()
dataset.groupby('class').size()
dataset.plot(kind = 'box', 
             subplots = True, 
             layout = (2,2), 
             sharex = False, 
             sharey = False)
plt.show()
dataset.plot(kind = 'line', 
             subplots = True, 
             layout = (4,1), 
             sharex = True, 
             sharey = True)

scatter_matrix(dataset)

array = dataset.values
type(array)
X = array[:,0:4]
Y = array[:,4]
validation_size = 0.2
seed = 7
X_train, X_test, y_train, y_test = model_selection.train_test_split(X, 
                                                                   Y, 
                                                                   test_size = validation_size, 
                                                                   random_state = seed)
models = []
models.append(('LogisticReg', LogisticRegression()))
models.append(('Tree', DecisionTreeClassifier()))
models.append(('KNN', KNeighborsClassifier()))
models.append(('NaiveBayes', GaussianNB()))
models.append(('SVC', SVC()))
models



results = []
names = []


for name, model in models:
    kfold = model_selection.KFold(n_splits=10, random_state=seed)
    cv_results = model_selection.cross_val_score(model, X_train, y_train, cv=kfold, scoring="accuracy") # 교차검증
    results.append(cv_results)
    names.append(name)
    msg = "%s: %f (%f)" % (name, cv_results.mean(), cv_results.std())
    print(msg)

print(X_test.shape)
knn = KNeighborsClassifier()
knn.fit(X_train, y_train)
pred = knn.predict(X_test) # 예측 수행
print(accuracy_score(y_test, pred)) # 정확도
print(confusion_matrix(y_test, pred)) # confusion matrix
print(classification_report(y_test, pred)) # 평가지표 정리


