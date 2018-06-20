install.packages("networkD3")
install.packages("d3Network")
library(networkD3)
library(d3Network)

source <- c(rep("A", 4), rep("B", 3), rep("C", 2))
target <- c("B", "C", "D", "J", "E", "F", "G", "D", "H")
networkData = data.frame(source, target)

simpleNetwork(networkData)
?simpleNetwork

source <- c(rep("철수", 3) , rep("수철", 3), rep("기수", 2))
target <- c("영희", "민희", "수철", "수진", "철수", "희수", "영희", "수철")
nwd <- data.frame(source,target)
simpleNetwork(nwd, zoom = T)



library(igraph)
g1 <- graph(c(1, 2, 2, 4, 4, 3))
plot(g1)

df <- read.csv("../../Data/RLoveYou/clustering.csv")
head(df)
graph <- data.frame(학생=df$학생, 교수=df$교수)

library(stringr)

df <- graph.data.frame(graph,directed=TRUE)  
df

gubun1 <- V(df)$name
head(gubun1,100)          
gubun <- str_sub(gubun1, start=1, end=1)
table(gubun)
plot(df)
plot(df, layout=layout.fruchterman.reingold,
     vertex.size=2,            
     edge.arrow.size=0.2,      
     vertex.color = "green",   
     vertex.label=NA)
simpleNetwork(graph)
