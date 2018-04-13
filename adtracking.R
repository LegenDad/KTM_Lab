adt <- read.csv("Data/AD_Tracking/train_sample.csv", stringsAsFactors = F)
head(adt)
str(adt)
head(adt[!is.null(adt$attributed_time),])
head(adt[adt$is_attributed>0,])

adt2 <- adt
adt2$click_time <- as.POSIXct(adt2$click_time)
adt2$attributed_time <- ifelse(nchar(adt2$attributed_time)>0, 
                               adt2$attributed_time, as.character(Sys.time()))
head(adt2[adt$is_attributed>0,])
head(adt2)
adt2$attributed_time <- as.POSIXct(adt2$attributed_time)
head(adt2[adt$is_attributed>0,])
head(adt2)
adt2$dwtime <- adt2$attributed_time -adt2$click_time
head(adt2[adt$is_attributed>0,])
head(adt2)

str(adt2$dwtime)
adt2$dwtime <- ifelse(adt2$dwtime>13000000, NA, adt2$dwtime)
adt2$dwtime>13000000
sapply(adt2, function (x) sum(is.na(x)))


#adt$click_hour <- as.factor(format(adt$click_time, "%H"))
#adt$click_weekd <- as.factor(format(adt$click_time, "%a"))
######

library(dplyr)
head(sort(table(adt3$ip), decreasing = T))
adt3 %>% filter(ip == 5314 | ip ==5348)



head(adt2[adt$is_attributed>0,])
head(adt2)

table(adt2$is_attributed)
adt3 <- adt2 %>% filter(adt2$is_attributed ==1)
adt3$click_time <- as.POSIXct(adt3$click_time)
adt3$attributed_time <- as.POSIXct(adt3$attributed_time)
adt3$dwtime <- adt3$attributed_time -adt3$click_time
head(sort(table(adt3$ip), decreasing = T))
adt3 %>% filter(ip == 5314 | ip ==5348)

#ubuntu
