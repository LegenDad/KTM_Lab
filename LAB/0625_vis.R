library(RgoogleMaps)
library(ggplot2)
library(ggmap)

names <- c("동대문 쇼피타운", "명동", "경복궁", 
           "남산서울타워", "인사동길", "남대문시장")

addr <- c("서울 중구 장충단로 253", 
          "서울 중구 명동8길 27", 
          "서울 종로구 사직로 161", 
          "서울 용산구 남산공원길 105", 
          "서울 종로구 인사동길 39-1", 
          "서울 중구 남대문시장4길 21")
str(addr)
gc <- geocode(enc2utf8(addr))
gc

df <- data.frame(name=names, lon=gc$lon, lat=gc$lat)

map <- get_googlemap(center=c(126.9767, 37.57736), 
                     maptype="roadmap", zoom=13, marker=gc)
ggmap(map, fullpage=TRUE)


ru_fifa <- c("루즈니키 스타디움", "옷크리티예 아레나", "크레스톱스키 스타디움", 
            "칼리닌그라드 경기장", "카잔 아레나", "니즈니노브고로드 스타디움", 
            "코스모스 아레나", "볼고그라드 아레나", "모르도비야 아레나", 
            "로스토프 아레나", "피시트 올림픽 스타디움", "예카테린부르크 중앙경기장")
rf <- data.frame(stadium = ru_fifa, 
                 lon = geocode(enc2utf8(ru_fifa))[1], 
                 lat = geocode(enc2utf8(ru_fifa))[2])
library(dplyr)
rf2 <- rf %>% filter(!is.na(lon))
map <- get_googlemap(center="moskva", maptype = "roadmap", zoom=4, marker =gc)
ggmap(map)
