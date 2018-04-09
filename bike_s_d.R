btr <- read.csv("../../Data/Bike/train.csv", stringsAsFactors = F)
bte <- read.csv("../../Data/Bike/test.csv", stringsAsFactors = F)
dim(btr); dim(bte)
sum(is.na(btr)); sum(is.na(bte))
colnames(btr)
colnames(bte)
str(btr); str(bte)
btr$season  = as.factor(btr$season)
btr$holiday  = as.factor(btr$holiday)
btr$workingday  = as.factor(btr$workingday)
btr$weather  = as.factor(btr$weather)
bte$season  = as.factor(bte$season)
bte$holiday  = as.factor(bte$holiday)
bte$workingday  = as.factor(bte$workingday)
bte$weather  = as.factor(bte$weather)
str(btr)
str(bte)
colnames(btr)
colnames(bte)

set.seed(999)
btr_si1 <- sample(nrow(btr)*0.6)
btr_si2 <- sample(nrow(btr)*0.7)
btr_si3 <- sample(nrow(btr)*0.8)

btr646 <- btr[btr_si1,]
btr644 <- btr[-btr_si1,]
btr737 <- btr[btr_si2,]
btr733 <- btr[-btr_si2,]
btr828 <- btr[btr_si3,]
btr822 <- btr[-btr_si3,]


lm64 <- lm(count~season+holiday+workingday+temp+atemp+humidity+windspeed, btr646)
lm73 <- lm(count~season+holiday+workingday+temp+atemp+humidity+windspeed, btr737)
lm82 <- lm(count~season+holiday+workingday+temp+atemp+humidity+windspeed, btr828)

pred64 <- predict(lm64, newdata = btr644)
pred73 <- predict(lm73, newdata = btr733)
pred82 <- predict(lm82, newdata = btr822)

with(btr644, sqrt(mean((count-pred64)^2)))
with(btr733, sqrt(mean((count-pred73)^2)))
with(btr822, sqrt(mean((count-pred82)^2)))

tr1 <- btr737
tr2 <- btr733

tr1$datetime <- as.POSIXct(tr1$datetime)
tr1$year <- format(tr1$datetime, "%Y")
tr1$month <- format(tr1$datetime, "%m")
tr1$day <- format(tr1$datetime, "%d")
tr1$hour <- format(tr1$datetime, "%H")
tr1$weekday <- format(tr1$datetime, "%A")
tr1$weeknum <- format(tr1$datetime, "%U")

tr2$datetime <- as.POSIXct(tr2$datetime)
tr2$year <- format(tr2$datetime, "%Y")
tr2$month <- format(tr2$datetime, "%m")
tr2$day <- format(tr2$datetime, "%d")
tr2$hour <- format(tr2$datetime, "%H")
tr2$weekday <- format(tr2$datetime, "%A")
tr2$weeknum <- format(tr2$datetime, "%U")

btr$datetime <- as.POSIXct(btr$datetime)
btr$year <- format(btr$datetime, "%Y")
btr$month <- format(btr$datetime, "%m")
btr$day <- format(btr$datetime, "%d")
btr$hour <- format(btr$datetime, "%H")
btr$weekday <- format(btr$datetime, "%A")
btr$weeknum <- format(btr$datetime, "%U")


bte$datetime <- as.POSIXct(bte$datetime)
bte$year <- format(bte$datetime, "%Y")
bte$month <- format(bte$datetime, "%m")
bte$day <- format(bte$datetime, "%d")
bte$hour <- format(bte$datetime, "%H")
bte$weekday <- format(bte$datetime, "%A")
bte$weeknum <- format(bte$datetime, "%U")

lm <- lm(count~season+temp+atemp+
           humidity+windspeed+month+hour+weekday+weeknum, tr1)
summary(lm)
pred_lm <- predict(lm, newdata = tr2)

library(randomForest)
btr$month  = as.factor(btr$month)
btr$hour  = as.factor(btr$hour)
btr$weekday  = as.factor(btr$weekday)
btr$weeknum  = as.factor(btr$weeknum)
bte$month  = as.factor(bte$month)
bte$hour  = as.factor(bte$hour)
bte$weekday  = as.factor(bte$weekday)
bte$weeknum  = as.factor(bte$weeknum)

model.rf=randomForest(count ~ season + holiday + workingday + temp + atemp + humidity + windspeed+month+hour, data = btr)
model.rf
plot(model.rf)
pred_rf <- predict(model.rf, bte)
sub = read.csv("../../Data/Bike/sampleSubmission.csv")
head(sub)
sub$count <- pred_rf

write.csv(sub, file="submissiion.csv", row.names=F)
bte
