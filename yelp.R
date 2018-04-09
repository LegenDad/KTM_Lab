sessionInfo()
Sys.setlocale(category = "LC_CTYPE", locale = "C")
df <- read.csv("../../Data/yelp/yelp_business.csv", na.string=c("NA", ""), 
               stringsAsFactors=F)
dfp1 <- read.csv("../../Data/yelp/yelp_business_part1.csv", 
                 na.string=c("NA", ""), stringsAsFactors=F)
colnames(df)
head(df)
head(dfp1)
summary(df)
summary(dfp1)
sum(is.na(df))
sum(is.na(dfp1))
prop.table(table(is.na(df)))
prop.table(table(is.na(dfp1)))
sapply(df, function(x) sum(is.na(x))/length(x))
sapply(dfp1, function(x) sum(is.na(x))/length(x))

library(Amelia)
missmap(df, main="find_NA", col=c("orange", "lightgray"))
missmap(dfp1, main="find_NA", col=c("orange", "lightgray"))
for (x in 1:13){
  print(colnames(df[x])); print(sum(is.na(df[,x])))
}
for (x in 1:13){
  print(colnames(dfp1[x])); print(sum(is.na(dfp1[,x])))
}
sapply(df, function(x) sum(is.na(x)))
df[is.na(df$city),]
df[is.na(df$city),'city'] <- "Edinburgh"
df[146525,]
df[is.na(df$state),]
table(df$state)
df[is.na(df$state),'state'] <- "NV"
df[52816,]

head(df$categories)
dfcat <- strsplit(df$categories, split = ";")
is(dfcat)
dfcat <- unlist(dfcat)
length(unique(dfcat)) ; length(dfcat)

