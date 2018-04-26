drink <- read.csv("./LAB/drink.csv")
str(drink)
library(class)
args(glm)
m <- glm(지각여부~나이+결혼여부+자녀여부+체력+주량+직급+성별, 
             family = binomial, data = drink)
summary(m)
predict(m, drink, type = "response")
prev <- predict(m, drink, type = "response") >= 0.5
prev <- ifelse(prev == TRUE, 1, 0)
real <- drink$지각여부
real <- ifelse(real == "Y", 1, 0)
table(real, prev)
library(caret)
??confusinoMatrix
confusionMatrix(as.factor(prev), as.factor(real))

pred <- predict(m, drink, type = "response")
library(ROCR)
pr <- prediction(pred, real)
prf <- performance(pr, "tpr", "fpr")
plot(prf)
auc <- performance(pr, "auc")
auc@y.values[[1]]

model <- glm(formula= vs ~ wt + disp, data=mtcars, family=binomial)
summary(model)
newdata <-  data.frame(wt=2.1, disp=180)
predict(model, newdata, type="response")
str(model)
names(model)
model$aic

if(!require(ResourceSelection)) {
  install.packages("ResourceSelection", repos = "http://cran.us.r-project.org")
}
search()
library(ResourceSelection)
??ResourceSelection
example(rsf)
hoslem.test(mtcars$vs, fitted(model))
model2 <- glm(formula= vs ~ wt, data=mtcars, family=binomial)
range(mtcars$wt)
xweight <- seq(0, 6, 0.01)
head(xweight)
tail(xweight)
yweight <- predict(model2, list(wt=xweight), type="response")
head(yweight)
plot(mtcars$wt, mtcars$vs, pch=16, xlab="WEIGHT (g)", ylab="VS")
lines(xweight, yweight)
model_disp <- glm(formula= vs ~ disp, data=mtcars, family=binomial)
xdisp = seq(71, 475, 0.1)
ydisp = predict(model_disp, list(disp=xdisp), type="response")
plot(mtcars$disp, mtcars$vs, pch = 16, xlab = "DISPLACEMENT (cubic inches)", ylab = "VS")
lines(xdisp, ydisp)
