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
sapply(adt2, function (x) sum(is.na(x)))
range(adt2$click_time)

adt2$click_hour <- as.factor(format(adt2$click_time, "%H"))
adt2$click_weekd <- as.factor(format(adt2$click_time, "%a"))

args(glm)
glm <- glm(is_attributed~ip+app+device+os+channel+click_hour+click_weekd, 
           family = binomial, adt2)

summary(glm)
glm2 <- glm(is_attributed~ip+app+device+os+channel,family = binomial, adt2)
summary(glm2)
anova(glm, test = "Chisq")
anova(glm2, test = "Chisq")

#install.packages("pscl")
library(pscl)
pR2(glm)
pR2(glm2)
format(1.334263e-01, scientific = F)
format(1.199428e-01, scientific = F)
format(1.396488e-01, scientific = F)


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
