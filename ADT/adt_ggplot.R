rm(list=ls()); gc()
library(data.table)
adt <- fread("Data/AD_Tracking/train_sample.csv")
library(lubridate)
adt$click_hour <- hour(adt$click_time)
adt$click_weekd <- wday(adt$click_time)
str(adt)
library(ggplot2)
ggplot(data = adt, aes(x=click_hour)) + geom_bar()
ggplot(data = adt, aes(x=click_weekd)) + geom_bar()
library(ggthemes)
ggplot(data = adt, aes(x=click_hour)) + geom_bar() + theme_wsj()
ggplot(data = adt, aes(x=click_hour), fill=is_attributed) + geom_bar() + theme_wsj()
ggplot(data = adt, aes(x=click_hour)) + geom_bar() + theme_wsj() +facet_grid(.~is_attributed)
