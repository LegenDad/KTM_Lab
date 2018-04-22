rm(list=ls()); gc()
#adt <- adt[sample(.N, 30e6), ]
library(data.table)
adt <- fread("Data/AD_Tracking/train_sample.csv")
library(lubridate)
adt$click_hour <- hour(adt$click_time)
adt$click_weekd <- wday(adt$click_time)
library(dplyr)
colnames(adt)
str(adt)
adt <- adt %>% add_count(ip, click_hour, click_weekd) 
adt <- adt %>% add_count(ip, app)
adt <- adt %>% add_count(ip, device)
adt <- adt %>% add_count(ip, os)
adt <- adt %>% add_count(ip, channel)
adt <- adt %>% add_count(ip)
adt <- adt %>% add_count(app)
adt <- adt %>% add_count(device)
adt <- adt %>% add_count(os)
adt <- adt %>% add_count(channel)
head(adt)
colnames(adt)[11:20] <- c("ip_hw", "ip_app", "ip_dev", "ip_os", "ip_ch", 
                          "ip_cnt", "app_cnt", "dev_cnt", "os_cnt", "ch_cnt")
colnames(adt)

library(caret)
adt_index <- createDataPartition(adt$is_attributed, p=0.7, list = F)
y <- adt$is_attributed
adtr <- adt %>% select(-ip, -click_time, -attributed_time)

adte <- adtr[-adt_index,]
adtr <- adtr[adt_index,]

colnames(adte)
colnames(adtr)
table(adtr$is_attributed); table(adte$is_attributed)
str(adtr)
library(e1071)
library(ROCR)
##### Random Forest #####
library(randomForest)
model.rf=randomForest(as.factor(is_attributed)~., adtr)
model.rf2=randomForest(as.factor(is_attributed)~., adtr, importance = T)
model.rf
importance(model.rf2)
plot(model.rf)
pred_rf <- predict(model.rf, adte,  type = "prob")[,2]
pred_rf
pr <- prediction(pred_rf, adte$is_attributed)
prf <- performance(pr, measure = "tpr", x.measure = "fpr")
plot(prf)

auc <- performance(pr, measure = "auc")
auc <- auc@y.values[[1]]
auc
