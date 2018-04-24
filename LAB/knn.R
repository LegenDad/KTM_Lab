set.seed(123)
data <- iris[, c(-3, -4)]
idx <- sample( x=c(1,2,3), size=nrow(data), replace = T, prob = c(3, 1, 1))
train <- data[idx ==1, ]
valid <- data[idx ==2, ]
test <- data[idx ==3, ]
plot(Sepal.Length~Sepal.Width, data = train, 
     col = train$Species, main = "train dataset")
points(Sepal.Length~Sepal.Width, data = valid, 
       pch = 17, cex =2 , col = "red")
points(formula = Sepal.Length~Sepal.Width, 
     data = test, pch = 15, cex =2, col = "orange")
legend("topright", 
       c("setosa", "versicolor", "virginica", "valid", "test"), 
       pch = c(1, 1, 1, 17, 15), 
       col = c("green", "blue", "purple", "red", "orange"), 
       cex = .8
       )

tr_x = train[,-3]
valid_x = valid[,-3]
test_x = test[,-3]

tr_y = train[,3]
valid_y = valid[,3]
test_y = test[,3]
library(class)
library(pryr)
mem_used()
search()
dim(tr_x); dim(valid_x)
set.seed(1234)
knn_1 <- knn(train=tr_x, test = valid_x, cl = tr_y, k =1)
knn_1
?knn
plot(formula = Sepal.Length ~ Sepal.Width,
     data = train,
     col = c("purple", "blue", "green")[train$Species],
     main = "KNN (k=1)")
points(formula = Sepal.Length ~ Sepal.Width,
       data = valid,
       pch = 17,
       cex = 2,
       col = c("purple", "blue", "green")[knn_1])
legend("topright",
       c( paste("train", levels(data$Species)),
          paste("valid", levels(valid$Species))),
       pch=c(rep(1,3), rep(17,3)),
       col=c("purple", "blue", "green","purple", "blue", "green"),
       cex = 1.3)
accuracy_1 <- sum(knn_1 == valid_y) / length(valid_y) ; accuracy_1
library(caret)
confusionMatrix(knn_1, valid_y)
library(ROCR)
pr <- prediction(as.factor(knn_1), as.factor(valid_y))




#accuracy_k <- c(accuracy_k, sum(knn_k == valid_y)/ length(valid_y))
#ccur <- sum(knn_k==valid_y)/ length(valid_y))
accuracy_k <- NULL
for (kk in c(1:nrow(tr_x))) {
  set.seed(1234)
  knn_k <- knn(train = tr_x, test = valid_x, cl = tr_y, k= kk)
  occur <- sum(knn_k==valid_y)/ length(valid_y)
  accuracy_k <- c(accuracy_k, occur)
}
accuracy_k
valid_k <- data.frame(k = c(1:nrow(tr_x)), accuracy=accuracy_k)
plot(formula = accuracy ~ k,
     data = valid_k,
     type = "o",
     pch = 20,
     main = "validation - optimal k")
with(valid_k, text(accuracy~k,
                   labels = rownames(valid_k),
                   pos=1,
                   cex =0.7))
min(valid_k[valid_k$accuracy %in% max(accuracy_k), "k"])
set.seed(1234)
knn_21_test <- knn(train=tr_x,
                   test=test_x,
                   cl=tr_y,
                   k=21)
r = matrix(NA, nrow=3, ncol=3)
rownames(r) <- paste0("real_", levels(tr_y))
colnames(r) <- paste0("prev_", levels(tr_y))
r[1, 1] <- sum(ifelse(test_y == "setosa" & knn_21_test == "setosa", 1, 0))
r[2, 1] <- sum(ifelse(test_y == "versicolor" & knn_21_test == "setosa", 1, 0))
r[3, 1] <- sum(ifelse(test_y == "virginica" & knn_21_test == "setosa", 1, 0))
r[1, 2] <- sum(ifelse(test_y == "setosa" & knn_21_test == "versicolor", 1, 0))
r[2, 2] <- sum(ifelse(test_y == "versicolor" & knn_21_test == "versicolor", 1, 0))
r[3, 2] <- sum(ifelse(test_y == "virginica" & knn_21_test == "versicolor", 1, 0))
r[1, 3] <- sum(ifelse(test_y == "setosa" & knn_21_test == "virginica", 1, 0))
r[2, 3] <- sum(ifelse(test_y == "versicolor" & knn_21_test == "virginica", 1, 0))
r[3, 3] <- sum(ifelse(test_y == "virginica" & knn_21_test == "virginica", 1, 0))
r
sum(knn_21_test==test_y)/sum(r)
confusionMatrix(knn_21_test, test_y)
summary(confusionMatrix(knn_21_test, test_y))
