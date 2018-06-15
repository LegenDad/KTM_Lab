# -*- coding: utf-8 -*-
"""
Created on Fri Jun 15 11:07:55 2018

@author: Jeon
"""

import pandas as pd
train = pd.read_csv("E:/BigData/Data/Titanic/train.csv", index_col=["PassengerId"])
print(train.shape)
train.head()

test = pd.read_csv("E:/BigData/Data/Titanic/test.csv", index_col=["PassengerId"])
print(test.shape)
test.head()

train.loc[train["Sex"] == "male", "Sex"] = 0
train.loc[train["Sex"] == "female", "Sex"] = 1
print(train.shape)
train.head()
train.info()
tr_mean_age = train["Age"].mean()
test_mean_age = test["Age"].mean()
train.loc[pd.isnull(train["Age"]), "Age"] = tr_mean_age
train[pd.isnull(train["Age"])]
test.loc[pd.isnull(test["Age"]), "Age"] = test_mean_age
test[pd.isnull(test["Age"])]

test_mean_Fare = test["Fare"].mean()
test.loc[pd.isnull(test["Fare"]), "Fare"] = test_mean_Fare
test[pd.isnull(test["Fare"])]

sel_col = ['Pclass' , 'Sex', 'Age', 'SibSp', 'Parch', 'Fare', 'Embarked' ]
X_train = train[sel_col]
X_train.head()
X_test = test[sel_col]
X_test.head()

X_train = pd.get_dummies(X_train)
X_train.head()

X_test = test[sel_col]
X_test = pd.get_dummies(X_test)
print(list(X_test.columns))
X_test.head()

from sklearn.linear_model import LogisticRegression
from sklearn.model_selection import train_test_split
from sklearn.metrics import accuracy_score

label_name = "Survived"
y_train = train[label_name]
print(X_train.shape, y_train.shape)

X_tr, X_te, y_tr, y_te = train_test_split(X_train, y_train, random_state=0)
print(X_tr.shape, y_tr.shape)
model = LogisticRegression()
model.fit(X_tr, y_tr)
prediction = model.predict(X_te)
prediction[1:5]
accuracy_score(y_te, prediction)

model.fit(X_train, y_train)
prediction = model.predict(X_train)
prediction[1:5]
accuracy_score(y_train, prediction)




prediction = model.predict(X_test)
prediction[1:5]
submission = pd.read_csv("D:/dataset/data_titanic/gender_submission.csv", index_col="PassengerId")
submission["Survived"] = prediction
print(submission.shape)
submission.head()
submission.to_csv("D:/dataset/data_titanic/result_script.csv")
