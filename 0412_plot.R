DF <- read.csv("E:/BigData/R2_Example/example_studentlist.csv") 
attach(DF)
plot(age)
par(mfrow=c(2,2))
plot(height, weight)
plot(weight~height)
plot(height,sex)
plot(height~sex)
plot(DF[,c(3,7,8)])
par(mfrow=c(1,2))
plot(weight~height)
dev.off()
hMean <- mean(height)
wMean <- mean(weight)
plot(weight~height, pch=as.integer(sex), ann=FALSE)
legend("topleft", c("남", "여"), pch=sex)
title(main="A와 B의 몸무게와 키의 상관관계")
title(xlab = "키", ylab="몸무게")
grid()
abline(v=hMean, h= wMean, col=c("red","orange"))

coplot(weight~height | sex)

tblBlood <- table(DF$bloodtype)
barplot(tblBlood)
title(main = "bar plot of Blood", ylab = "count")
bhei <- tapply(height, bloodtype, mean)
barplot(bhei, ylim = c(0,200))
boxplot(height~bloodtype)