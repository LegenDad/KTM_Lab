# -*- coding: utf-8 -*-
"""
Created on Mon May 21 10:07:19 2018

@author: ktm
"""

import matplotlib.pyplot as plt
import matplotlib
from sklearn.datasets import load_digits
# 한글
from matplotlib import font_manager, rc
font_loc = "C:/Windows/Fonts/malgunbd.ttf"
font_name = font_manager.FontProperties(fname=font_loc).get_name()
matplotlib.rc('font', family=font_name)

digits = load_digits()
digits.images
digits.images.shape

fig, axes = matplotlib.pyplot.subplots(2, 5, figsize = (10, 5), 
                            subplot_kw = {'xticks':(), 'yticks':()}
                            )
for ax, img in zip(axes.ravel(), digits.images):
    ax.imshow(img)
    
print(digits.data.shape)
print(digits.data[1:5])
print(digits.DESCR)
print(digits.images[1:5])
print(digits.images.shape)
print(digits.target.shape)
print(digits.target_names)

##### PCA
from sklearn.decomposition import PCA
pca = PCA(n_components = 2).fit(digits.data)

digits_pca = pca.transform(digits.data)
colors = ["#476A2A", "#7851B8", "#BD3430", "#4A2D4E", "#875525",
          "#A83683", "#4E655E", "#853541", "#3A3120","#535D8E"]
plt.figure(figsize=(10,10))
plt.xlim(digits_pca[ :, 0].min(), digits_pca[:,0].max())
plt.ylim(digits_pca[ :, 1].min(), digits_pca[:,1].max())
for i in range(len(digits.data)):
    plt.text(digits_pca[i,0], 
             digits_pca[i,1], 
             str(digits.target[i]), 
             color = colors[digits.target[i]], 
             fontdict = {'weight':'bold', 'size':9})


##### t-SNE
from sklearn.manifold import TSNE
tsne = TSNE(random_state = 42).fit_transform(digits.data)
print(tsne[:,0].shape)
print(tsne[:,0].min(), tsne[:,0].max())
print(tsne[:,1].min(), tsne[:,1].max())

plt.figure(figsize=(10,10))
plt.xlim(tsne[:,0].min(), tsne[:,0].max() + 1)
plt.ylim(tsne[:,1].min(), tsne[:,1].max() + 1)
for i in range(len(digits.data)):
    plt.text(tsne[i,0], 
             tsne[i,1], 
             str(digits.target[i]), 
             color = colors[digits.target[i]], 
             fontdict = {'weight':'bold', 'size':9})
    plt.xlabel("t-SNE V1")
    plt.ylabel("t-SNE V2")


from sklearn.datasets import load_iris
from sklearn.decomposition import PCA
iris = load_iris()
iris.data
iris.target
iris.target_names
iris.feature_names
iris.DESCR
pca = PCA(n_components=2).fit(iris.data)
iris_pca = pca.transform(iris.data)
plt.figure(figsize=(3,3))
plt.xlim(iris_pca[ :, 0].min(), iris_pca[:,0].max())
plt.ylim(iris_pca[ :, 1].min(), iris_pca[:,1].max())
for i in range(len(iris.data)):
    plt.text(iris_pca[i,0], 
             iris_pca[i,1], 
             str(iris.target[i]), 
             color = colors[iris.target[i]], 
             fontdict = {'weight':'bold', 'size':9})
    
from sklearn.manifold import TSNE
tsne = TSNE(random_state = 42).fit_transform(iris.data)
plt.figure(figsize=(3,3))
plt.xlim(tsne[:,0].min(), tsne[:,0].max() + 1)
plt.ylim(tsne[:,1].min(), tsne[:,1].max() + 1)
for i in range(len(iris.data)):
    plt.text(tsne[i,0], 
             tsne[i,1], 
             str(iris.target[i]), 
             color = colors[iris.target[i]], 
             fontdict = {'weight':'bold', 'size':9})
    plt.xlabel("t-SNE V1")
    plt.ylabel("t-SNE V2")

plt.scatter(tsne[:, 0], tsne[:, 1], c=iris.target)
plt.scatter(iris_pca[:, 0], iris_pca[:, 1], c=iris.target)


plt.figure(figsize=(10, 5))
plt.subplot(221)
plt.scatter(tsne[:, 0], tsne[:, 1], c=iris.target)
plt.subplot(224)
plt.scatter(iris_pca[:, 0], iris_pca[:, 1], c=iris.target)
