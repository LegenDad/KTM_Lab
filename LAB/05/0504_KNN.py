# -*- coding: utf-8 -*-
"""
Spyder Editor

This is a temporary script file.
"""

import numpy as np
from scipy import linalg
import matplotlib.pyplot as plt
from sklearn.datasets import load_iris
from sklearn.model_selection import train_test_split
from sklearn.neighbors import KNeighborsClassifier
import pandas as pd

import scipy as sp
import sys
import sklearn
print("Python Version : {}".format(sys.version))
print("pd Version : {}".format(pd.__version__))
print("np Version : {}".format(np.__version__))
print("sp Version : {}".format(sp.__version__))
print("sklearn Version : {}".format(sklearn.__version__))


iris_dataset = load_iris()
iris_dataset.keys()
iris_dataset
iris_dataset.items()
iris_dataset.values()

fnames = iris_dataset['feature_names']
tnames = iris_dataset['target_names']
print("feature_names : {}".format(fnames))
print("target_names : {}".format(tnames))
print("target_names : ", fnames)
print(f"target_names : {tnames}")
x_train, x_test, y_train, y_test = train_test_split(
        iris_dataset['data'], 
        iris_dataset['target'], 
        test_size = 0.3, 
        train_size = 0.7, 
        random_state = 0)

print("x_train size : {}".format(x_train.shape))

#!pip install mglearn
#import mglearn

knn = KNeighborsClassifier(n_neighbors=1)
knn.fit(x_train, y_train)
x_new = np.array([[5, 2.9, 1, 0.2]])
print(x_new.shape)

prediction = knn.predict(x_new)
print(prediction)
print(iris_dataset['target_names'][prediction])


pred = knn.predict(x_test)
print(pred)
print(iris_dataset['target_names'][pred])

print(y_test == pred)
print(np.sum(y_test == pred))
print(f"accuray : {np.mean(y_test == pred)}")
print(f"accuray : {np.mean(y_test == pred):.2f}")

result == np.mean(y_test == pred)
print(f"accuray : {np.mean(y_test == pred):.2f}")
print(f"accuray : {knn.score(x_test, y_test):.3f}")




auc = 0.94752528
print("my auc :", auc)
print("my auc :{}".format(auc))
print(f"my_auc : {auc:.2f}")


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
