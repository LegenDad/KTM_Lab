# -*- coding: utf-8 -*-
"""
Created on Tue May  8 10:41:11 2018

@author: ktm
"""

from sklearn.datasets import load_breast_cancer
import matplotlib.pyplot as plt
from sklearn.model_selection import train_test_split
from sklearn.neighbors import KNeighborsClassifier
import matplotlib.pyplot as plt

cancer = load_breast_cancer()
cancer
print(f"cancer.keys() :\n{cancer.keys()}")
print(f"cancer.data.shape :\n{cancer.data.shape}")
print(f"target : {cancer.target_names}")

cancer_tr, cancer_te, y_tr, y_te = train_test_split(
        cancer.data, 
        cancer.target, 
        random_state = 777)

print("tr size : {0}{1}".format(cancer_tr.shape, y_tr.shape))
print(f"tr size : {cancer_tr.shape}{y_tr.shape}")
print(f"tr size : {cancer_te.shape}{y_te.shape}")


training_accuracy = []
test_accuracy = []
neighbors_settings = range(1, 11)
for n in neighbors_settings:
    clf = KNeighborsClassifier(n_neighbors=n)
    clf.fit(cancer_tr, y_tr)
    score_tr = clf.score(cancer_tr, y_tr)
    score_test = clf.score(cancer_te, y_te)
    training_accuracy.append(score_tr)
    test_accuracy.append(score_test)
    print(f"k : {n}")
    print(f"accuarcy of train : {score_tr:.4f}")
    print(f"accuracy of test : {socre_test:.4f}")
    
print(f"train set accuracy : \n{training_accuracy}")
print(f"test set accuracy : \n{test_accuracy}")
#help(plt.plot)
plt.plot(training_accuracy, test_accuracy, 'bo')
plt.plot(neighbors_settings, training_accuracy, label = 'Training Set')
plt.plot(neighbors_settings, test_accuracy, label = 'Test Set')
plt.legend()




