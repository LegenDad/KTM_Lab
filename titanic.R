ttr <- read.csv("../../Data/Titanic/train.csv")
tte <- read.csv("../../Data/Titanic/test.csv")
head(ttr)
head(tte)
colnames(ttr);colnames(tte)
library(Amelia)
#args(missmap)
missmap(ttr, main="find_blank", col=c("orange", "lightgray"))
?strsplit
test_str <- "Kelly, Mr. James"
example("strsplit")
strsplit(test_str, " ")
test_str2 <- c("Kelly, Mr. James", "Wilkes, Mrs. James (Ellen Needs)")
strsplit(test_str2, " ")
strsplit(test_str2, " ")[1]
strsplit(test_str2, " ")[2]
strsplit(test_str2, " ")[[1]][2]
strsplit(test_str2, " ")[[2]][2]
namelist <- strsplit(as.vector(ttr$Name), " ")
head(namelist)
namelist_f <- unlist(namelist) 
head(sort(table(namelist_f), decreasing = T), 10)
head(ttr$Age)
namelist[[3]]
namelist[[3]][2]
namelist[[4]]
namelist[[4]][2]
sipname <- c()
for (i in 1:891) {
  sipname <- append(sipname, namelist[[i]][2])
}
sipname
ttr <- cbind(ttr, sipname)
head(ttr)
library(dplyr)
ttr %>% filter(is.na(Age)) %>%
  select(Name, Sex, Age, sipname) %>%
  group_by(sipname) %>%
  count(sipname)

ttr %>% filter(sipname != "Miss." & sipname !="Mr." & 
                 sipname != "Mrs." & sipname != "Master." & 
                 sipname != "Dr." & sipname != "Ms." &
                 sipname != "Rev."& sipname != "Major.") %>%
  select(Name, sipname)

ttr %>% group_by(sipname) %>%
  count(sipname)

ttr %>% filter(is.na(Age)) %>%
  select(Name, sipname)

library(stringr)
ttr$sipname2 <- str_match(ttr$Name, '[a-zA-z]+\\.')
ttr$sipname2 <- as.factor(ttr$sipname2)
ttr %>% filter(is.na(Age)) %>%
  select(Name, Sex, Age, sipname, sipname2) %>%
  group_by(sipname2) %>%
  count(sipname2)

ttr %>% filter(!is.na(Age)) %>%
  group_by(sipname2) %>%
  summarise(mean(Age))

mean_Dr <- 42
mean_Master <- 4.57
mean_Miss <- 21.77
mean_Mr <- 32.36
mean_Mrs <- 35.89

ttr[is.na(ttr$Age) & ttr$sipname2 == "Dr.", "Age"] <- mean_Dr
ttr[is.na(ttr$Age) & ttr$sipname2 == "Master.", "Age"] <- mean_Master
ttr[is.na(ttr$Age) & ttr$sipname2 == "Miss.", "Age"] <- mean_Miss
ttr[is.na(ttr$Age) & ttr$sipname2 == "Mr.", "Age"] <- mean_Mr
ttr[is.na(ttr$Age) & ttr$sipname2 == "Mrs.", "Age"] <- mean_Mrs

names(ttr)
barplot(table(ttr$Pclass), xlab="Pclass", main = "barplot of Pclass")
barplot(table(ttr$Sex), xlab="Sex", main = "barplot of Sex")
barplot(table(ttr$Embarked), xlab="Embarked", main = "barplot of Embarked")
hist(ttr$Age, main='Age', xlab = 'age')

library(tree)
traintree <- tree(Survived ~ Pclass + Sex + Age + SibSp +
                    Fare + Parch + Embarked, data = ttr)
plot(traintree)
text(traintree)

split.data = function(data, p = 0.7, s = 555){
  set.seed(s)
  len1 = dim(data)[1] # 데이터 길이
  idx = sample(1:len1, size=len1 * p, replace=F)
  train = data[idx, ]
  test = data[-idx, ]
  return(list(train = train, test = test))
}

allset <- split.data(ttr, p = 0.7)
class(allset)
trset = allset$train
testset = allset$test
dim(trset); dim(testset)
traintree = tree(Survived ~ Pclass + Sex + Age + SibSp + Fare
                 + Parch + Embarked, data=trset)
plot(traintree)
text(traintree)
nrow(trset[trset$Sex=='male',])

### ???
cv.trees <- cv.tree(traintree, FUN=prune.misclass)
plot(cv.trees)

prune.trees <- prune.misclass(traintree, best=8) # tree size를 8로 하여 다시 fit하기
plot(prune.trees)
text(prune.trees, pretty=0)
summary(prune.trees)

require(caret)
require(e1071)
treepredict = predict(prune.trees, testset, type='class') # class는 0,1로 예측
treepredict
# install.packages("caret")
#u = union(ctree.predict, testset$Survived)
confusionMatrix(treepredict, testset$Survived)

