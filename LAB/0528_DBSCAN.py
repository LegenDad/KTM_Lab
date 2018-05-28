# -*- coding: utf-8 -*-
"""
Created on Mon May 28 11:13:17 2018

@author: ktm
"""

import mglearn
from sklearn.datasets import make_blobs
import matplotlib.pyplot as plt
import pandas as pd
import numpy as np

from matplotlib import font_manager, rc
font_loc = "C:/Windows/Fonts/malgunbd.ttf"
font_name = font_manager.FontProperties(fname=font_loc).get_name()
matplotlib.rc('font', family=font_name)


mglearn.plots.plot_dbscan()

from sklearn.cluster import DBSCAN
from sklearn.datasets import make_moons
from sklearn.preprocessing import StandardScaler

X, y = make_moons(n_samples = 200, noise=0.05, random_state=0)

X_scaled = StandardScaler().fit_transform(X)
clusters = DBSCAN().fit_predict(X_scaled)

plt.scatter(X_scaled[:,0], X_scaled[:,1], 
            c = clusters, cmap = mglearn.cm2, 
            s= 60, edgecolors='black')
plt.legend(['clusters 0', 'clusters 1'], loc='best')
plt.xlabel('특성 0')
plt.ylabel('특성 1')
