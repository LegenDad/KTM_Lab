# -*- coding: utf-8 -*-
"""
Created on Fri May 11 10:33:27 2018

@author: ktm
"""

import mglearn
mglearn.plots.plot_animal_tree()

from sklearn.tree import DecisionTreeClassifier
from sklearn.model_selection import train_test_split
from sklearn.datasets import load_breast_cancer

def testTreeModel(TestSize = 0.3):
    cancer = load_breast_cancer()
    can_tr, can_te, y_tr, y_te = train_test_split(cancer.data, 
                                                  cancer.target, 
                                                  stratify = cancer.target,
                                                  test_size = TestSize,
                                                  random_state = 77)
    tree = DecisionTreeClassifier(random_state = 0).fit(can_tr, y_tr)
    print(f"train set accuracy : {tree.score(can_tr, y_tr):.3f}")
    print(f"test set accuracy : {tree.score(can_te, y_te):.3f}")
    
testTreeModel(0.3)
testTreeModel(0.2)
testTreeModel(0.1)


for i in range(0,9):
    print((i+1)/10)
    testTreeModel((i+1)/10)
    
    
def testTreeModel2(TestSize = 0.3, treedepth = 3):
    cancer = load_breast_cancer()
    can_tr, can_te, y_tr, y_te = train_test_split(cancer.data, 
                                                  cancer.target, 
                                                  stratify = cancer.target,
                                                  test_size = TestSize,
                                                  random_state = 77)
    tree = DecisionTreeClassifier(max_depth=treedepth, 
                                  random_state = 0).fit(can_tr, y_tr)
    print(f"train set accuracy : {tree.score(can_tr, y_tr):.3f}")
    print(f"test set accuracy : {tree.score(can_te, y_te):.3f}")


for i in range(0,9):
    print((i+1)/10)
    testTreeModel2((i+1)/10, 4)
