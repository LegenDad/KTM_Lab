dim(iris)
?kmeans
args(kmeans)
head(iris)
km <- kmeans(iris[,-5], 3)
km$totss
km$tot.withinss
km$withinss
km$betweenss
km$size

km_cnt <- c()
km_withness <- c()
km_beteen <- c()

for (i in 2:7) {
  set.seed(1)
  km_out <- kmeans(iris[,-5], i)
  km_cnt[i-1] <- i
  km_withness[i-1] <- km_out$tot.withinss
  km_beteen[i-1] <- km_out$betweenss
}
km_withness
km_beteen
km_cnt

res1 <- data.frame(k=km_cnt, kmout = km_withness, kmoutgroup = km_beteen)
res1

plot(res1$k, res1$kmout, type = "b")
plot(res1$k, res1$kmoutgroup, type = "b")

set.seed(1)
kres_k3 <- kmeans(iris[, -5], centers=3)
kres_k3$centers
kres_k3$cluster
table(kres_k3$cluster, iris$Species)

plot(iris[, 1:2], 
     col = kres_k3$cluster, 
     pch = ifelse(kres_k3$cluster == 1, 16, 
                  ifelse(kres_k3$cluster == 2, 17, 18)), 
     cex = 1.5)
points(kres_k3$centers, col = c(2, 3, 1), pch = 16, cex = 3)

set.seed(1)
kres_k4 <- kmeans(iris[, -5], centers=4)
kres_k4$centers
kres_k4$cluster
table(kres_k4$cluster, iris$Species)

plot(iris[, 1:2], 
     col = kres_k4$cluster, 
     pch = ifelse(kres_k4$cluster == 1, 16, 
                  ifelse(kres_k4$cluster == 2, 17, 18)), 
     cex = 1.5)
points(kres_k4$centers, col = c(4, 1, 2, 3), pch = 16, cex = 3)



library(ggplot2)
ggplot(iris, aes(Sepal.Length, Sepal.Width)) + geom_point()


ggplot(iris, aes(Sepal.Length, Sepal.Width, color = factor(kres_k3$cluster), 
                 shape = factor(kres_k3$cluster))) + geom_point()


#p <- ggplot(iris, aes(iris2$Sepal.Length, iris2$Sepal.Width, 
#                      shape=factor(kres_k3$cluster)))
#p + geom_point(aes(colour=factor(kres_k3$cluster)))

