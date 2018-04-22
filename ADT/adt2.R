adt <- read.csv("Data/AD_Tracking/train_sample.csv", stringsAsFactors = F)
adt2 <- adt
adt2$click_time <- as.POSIXct(adt2$click_time)
range(adt2$click_time)
adt2$click_hour <- as.factor(format(adt2$click_time, "%H"))
adt2$click_weekd <- as.factor(format(adt2$click_time, "%a"))
library(dplyr)
colnames(adt2)

adt2 <- adt2 %>% add_count(ip, click_hour, click_weekd) 
adt2 <- adt2 %>% add_count(ip, click_hour, app)
adt2 <- adt2 %>% add_count(ip, click_hour, device)
adt2 <- adt2 %>% add_count(ip, click_hour, os)
adt2 <- adt2 %>% add_count(ip, click_hour, channel)
head(adt2)
colnames(adt2)[11:15] <- c("ip_hw", "ip_app", "ip_dev", "ip_os", "ip_ch")
colnames(adt2)
head(adt2)

#####
adt2$ip_hw <- as.factor(adt2$ip_hw)
adt2$ip_app <- as.factor(adt2$ip_app)
adt2$ip_dev <- as.factor(adt2$ip_dev)
adt2$ip_os <- as.factor(adt2$ip_os)
adt2$ip_ch <- as.factor(adt2$ip_ch)
adt2$is_attributed <- as.factor(adt2$is_attributed)


glm2 <- glm(is_attributed~app+device+os+channel+click_weekd +
             ip_hw + ip_app + ip_dev + ip_os + ip_ch, 
           family = binomial, adt2)

summary(glm2)
??bayesglm
#install.packages("arm")
library(arm)
glm <- bayesglm(is_attributed~app+device+os+channel+click_hour+click_weekd +
             ip_hw + ip_app + ip_dev + ip_os + ip_ch, 
           family = binomial, adt2)
summary(glm)
anova(glm, test = "Chisq")
anova(glm2, test = "Chisq")
#install.packages("pscl")
library(pscl)
pR2(glm)
pR2(glm2)
format(7.289270e-02, scientific = F)
format(6.015592e-02, scientific = F)
######
#install.packages("randomForest")
library(randomForest)
model.rf=randomForest(is_attributed~app+device+os+channel+click_hour+
                        click_weekd + ip_hw + ip_app + ip_dev + ip_os + 
                        ip_ch, data = adt2)
model.rf
plot(model.rf)

