# -*- coding: utf-8 -*-
"""
Created on Wed May 16 10:39:03 2018

@author: ktm
"""

import numpy as np
import matplotlib.pyplot as plt
from sklearn.datasets import fetch_lfw_people
from sklearn.neighbors import KNeighborsClassifier
from sklearn.model_selection import train_test_split
import mglearn
from sklearn.decomposition import PCA


# 한글
import matplotlib
from matplotlib import font_manager, rc
font_loc = "C:/Windows/Fonts/malgunbd.ttf"
font_name = font_manager.FontProperties(fname=font_loc).get_name()
matplotlib.rc('font', family=font_name)
%matplotlib inline

people2 = fetch_lfw_people(min_faces_per_person = 20, resize= 0.7, color = True)
people = fetch_lfw_people(min_faces_per_person = 20, resize= 0.7)
people
image_shape  = people.images[0].shape


people['images'].shape
print(people.data)
print(people.target.shape)
print(people.target_names)
print(people.images)
print(people.images.shape)

fig, axes = plt.subplots(3, 4, figsize=(15, 8), 
                         subplot_kw={'xticks':(), 'yticks':()})
for target, image, ax in zip(people.target, people.images, axes.ravel()):
    ax.imshow(image)
    ax.set_title(people.target_names[target])
fig, axes = plt.subplots(3, 4, figsize=(15, 8), 
                         subplot_kw={'xticks':(), 'yticks':()})
for target, image, ax in zip(people2.target, people2.images, axes.ravel()):
    ax.imshow(image)
    ax.set_title(people2.target_names[target])



mask = np.zeros(people.target.shape, dtype=np.bool)
mask
print(people.target)
print(np.unique(people.target))
print(np.where(people.target == target)[0][:50])

for target in np.unique(people.target):
    mask[np.where(people.target == target)[0][:50]] = 1

mask
mask[mask==1, ].shape

X_people = people.data[mask]
y_people = people.target[mask]
print(X_people.shape, y_people.shape)

X_people = X_people /255


pp_tr, pp_te, y_tr, y_te = train_test_split(X_people, y_people, 
                                            stratify = y_people, 
                                            random_state = 0)

knn = KNeighborsClassifier(n_neighbors = 1).fit(pp_tr, y_tr)

print(f"knn test score : {knn.score(pp_te, y_te):.3f}")

import mglearn
mglearn.plots.plot_pca_whitening()

pca = PCA(n_components = 100, whiten = True, random_state=0).fit(pp_tr)
pp_tr_pca = pca.transform(pp_tr)
pp_te_pca = pca.transform(pp_te)

print(f"pp_tr_pca.shape : {pp_tr_pca.shape}")
pp_tr.shape

knn = KNeighborsClassifier(n_neighbors=1).fit(pp_tr_pca, y_tr)
print(f"pca test score : {knn.score(pp_te_pca, y_te):.3f}")

pca.components_
pca.components_.shape

fig, axes = plt.subplots(6, 5, figsize=(15, 12), 
                         subplot_kw = {'xticks':(), 'yticks':()})

a1 = pca.components_
a2 = axes.ravel()
for i, (com, ax) in enumerate(zip(a1, a2)):
    ax.imshow(com.reshape(image_shape), cmap = 'viridis')
    ax.set_title('주성분 {}'.format((i+1)))

mglearn.plots.plot_pca_faces(pp_tr, pp_te, image_shape)


