# -*- coding: utf-8 -*-
"""
Created on Wed May 23 11:05:12 2018

@author: ktm
"""

from sklearn.model_selection import train_test_split
from sklearn.decomposition import PCA
from sklearn.cluster import KMeans
import matplotlib.pyplot as plt
import matplotlib
import numpy as np
%matplotlib inline

from matplotlib import font_manager, rc
font_loc = "C:/Windows/Fonts/malgunbd.ttf"
font_name = font_manager.FontProperties(fname=font_loc).get_name()
matplotlib.rc('font', family=font_name)

from sklearn.datasets import fetch_lfw_people
people = fetch_lfw_people(min_faces_per_person = 20, resize = 0.7)
image_shape = people.images[0].shape
image_shape

fig, axes = plt.subplots(2,5, figsize=(15,8), 
                         subplot_kw = {'xticks':(), 'yticks':()})
for target, image, ax in zip(people.target, people.images, axes.ravel()):
    ax.imshow(image)
    ax.set_title(people.target_names[target])
    
mask = np.zeros(people.target.shape, dtype=np.bool)
for target in np.unique(people.target):
    mask[np.where(people.target == target)[0][:50]] = 1

X_people = people.data[mask]
y_people = people.target[mask]
X_people = X_people / 255

people_tr, people_te, y_tr, y_te = train_test_split(
        X_people, y_people, stratify=y_people, random_state= 0)

kmeans = KMeans(n_clusters=100, random_state=0).fit(people_tr)
pca = PCA(n_components = 100, random_state=0).fit(people_tr)

pca.transform(people_te).shape

X_re_pca = pca.inverse_transform(pca.transform(people_te))
X_re_pca.shape
X_re_kmeans = kmeans.cluster_centers_[kmeans.predict(people_te)]
print(X_re_pca.shape, X_re_kmeans.shape)
axes.T.shape
kmeans_c = kmeans.cluster_centers_
pca_com = pca.components_
fig, axes = plt.subplots(2, 5, figsize=(8,8), 
                         subplot_kw={'xticks':(), 'yticks':()})
fig.suptitle("components")
for ax, comp_kmeans, comp_pca in zip(axes.T, kmeans_c, pca_com):
    ax[0].imshow(comp_kmeans.reshape(image_shape))
    ax[1].imshow(comp_pca.reshape(image_shape))

fig, axes = plt.subplots(3, 5, figsize=(8,8), 
                         subplot_kw={'xticks':(), 'yticks':()})
fig.suptitle("rerere")
for ax, orig, rec_kmeans, rec_pca in zip(
        axes.T, people_te, X_re_kmeans, X_re_pca):
    ax[0].imshow(orig.reshape(image_shape))
    ax[1].imshow(rec_kmeans.reshape(image_shape))
    ax[2].imshow(rec_pca.reshape(image_shape))

axes[0,0].set_ylabel('origin')
axes[1,0].set_ylabel('kmeans')
axes[2,0].set_ylabel('pca')


