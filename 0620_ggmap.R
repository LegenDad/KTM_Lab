library(ggmap)
library(grDevices)

getmap <- get_googlemap('seoul', zoom=15, maptype="hybrid")
getmap
ggmap(getmap)
getmap2 <- get_googlemap('incheon')
ggmap(getmap2)

df <- read.csv("../../Data/RLoveYou/서울시구청위치정보_new.csv", header = T)
head(df)

map <- get_map("seoul", zoom = 11, maptype = "roadmap")
ggmap01 <- ggmap(map)
ggmap01 <- ggmap(map) + geom_point(data=df, aes(LON, LAT), 
                                   size=5, alpha = 1, color='green')
ggmap01

ggmap01 + geom_text(data=df, aes(LON, LAT+0.001, label=name), size=8)

se_train <- read.csv("../../Data/RLoveYou/서울지하철2호선위경도정보.csv", header = T)
head(se_train)
ggmap02 <- ggmap(map) + geom_point(data=se_train, aes(LON, LAT), 
                                   size=5, color="orange")
ggmap02
ggmap02 + geom_text(data=se_train, aes(LON, LAT+0.001, label=역명), size=5)
center <- c(mean(se_train$LON), mean(se_train$LAT))
map2 <- get_map(center, zoom = 11, maptype = "roadmap")
ggmap2 <- ggmap(map2) + geom_point(data=se_train, aes(LON, LAT), 
                                   size=5, color="orange")

ggmap2 + geom_text(data=se_train, aes(LON, LAT+0.001, label=역명), size=5)

toy <- read.csv("../../Data/RLoveYou/서울시장난감도서관위치현황.csv", header = T)
head(toy)
ggmap2 + geom_text(data=se_train, aes(LON, LAT+0.001, label=역명), size=5) + 
  geom_point(data = toy, aes(LON, LAT), size=4, color="red") +
  geom_text(data = toy, aes(LON, LAT+0.001, label = 이름), size=5, color="steelblue")



loc <- read.csv("../../Data/RLoveYou/서울지하철3호선역위경도정보.csv",header=T)
kor <- get_map("seodaemun gu", zoom=11, maptype = "roadmap")
kor.map <- ggmap(kor)+ geom_point(data=loc, aes(x=LON, y=LAT),
                                  size=3,alpha=0.7,col="red")
kor.map + geom_path(data=loc,aes(x=LON,y=LAT),size=1,linetype=2,col="green")+
  geom_text(data=loc, aes(x = LON, y = LAT+0.005, label=역명),size=2)
ggsave("line_3.png",dpi=600)


ggmap(kor) + geom_point(data=loc, aes(x=LON, y=LAT), 
                        size=3, alpha=.7, col="green") + 
  geom_path(data=se_train, aes(x=LON, y=LAT), size=1, linetype=3, col="blue")
ggmap(kor) + geom_point(data=loc, aes(x=LON, y=LAT), 
                        size=3, alpha=.7, col="green") + 
  geom_path(data=se_train, aes(x=LON, y=LAT), size=1, linetype=14, col="blue")


pop <- read.csv("../../Data/RLoveYou/지역별인구현황_2014_4월기준.csv",header=T)
head(pop)
lon <- pop$LON
lat <- pop$LAT
data <- pop$총인구수
df <- data.frame(lon,lat,data)
head(df,2)
map1 <- get_map("republic of korea",zoom=7 , maptype='roadmap')
map1 <- ggmap(map1)
map1 + geom_point(aes(x=lon,y=lat,colour=data,size=data),data=df)

map1 + geom_point(data=pop, aes(x=LON,y=LAT, size= 총인구수, color = 여자인구수))
str(pop)




