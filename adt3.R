##### Basic #####
adt <- read.csv("Data/AD_Tracking/train_sample.csv", stringsAsFactors = F)
adt$click_time <- as.POSIXct(adt$click_time)
range(adt$click_time)
adt$click_hour <- as.factor(format(adt$click_time, "%H"))
adt$click_weekd <- as.factor(format(adt$click_time, "%a"))
library(dplyr)
colnames(adt)
adt <- adt %>% add_count(ip, click_hour, click_weekd) 
adt <- adt %>% add_count(ip, click_hour, app)
adt <- adt %>% add_count(ip, click_hour, device)
adt <- adt %>% add_count(ip, click_hour, os)
adt <- adt %>% add_count(ip, click_hour, channel)
head(adt)
colnames(adt)[11:15] <- c("ip_hw", "ip_app", "ip_dev", "ip_os", "ip_ch")
colnames(adt)
head(adt)

#adt$ip_hw <- as.factor(adt$ip_hw)
#adt$ip_app <- as.factor(adt$ip_app)
#adt$ip_dev <- as.factor(adt$ip_dev)
#adt$ip_os <- as.factor(adt$ip_os)
#adt$ip_ch <- as.factor(adt$ip_ch)
#adt$is_attributed <- as.factor(adt$is_attributed)
#head(adt)
#install.packages("caret")
library(caret)
#args(createDataPartition)
colnames(adt)
adt_index<- createDataPartition(adt$is_attributed, p=0.7, list = F)
adtr <- adt[adt_index,]
adte <- adt[-adt_index,]
table(adtr$is_attributed); table(adte$is_attributed)
glm <- glm(is_attributed~app+device+os+channel+click_hour +
              ip_hw + ip_app + ip_dev + ip_os + ip_ch, 
            family = binomial, adtr)
summary(glm)
?predict
pred_glm <- predict(glm, newdata = adte, type = "response")
pred_glm <- ifelse(pred_glm > 0.7,1,0)
is(pred_glm)
is(adte$is_attributed)
adte[adte$is_attributed==1,]
#install.packages("e1071")
library(e1071)
confusionMatrix(pred_glm, adte$is_attributed)
confusionMatrix(as.factor(pred_glm), adte$is_attributed)
#install.packages("ROCR")
library(ROCR)
pr <- prediction(pred_glm, adte$is_attributed)
prf <- performance(pr, measure = "tpr", x.measure = "fpr")
plot(prf)

auc <- performance(pr, measure = "auc")
auc <- auc@y.values[[1]]
auc



#########??bayesglm
#install.packages("arm")
library(arm)
glm2 <- bayesglm(is_attributed~app+device+os+channel+click_hour +
             ip_hw + ip_app + ip_dev + ip_os + ip_ch, 
           family = binomial, adtr)
summary(glm2)
pred_glm2 <- predict(glm2, newdata = adte, type = "response")
pred_glm2 <- ifelse(pred_glm2 > 0.6,1,0)
confusionMatrix(pred_glm2, adte$is_attributed)
confusionMatrix(as.factor(pred_glm2), adte$is_attributed)
pr2 <- prediction(pred_glm2, adte$is_attributed)
prf2 <- performance(pr2, measure = "tpr", x.measure = "fpr")
plot(prf2)

auc2 <- performance(pr2, measure = "auc")
auc2 <- auc@y.values[[1]]
auc2



anova(glm, test = "Chisq")
anova(glm2, test = "Chisq")
#install.packages("pscl")
library(pscl)
pR2(glm)
pR2(glm2)
format(7.289270e-02, scientific = F)
format(1.081032e-01, scientific = F)
######
#install.packages("randomForest")
library(randomForest)
model.rf=randomForest(is_attributed~app+device+os+channel+click_hour+
                        ip_hw + ip_app + ip_dev + ip_os + 
                        ip_ch, data = adtr)
model.rf
plot(model.rf)

