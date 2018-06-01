library(data.table)
sns <- read.csv("./LAB/snsdata.csv")
head(sns)
for (i in 1:40) {
  print(sum(is.na(sns[i])))
}
colnames(sns[2:3])
str(sns[2])
head(sns[2])
str(sns[3])
range(sns[,3], na.rm = T)
range(sns[1])
sort(table(sns[3]), decreasing = F)
summary(sns[3])
colnames(sns)
library(dplyr)
sns %>% group_by(gradyear) %>% summarise(mean = mean(age, na.rm = T))
g6 <- 19.1; g7 <- 18.4; g8 <- 17.5; g9 <-16.9
sns[is.na(sns$age) & sns$gradyear == 2006,]["age"] <- g6
sns[is.na(sns$age) & sns$gradyear == 2007,]["age"] <- g7
sns[is.na(sns$age) & sns$gradyear == 2008,]["age"] <- g8
sns[is.na(sns$age) & sns$gradyear == 2009,]["age"] <- g9
sns[sns$age > 100,][1:4]
head(sort(unique(sns$age), decreasing = T), 300)
boxplot(sns$age)

table(sns$gender)
table(sns$gender, useNA = "ifany")
??useNA


df <- read.csv("./LAB/snsdata.csv")
df$age <- ifelse(df$age >= 13 & df$age <20, df$age, NA)
summary(df$age)
df$female <- ifelse(df$gender == "F" & !is.na(df$gender), 1, 0)
df$no_gender <- ifelse(is.na(df$gender), 1, 0)
table(df$female, useNA = "ifany")
table(df$no_gender, useNA = "ifany")
summary(df$gender)
?ave
aggregate(data = df, age~gradyear, mean, na.rm = T)
ave_age <- ave(df$age, df$gradyear, FUN = function(x) mean(x, na.rm= T))

df$age <- ifelse(is.na(df$age), ave_age, df$age)
summary(df$age)
colnames(df)

interests <- df[5:40]
interests_z <- as.data.frame(lapply(interests, scale))
interests_z2 <- lapply(interests, scale)
str(interests_z2)
interests_z3 <- sapply(interests, scale)
interests_z4 <- as.data.frame(sapply(interests, scale))
identical(interests_z, interests_z4)
system.time(as.data.frame(lapply(interests, scale)))
system.time(as.data.frame(sapply(interests, scale)))
str(interests_z3)
set.seed(2345)
teen_clustes <- kmeans(interests_z, 5)
teen_clustes$centers
teen_clustes$ifault


