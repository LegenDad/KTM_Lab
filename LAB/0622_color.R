# install.packages("igraph") 
# install.packages("network") 
# install.packages("sna")
# install.packages("visNetwork")
# install.packages("threejs")
# install.packages("networkD3")
# install.packages("ndtv")

require("igraph") 
require("network") 
require("sna")
require("visNetwork")
require("threejs")
require("networkD3")
require("ndtv")

plot(x=1:10, y=rep(5,10), pch=19, cex=3, col="dark red")
points(x=1:10, y=rep(6, 10), pch=19, cex=3, col="557799")
points(x=1:10, y=rep(4, 10), pch=19, cex=3, col=rgb(.25, .5, .3))


plot(x=1:5, y=rep(5,5), pch=19, cex=20, 
     col=rgb(.25, .5, .3, alpha=.5), xlim=c(0,6))

par(bg="gray40")
col.tr <- grDevices::adjustcolor("557799", alpha=0.7)
plot(x=1:5, y=rep(5,5), pch=19, cex=20, col=col.tr, xlim=c(0,6))
# colors()
grep("blue", colors(), value=T) 
grep("blue", colors()) 

pal1 <- heat.colors(5, alpha=1)   
pal2 <- rainbow(5, alpha=.5)      
plot(x=1:10, y=1:10, pch=19, cex=5, col=pal1)
plot(x=1:10, y=1:10, pch=19, cex=5, col=pal2)

palf <- colorRampPalette(c("gray70", "dark red", "orange"))  
plot(x=10:1, y=1:10, pch=19, cex=5, col=palf(10))

palf <- colorRampPalette(c(rgb(1,1,1, .2),rgb(.8,0,0, .7)), alpha=TRUE)
plot(x=10:1, y=1:10, pch=19, cex=5, col=palf(10))

library(RColorBrewer)
display.brewer.all()
display.brewer.pal(8, "Set3")
