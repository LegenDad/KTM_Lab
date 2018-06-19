tr <- read.csv("../../Data/House.Price/train.csv")
te <- read.csv("../../Data/House.Price/test.csv")
head(tr)
head(te)

library(corrplot)
nV <- which(sapply(tr, is.numeric))
nVnames <- names(nV)

head(tr[,nVnames])
head(tr[,nV])

cor1 <- cor(tr[,nV], use = "complete.obs")
cor2 <- cor(tr[,nV], use = "pairwise.complete.obs")

identical(cor(tr[,nV], use = "complete.obs")
          cor(tr[,nV], use = "pairwise.complete.obs"))

sort(cor1[, 'SalePrice'], decreasing = T)
sort(cor2[, 'SalePrice'], decreasing = T)

cor_sort <- as.matrix(sort(cor2[, 'SalePrice'], decreasing = T))

cor_sort[abs(cor_sort[,1]) > 0.5, ]

mulcor = apply(cor_sort, 1, function(x) abs(x)>0.5)
CorHigh <- names(which(mulcor))
CorHigh
cor_numVar <- cor2 <- cor(tr[,nV], use = "pairwise.complete.obs")[CorHigh, CorHigh]
cor_numVar

corrplot(cor_numVar)
corrplot.mixed(cor_numVar)
corrplot.mixed(cor_numVar, tl.col="black", tl.pos = "lt")

colnames(tr)
GarageCars

tr <- read.csv("../../Data/House.Price/train.csv")
nV <- which(sapply(tr, is.numeric))
tr[, nV]
cor(tr[, nV], use = "pairwise.complete.obs")
cor(tr[, nV], use = "pairwise.complete.obs")[, 'GarageCars']
gg <- sort(cor(tr[, nV], use = "pairwise.complete.obs")[, 'GarageCars'], decreasing = T)
abs(gg) > 0.3
gname <- names(gg[abs(gg) > 0.3])
gcarcor <- cor(tr[, nV][, gname], use = "pairwise.complete.obs")
corrplot.mixed(gcarcor, tl.col="black", tl.pos = "lt")
