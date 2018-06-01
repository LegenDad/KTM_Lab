# -*- coding: utf-8 -*-
"""
Created on Mon May 28 10:00:57 2018

@author: ktm
"""
#%%
import mglearn
from sklearn.datasets import make_blobs
import matplotlib.pyplot as plt
import numpy as np
from sklearn.cluster import AgglomerativeClustering
#%%
import matplotlib
from matplotlib import font_manager, rc
font_loc = "C:/Windows/fonts/malgunbd.ttf"
font_name = font_manager.FontProperties(fname=font_loc).get_name()
matplotlib.rc('font', family= font_name)

mglearn.plots.plot_agglomerative_algorithm()
mglearn.plots.plot_agglomerative()
#%%
X, y = make_blobs(random_state=1)

agg = AgglomerativeClustering(n_clusters=3)
assignment = agg.fit_predict(X)

mglearn.discrete_scatter(X[:,0], X[:,1], assignment)
plt.legend(['cluster0', 'cluster1','cluster2'], loc='best')
plt.xlabel('특성0')
plt.ylabel('특성1')
# %%
%matplotlib inline
agg1 = AgglomerativeClustering(n_clusters=3).fit_predict(X)
agg2 = AgglomerativeClustering(n_clusters=5).fit_predict(X)
fig = plt.figure(figsize=(8,5))
fig.add_subplot(1,2,1)
mglearn.discrete_scatter(X[:,0], X[:,1], agg1)
plt.legend(['cluster0', 'cluster1','cluster2'], loc='best')
fig.add_subplot(1,2,2)
mglearn.discrete_scatter(X[:,0], X[:,1], agg2)
plt.legend(['cluster0', 'cluster1','cluster2', 'cluster3', 'cluster4'], loc='best')
# %%
from scipy.cluster.hierarchy import dendrogram, ward
import pandas as pd
X, y = make_blobs()
df = pd.DataFrame(dict(x=X[:,0], y=X[:,1], label=y))
df.columns
# %%
linkage_array = ward(df[['x', 'y']])
linkage_array
dendrogram(linkage_array)

# %%