pred_rf <- predict(model.rf, adte)s
confusionMatrix(pred_rf, adte$is_attributed)
is(pred_rf)
pr3 <- prediction(as.integer(pred_rf), adte$is_attributed)
prf3 <- performance(pr3, measure = "tpr", x.measure = "fpr")
plot(prf3)

auc3 <- performance(pr3, measure = "auc")
auc3 <- auc3@y.values[[1]]
auc3
##### XGBOOST #####
rm(list=ls()); gc()
adt <- read.csv("Data/AD_Tracking/train_sample.csv", stringsAsFactors = F)
adt$click_time <- as.POSIXct(adt$click_time)
range(adt$click_time)
adt$click_hour <- format(adt$click_time, "%H")
adt$click_weekd <- format(adt$click_time, "%a")
#adt$click_hour <- as.factor(format(adt$click_time, "%H"))
#adt$click_weekd <- as.factor(format(adt$click_time, "%a"))
library(dplyr)
colnames(adt)
adt <- adt %>% add_count(ip, click_hour, click_weekd) 
adt <- adt %>% add_count(ip, click_hour, app)
adt <- adt %>% add_count(ip, click_hour, device)
adt <- adt %>% add_count(ip, click_hour, os)
adt <- adt %>% add_count(ip, click_hour, channel)
head(adt)
colnames(adt)[11:15] <- c("ip_hw", "ip_app", "ip_dev", "ip_os", "ip_ch")
colnames(adt)
head(adt)
#install.packages("xgboost")
library(xgboost)
library(caret)
colnames(adt)
colnames(adt[,-c(6,8)])
adt_index <- createDataPartition(adt$is_attributed, p=0.7, list = F)
y <- adt[adt_index,]$is_attributed

adtr <- adt[,-c(6,8)]

dtest <- xgb.DMatrix(data = data.matrix(adtr[-adt_index,]))
str(dtest)
tri <- createDataPartition(y, p = 0.9, list = F)
dtrain <- xgb.DMatrix(data = data.matrix(adtr[adt_index,][tri,]), label = y[tri])
dval <- xgb.DMatrix(data = data.matrix(adtr[adt_index,][-tri,]), label = y[-tri])
cols <- colnames(adtr)
#dtest <- xgb.DMatrix(data = data.matrix(tr_te[-tri]))
#tr_te <- tr_te[tri]
#tri <- caret::createDataPartition(y, p = 0.9, list = F)
#dtrain <- xgb.DMatrix(data = data.matrix(tr_te[tri]), label = y[tri])
#dval <- xgb.DMatrix(data = data.matrix(tr_te[-tri]), label = y[-tri])
#cols <- colnames(tr_te)
#
#rm(tr_te, y, tri); gc()

p <- list(objective = "binary:logistic",
          booster = "gbtree",
          eval_metric = "auc",
          nthread = 8,
          eta = 0.07,
          max_depth = 7,
          min_child_weight = 148,
          gamma = 167.6125,
          subsample = 0.6928,
          colsample_bytree = 0.9108,
          colsample_bylevel = 0.9857,
          alpha = 43.2165,
          lambda = 74.6334,
          scale_pos_weight = 103,
          nrounds = 2000)
m_xgb <- xgb.train(p, dtrain, p$nrounds, list(val = dval), print_every_n = 50, 
                   early_stopping_rounds = 200)

(imp <- xgb.importance(cols, model=m_xgb))
xgb.plot.importance(imp, top_n = 10)
predXG <- predict(m_xgb,dtest)
predXG <- ifelse(predXG > 0.7,1,0)
sum(predXG)
nrow(adt[-adt_index,])
library(e1071)
confusionMatrix(predXG, adt[-adt_index,]$is_attributed)

#install.packages("ROCR")
library(ROCR)
pr <- prediction(predXG, adt[-adt_index,]$is_attributed)
prf <- performance(pr, measure = "tpr", x.measure = "fpr")
plot(prf)

auc <- performance(pr, measure = "auc")
auc <- auc@y.values[[1]]
auc
