# -*- coding: utf-8 -*-
"""
Created on Tue May 29 11:05:40 2018

@author: Jeon
"""

from sklearn.datasets import make_moons
import matplotlib.pyplot as plt
import mglearn
import numpy as np
from sklearn.preprocessing import StandardScaler
from sklearn.metrics.cluster import adjusted_rand_score

import matplotlib
from matplotlib import font_manager, rc
font_loc = "C:/Windows/Fonts/malgunbd.ttf"
font_name = font_manager.FontProperties(fname=font_loc).get_name()
rc('font', family = font_name)

X, y = make_moons(n_samples=200, noise=0.05, random_state=0)
print(X[1:15], y[1:15])
np.mean(X)
np.std(X)
format(-5.551115123125783e-18, '.18f')
X_scaled = StandardScaler().fit_transform(X)
np.mean(X_scaled)
np.std(X_scaled)

fig, axes = plt.subplots(1,2, figsize=(10,3), subplot_kw = {'xticks':(), 'yticks':()})
axes[0].scatter(X[:,0], X[:,1])
axes[1].scatter(X_scaled[:,0], X_scaled[:,1])

from sklearn.cluster import AgglomerativeClustering, KMeans, DBSCAN
algor = [KMeans(n_clusters = 2), 
         AgglomerativeClustering(n_clusters=2), 
         DBSCAN()]

random_state = np.random.RandomState(seed=0)
random_clusters = random_state.randint(low=0, high=2, size=len(X))
random_clusters

plt.scatter(X_scaled[:,0], X_scaled[:,1], c=random_clusters, cmap=mglearn.cm3, 
            s= 60, edgecolor='black')
score = adjusted_rand_score(y, random_clusters)
plt.title(f"Random ARI Score :{score:.4f}")

fig, axes = plt.subplots(1, 4, figsize=(11,3), subplot_kw = {'xticks':(), 'yticks':()})
axes[0].scatter(X_scaled[:,0], X_scaled[:,1], c=random_clusters, cmap=mglearn.cm3, 
            s= 60, edgecolor='black')
for ax, algors in zip(axes[1:], algor):
    clusters = algors.fit_predict(X_scaled)
    ax.scatter(X_scaled[:,0], X_scaled[:,1], c=clusters, cmap=mglearn.cm3, 
            s= 60, edgecolor='black')
    ax.set_title("{}-ARI:{:.2f}".format(algors.__class__.__name__, 
                 adjusted_rand_score(y, clusters)))
    
