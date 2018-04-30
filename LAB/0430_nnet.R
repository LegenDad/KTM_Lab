library(caret)
set.seed(0)
idx<-createDataPartition(iris$Species, p=0.7, list=F)
iris_tr <- iris[idx, ]
iris_test <- iris[-idx, ]
table(iris_tr$Species)
table(iris_test$Species)

library(nnet)
iris_tr_scale <- as.data.frame(sapply(iris_tr[, -5], scale))
iris_test_scale <- as.data.frame(sapply(iris_test[, -5], scale))
iris_tr_scale$Species <- iris_tr$Species
iris_test_scale$Species <- iris_test$Species



nnet.result <- nnet(Species~. , iris_tr_scale, size=3)
nnet.pred <- predict(nnet.result, iris_test_scale, type="class")

confusionMatrix(factor(nnet.pred), factor(iris_test$Species))

nnet.result <- nnet(Species~. , iris_tr_scale, size=8)
nnet.pred <- predict(nnet.result, iris_test_scale, type="raw")
pred = round(nnet.pred, 8)
pred

