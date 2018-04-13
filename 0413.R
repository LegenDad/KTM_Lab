library(caret)
?createDataPartition
args(createDataPartition)
ttt<- createDataPartition(iris$Species, p=0.7)
str(ttt)
ttt[[1]]
iris_index <- createDataPartition(iris$Species, p=0.7, list = F)
iris_tr <- iris[iris_index,]
iris_te <- iris[-iris_index,]
table(iris_tr$Species); table(iris_te$Species)

library(e1071)
naive.result<-naiveBayes(iris_tr, iris_tr$Species,laplace=1)
naive.pred<-predict(naive.result, iris_te, type="class") 
table(naive.pred, iris_te$Species)
?confusionMatrix
confusionMatrix(naive.pred, iris_te$Species)
library(nnet)
