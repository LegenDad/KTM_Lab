# -*- coding: utf-8 -*-
"""
Created on Fri Jun 15 12:40:05 2018

@author: Jeon
"""

import pandas as pd
import mglearn
import numpy as np
import matplotlib.pyplot as plt


%matplotlib inline
### 한글
import matplotlib
from matplotlib import font_manager, rc
font_loc = "C:/Windows/Fonts/malgunbd.ttf"
font_name = font_manager.FontProperties(fname=font_loc).get_name()
matplotlib.rc('font', family=font_name)


df = pd.DataFrame({"number": [0,1,2,3,1],
                   "categorical":["양말", "사과", "상자", "귤", "수박"]})
display(df)
df.info()

df['number'] = df['number'].astype(str)
df.info()

display(pd.get_dummies(df, columns=['number', 'categorical']))

pd.get_dummies(df, columns=['number'])


from sklearn.linear_model import LinearRegression
from sklearn.tree import DecisionTreeRegressor
X, y = mglearn.datasets.make_wave(n_samples=100) 
line = np.linspace(-3, 3, 1000, endpoint=False).reshape(-1, 1)
print(line.shape)
print(line[1:5])

reg = DecisionTreeRegressor(min_samples_split=3).fit(X, y)
plt.plot(line, reg.predict(line), label="결정 트리")
reg = LinearRegression().fit(X, y)
plt.plot(line, reg.predict(line), '--', label="선형 회귀")
plt.plot(X[:, 0], y, 'o', c='k')
plt.ylabel("회귀 출력")
plt.xlabel("입력 특성")
plt.legend(loc="best")

bins = np.linspace(-3, 3, 11)   # -3부터 3까지 10개의 구간을 정의
print("bins: {}".format(bins))

which_bin = np.digitize(X, bins=bins)   # X의 각각의 값이 소속된 구간(정수)값 구하기
print("\n데이터 포인트:\n", X[:5])
print("\n데이터 포인트의 소속 구간:\n", which_bin[:5])   # -0.75275929는 -1.2~-0.6의 구간이다.

from sklearn.preprocessing import OneHotEncoder
# 변환을 위해 OneHotEncoder를 사용합니다
OneHot_encoder = OneHotEncoder(sparse=False)
# encoder.fit은 which_bin에 나타난 유일한 값을 찾습니다
OneHot_encoder.fit(which_bin)
# 원-핫-인코딩으로 변환합니다
X_binned = OneHot_encoder.transform(which_bin)
print(X_binned[:5])
print("X_binned.shape: {}".format(X_binned.shape))
line_binned = OneHot_encoder.transform(np.digitize(line, bins=bins))
print(line_binned)

reg = LinearRegression().fit(X_binned, y)
plt.plot(line, reg.predict(line_binned), label='구간 선형 회귀')
reg = DecisionTreeRegressor(min_samples_split=3).fit(X_binned, y)
plt.plot(line, reg.predict(line_binned), '--', label='구간 결정 트리')
plt.plot(X[:, 0], y, 'o', c='k')
plt.vlines(bins, -3, 3, linewidth=1, alpha=.2)
plt.legend(loc="best")
plt.ylabel("회귀 출력")
plt.xlabel("입력 특성")

rnd = np.random.RandomState(0)
X_org = rnd.normal(size=(1000, 3))   # 1000행, 3열의 데이터 만들기
w = rnd.normal(size=3)

X = rnd.poisson(10 * np.exp(X_org))
y = np.dot(X_org, w)
print(X[:10, 0])

fig = plt.figure(figsize=(10,6))
ax1 = fig.add_subplot(1, 2, 1)
ax2 = fig.add_subplot(1, 2, 2)
ax1.hist(X_org)
ax2.hist(X)

print(np.exp(X_org)[1:3])
print(10 * np.exp(X_org)[1:3])
print(X.shape)
X[1:3]

print(X[:,].shape)
print(X[:, 0].shape)   # 3열의 데이터 중에 첫번째 선택
print(X[:, 0][1:20])   # 첫번째 열의 데이터 중에 20개만 보기

### freture의 빈도 구하기 - 0이 28번, 1이 38번, 2가 68번 출현됨.
print(np.bincount(X[:,0]))

### bar graph로 표시
plt.xlim(0, 160)
plt.ylim(0, 70)
bins = np.bincount(X[:, 0])
plt.bar(range(len(bins)), bins, color='grey')
plt.ylabel("출현 횟수")
plt.xlabel("값")


from sklearn.linear_model import Ridge
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import MinMaxScaler

X_train, X_test, y_train, y_test = train_test_split(X, y, random_state=0)
score = Ridge().fit(X_train, y_train).score(X_test, y_test)
print("테스트 점수: {:.3f}".format(score))


X_train_log = np.log(X_train + 1)
X_test_log = np.log(X_test + 1)
plt.hist(X_train_log[:, 0], bins=25, color='gray')
plt.ylabel("출현 횟수")
plt.xlabel("값")

score = Ridge().fit(X_train_log, y_train).score(X_test_log, y_test)
print("테스트 점수: {:.3f}".format(score))




from sklearn.datasets import load_breast_cancer
from sklearn.feature_selection import SelectPercentile, f_classif
from sklearn.model_selection import train_test_split

cancer = load_breast_cancer()
print("cancer 형태 : {}".format(cancer.keys()))
# 고정된 난수를 발생
rng = np.random.RandomState(42)
print("데이터 길이 : {}".format(len(cancer.data)))
noise = rng.normal(size=(len(cancer.data), 50))

# 데이터에 노이즈 특성을 추가
# 처음 30개는 원본 특성이고 다음 50개는 노이즈입니다
X_w_noise = np.hstack([cancer.data, noise])

X_train, X_test, y_train, y_test = train_test_split(
    X_w_noise, cancer.target, random_state=0, test_size=.5)
# f_classif(기본값)와 SelectPercentile을 사용하여 특성의 50%를 선택합니다
select = SelectPercentile(score_func=f_classif, percentile=50)
select.fit(X_train, y_train)
# 훈련 세트에 적용합니다
X_train_selected = select.transform(X_train)

print("X_train.shape: {}".format(X_train.shape))
print("X_train_selected.shape: {}".format(X_train_selected.shape))


mask = select.get_support()
print(mask)
# True : Black, False : White
plt.matshow(mask.reshape(1, -1), cmap='gray_r')
plt.xlabel("특성 번호")
plt.yticks([0])

from sklearn.linear_model import LogisticRegression

# 테스트 데이터 변환
X_test_selected = select.transform(X_test)

lr = LogisticRegression()
lr.fit(X_train, y_train)
print("전체 특성을 사용한 점수: {:.3f}".format(lr.score(X_test, y_test)))
lr.fit(X_train_selected, y_train)
print("선택된 일부 특성을 사용한 점수: {:.3f}".format(
        lr.score(X_test_selected, y_test)))