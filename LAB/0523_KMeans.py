# -*- coding: utf-8 -*-
"""
Created on Wed May 23 10:06:24 2018

@author: ktm
"""

import mglearn
import matplotlib
import matplotlib.pyplot as plt
%matplotlib inline
from matplotlib import font_manager, rc
font_loc = "C:/Windows/Fonts/malgunbd.ttf"
font_name = font_manager.FontProperties(fname=font_loc).get_name()
matplotlib.rc('font', family=font_name)

mglearn.plots.plot_kmeans_algorithm()
mglearn.plots.plot_kmeans_boundaries()

from sklearn.datasets import make_blobs
from sklearn.cluster import KMeans
import numpy as np

X, y = make_blobs(random_state = 1)
X
y
print(X.shape, y.shape)

kmeans = KMeans(n_clusters=3).fit(X)

print(f"cluster label : \n{kmeans.labels_}")
print(kmeans.predict(X))

mglearn.discrete_scatter(X[:,0], X[:,1], 
                         kmeans.labels_, 
                         markers = 'o')
cen = kmeans.cluster_centers_
mglearn.discrete_scatter(cen[:,0], cen[:,1], 
                         [0,1,2], 
                         markers = '^')



fig, axes = plt.subplots(1,2, figsize=(10,5))
kmeans2 = KMeans(n_clusters = 2).fit(X)
kmeans5 = KMeans(n_clusters = 5).fit(X)
cen2 = kmeans2.cluster_centers_
cen5 = kmeans5.cluster_centers_

mglearn.discrete_scatter(X[:,0], X[:,1], 
                         kmeans2.labels_, 
                         markers = 'o', 
                         ax=axes[0])

mglearn.discrete_scatter(X[:,0], X[:,1], 
                         kmeans5.labels_, 
                         markers = 'o', ax=axes[1])


X, y = make_blobs(random_state = 170, n_samples = 600)
print(X.shape, y.shape)

kmeans = KMeans(n_clusters=3).fit(X)
mglearn.discrete_scatter(X[:,0], X[:,1], 
                         kmeans.labels_, 
                         markers = 'o')
cen = kmeans.cluster_centers_
mglearn.discrete_scatter(cen[:,0], cen[:,1], 
                         [0,1,2], 
                         markers = '^')

rng = np.random.RandomState(74)
transformation = rng.normal(size=(2,2))
X = np.dot(X, transformation)
X.shape
kmeans = KMeans(n_clusters=3).fit(X)
mglearn.discrete_scatter(X[:,0], X[:,1], 
                         kmeans.labels_, 
                         markers = 'o')

