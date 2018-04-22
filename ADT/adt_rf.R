rm(list=ls()); gc()
library(data.table)
adt <- fread("./ADT/Data/train_sample.csv")
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
adt_index <- createDataPartition(adt$is_attributed, p = 0.7, list = F)
y <- adt$is_attributed
adtr <- adt %>% select(-ip, -click_time, -attributed_time)
adte <- adtr[-adt_index,]
adtr <- adtr[adt_index,]
colnames(adte) == colnames(adtr)
rm(adt); gc()
table(adtr$is_attributed); table(adte$is_attributed)
library(e1071)
library(ROCR)
library(randomForest)
model.rf <- randomForest(as.factor(is_attributed)~., adtr, importance = T)
model.rf
importance(model.rf)
pred_rf <- predict(model.rf, adte, type ="prob")[,2]
pr <- prediction(pred_rf, adte$is_attributed)
prf <- performance(pr, "tpr", "fpr")
plot(prf)
auc <- performance(pr, measure = "auc")
auc <- auc@y.values[[1]]
auc
