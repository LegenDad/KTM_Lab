library(ggmap)
library(sp)
library(raster)
library(rasterVis)
library(maptools)
library(rgeos)
library(XML)
library(rgdal)
library(dismo)

mymap <- gmap("Fance")
plot(mymap)

mymap <- gmap("France", type="satellite")
plot(mymap)

library(RgoogleMaps)
newmap <- GetMap(center=c(36.7, -5.9), zoom = 10, 
                 destfile = "newmap.png", maptype="satellite")

newmap2 <- GetMap.bbox(lonR = c(-5, -6), latR = c(36, 37), 
                       maptype = "terrain")

sing <- get_map(location = "singapore", color = "bw",
                zoom = 11, maptype = "toner", source = "google")

plot(sing)

set.seed(12)
foo <- data.frame(long = runif(300, 103.68, 104),
                  lat = runif(300, 1.3, 1.42))
foo
ggmap(sing) +
  geom_point(data = foo, aes(x = long, y = lat), color = "red")

center1 = mean( -5.5, -5.6, -5.8 )
center2 = mean( 36.3, 35.8, 36.4 )

map <- get_map(location =c(center1, center2), zoom = 9, source = "google")

# ggmap(map, fullpage = TRUE)
ggmap(map)


df <- data.frame(long = c(-5.5, -5.6, -5.8),
                 lat = c(36.3, 35.8, 36.4)  )
ggmap(map) + geom_point(data = df, aes(x = long, y = lat, size=10), color = "red")


#install.packages("googleVis")
# install.packages(c("devtools","jsonlite", "knitr", "shiny", "httpuv"))
library(devtools)
install_github("mages/googleVis")

library(googleVis)
?googleVis
demo(googleVis)


require(datasets)
states = data.frame(state.name, state.x77)
G3 = gvisGeoChart(states, 
                  locationvar = "state.name", 
                  colorvar = "HS.Grad",
                  options=list(region="US", 
                               displayMode="regions", 
                               resolution="provinces",
                               width=800, height=600))
plot(G3)
G4 = gvisGeoChart(states, 
                  locationvar = "state.name", 
                  colorvar = "Income",
                  options=list(region="US", 
                               displayMode="regions", 
                               resolution="provinces",
                               width=800, height=600))
plot(G4)




library(XML)
eq <- read.csv("http://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_month.csv")
eq
head(eq)
names(eq)
dim(eq)
eq$loc=paste(eq$latitude, eq$longitude, sep=":")

G = gvisGeoChart(eq, "loc", "depth", "mag",
                 options=list(displayMode="Markers",
                              colorAxis="{colors:['purple', 'red', 'orange', 'grey']}",
                              backgroundColor="lightblue"), chartid="EQ")

plot(G)

## GVisOrgChart
Regions
Org <- gvisOrgChart(Regions, options=list(width=600, height=250,
                                          size='large', allowCollapse=TRUE))
plot(Org)

## Treemap
Tree <- gvisTreeMap(Regions, idvar="Region", parentvar="Parent", sizevar="Val",
                    colorvar="Fac", options=list(width=450, height=320))
plot(Tree)

library(shiny)
library(Cairo)
system.file("examples", package="shiny")
runExample("01_hello")
runExample("02_text")
runExample("04_mpg")
runExample("09_upload")
runExample("11_timer")

