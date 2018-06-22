library(networkD3)
src <- c("A", "A", "A", "A",
         "B", "B", "C", "C", "D")
target <- c("B", "C", "D", "J",
            "E", "F", "G", "H", "I")
networkData <- data.frame(src, target)

simpleNetwork(networkData)


data(MisLinks)
data(MisNodes)

MisLinks
MisNodes

forceNetwork(Links = MisLinks, Nodes = MisNodes,
             Source = "source", Target = "target",
             Value = "value", NodeID = "name",
             Group = "group", opacity = 0.8)

URL <- paste0(
  "https://cdn.rawgit.com/christophergandrud/networkD3/",
  "master/JSONdata/energy.json")

Energy <- jsonlite::fromJSON(URL)
Energy

sankeyNetwork(Links = Energy$links, Nodes = Energy$nodes, Source = "source",
              Target = "target", Value = "value", NodeID = "name",
              units = "TWh", fontSize = 12, nodeWidth = 30)


URL <- paste0(
  "https://cdn.rawgit.com/christophergandrud/networkD3/",
  "master/JSONdata//flare.json")


Flare <- jsonlite::fromJSON(URL, simplifyDataFrame = FALSE)
Flare

Flare$children = Flare$children[1:3]

radialNetwork(List = Flare, fontSize = 10, opacity = 0.9)

diagonalNetwork(List = Flare, fontSize = 10, opacity = 0.9)


hc <- hclust(dist(USArrests), "ave")

dendroNetwork(hc, height = 600)

library(igraph)


karate <- make_graph("Zachary")
wc <- cluster_walktrap(karate)
members <- membership(wc)

karate_d3 <- igraph_to_networkD3(karate, group = members)

forceNetwork(Links = karate_d3$links, Nodes = karate_d3$nodes, 
             Source = 'source', Target = 'target', 
             NodeID = 'name', Group = 'group')

library(magrittr)

simpleNetwork(networkData) %>%
  saveNetwork(file = 'Net1.html')



