# -*- coding: utf-8 -*-
"""
Created on Thu May 17 11:42:57 2018

@author: ktm
"""

import numpy as np
import matplotlib.pyplot as plt
from sklearn.datasets import load_iris
from sklearn.model_selection import train_test_split
from sklearn.neighbors import KNeighborsClassifier

iris_data = load_iris()
iris_data.keys()
iris_data.items()
iris_data.values()
iris_data['data']
iris_data['target']
iris_data['target_names']
iris_data['feature_names']

iris_tr, iris_te, y_tr, y_te = train_test_split(
        iris_data['data'], 
        iris_data['target'], 
        random_state = 0)


knn = KNeighborsClassifier(n_neighbors=1).fit(iris_tr, y_tr)
print(f"knn score : {knn.score(iris_te, y_te)}")

pca = PCA(n_components = 2, whiten = True, random_state=0).fit(iris_tr)
iris_tr_pca = pca.transform(iris_tr)
iris_te_pca = pca.transform(iris_te)

knn_pca = KNeighborsClassifier(n_neighbors=2).fit(iris_tr_pca, y_tr)
print(f"pca knn score : {knn_pca.score(iris_te_pca, y_te):.3f}")

