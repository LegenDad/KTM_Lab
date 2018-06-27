library(ggplot2)
ggplot(mtcars, aes(factor(cyl), mpg)) + geom_violin(aes(fill = cyl))
ggplot(mtcars, aes(factor(cyl), mpg)) + geom_violin(aes(fill = factor(cyl)))

a=seq(129,1)+4*runif(129,0.4)
b=seq(1,129)^2+runif(129,0.98)

nf=layout(matrix(c(1,1,2,3), 2, 2, byrow = TRUE))
layout.show(nf)
hist(a , breaks=30 , border=F , col=rgb(0.1,0.8,0.3,0.5) , 
     xlab="distribution of a" , main="")
boxplot(a , xlab="a" , col=rgb(0.8,0.8,0.3,0.5) , las=2)
boxplot(b , xlab="b" , col=rgb(0.4,0.2,0.3,0.5) , las=2)

nf<-layout(matrix(c(1,1,2,3),2,2,byrow=TRUE), c(3,1), c(2,2),TRUE) 
layout.show(nf)

#Add the plots
hist(a , breaks=30 , border=F , col=rgb(0.1,0.8,0.3,0.5) , 
     xlab="distribution of a" , main="")
boxplot(a , xlab="a" , col=rgb(0.8,0.8,0.3,0.5) , las=2)
boxplot(b , xlab="b" , col=rgb(0.4,0.2,0.3,0.5) , las=2)

# install.packages("geojsonio")
# install.packages("broom")
library(geojsonio)
spdf <- geojson_read("https://raw.githubusercontent.com/gregoiredavid/france-geojson/master/communes.geojson",  what = "sp")
spdf = spdf[ substr(spdf@data$code,1,2)  %in% 
               c("06", "83", "13", "30", "34", "11", "66") , ]
head(spdf,5)

library(broom)
spdf_fortified <- tidy(spdf, region = "code")


ggplot() +
  geom_polygon(data = spdf_fortified, 
               aes( x = long, y = lat, group = group)) +
  theme_void() +
  coord_map()

data=read.table("https://www.r-graph-gallery.com/wp-content/uploads/2017/12/data_on_french_states.csv", header=T, sep=";")
head(data)

data %>% ggplot( aes(x=nb_equip)) + 
  geom_histogram(bins=20, fill='skyblue', color='white') + scale_x_log10()

library(dplyr)
spdf_fortified = spdf_fortified %>%
  left_join(. , data, by=c("id"="depcom")) 

spdf_fortified$nb_equip[ is.na(spdf_fortified$nb_equip)] = 0.001

ggplot() +
  geom_polygon(data = spdf_fortified, 
               aes(fill = nb_equip, x = long, y = lat, group = group)) +
  theme_void() + coord_map()

library(viridis)
p <- ggplot() +
  geom_polygon(data = spdf_fortified, 
               aes(fill = nb_equip, x = long, y = lat, group = group) , 
               size=0, alpha=0.9) +
  theme_void() +
  scale_fill_viridis(trans = "log", breaks=c(1,5,10,20,50,100), 
                     name="Number of restaurant", 
                     guide = guide_legend( keyheight = unit(3, units = "mm"), 
                                           keywidth=unit(12, units = "mm"), 
                                           label.position = "bottom", 
                                           title.position = 'top', nrow=1) ) +
  labs(
    title = "South of France Restaurant concentration",
    subtitle = "Number of restaurant per city district", 
    caption = "Data: INSEE | Creation: Yan Holtz | r-graph-gallery.com"
  ) +
  theme(
    text = element_text(color = "#22211d"), 
    plot.background = element_rect(fill = "#f5f5f2", color = NA), 
    panel.background = element_rect(fill = "#f5f5f2", color = NA), 
    legend.background = element_rect(fill = "#f5f5f2", color = NA),
    
    plot.title = element_text(size= 22, hjust=0.01, color = "#4e4d47", margin = margin(b = -0.1, t = 0.4, l = 2, unit = "cm")),
    plot.subtitle = element_text(size= 17, hjust=0.01, color = "#4e4d47", margin = margin(b = -0.1, t = 0.43, l = 2, unit = "cm")),
    plot.caption = element_text( size=12, color = "#4e4d47", margin = margin(b = 0.3, r=-99, unit = "cm") ),
    
    legend.position = c(0.7, 0.09)
  ) +
  coord_map()
p


# install.packages("plotly")
# install.packages("gapminder")
library(ggplot2)
library(plotly)
library(gapminder)

p <- gapminder %>%
  filter(year==1977) %>%
  ggplot( aes(gdpPercap, lifeExp, size = pop, color=continent)) +
  geom_point() +
  scale_x_log10() +
  theme_bw()

ggplotly(p)

a=rnorm(100)
b=sample( c(1:10) , 100 , replace=T)


my_graph=plot_ly(x=b , y=a , mode="markers" , 
                 size=abs(a)/2 , color=ifelse(a>0,"blue","red") ) %>% 
  layout( hovermode="closest" )

my_graph

a=c(1,1,3,4,5,5,1,1,2,3,4,1,3,2,1,1,5,1,4,3,2,3,1,0,2)
b=c(1,2,3,5,5,5,2,1,1,3,4,3,3,4,1,1,4,1,4,2,2,3,0,0,1)

AA=xyTable(a,b)
coeff_bigger=2
plot(AA$x , AA$y , cex=AA$number*coeff_bigger  , 
     pch=16 , col=rgb(0,0,1,0.5) , xlab= "value of a" , 
     ylab="value of b" , xlim=c(0,6) , ylim=c(0,6) )
text (AA$x , AA$y , AA$number )


represent_discrete_variable=function(var1, var2 , coeff_bigger){
  AA=xyTable(var1,var2)
  plot(AA$x , AA$y , cex=AA$number*coeff_bigger  , pch=16 , col="chocolate1" , xlab= "value of a" , ylab="value of b" )
  text (AA$x , AA$y , AA$number )
}


library(tidyverse)

a <- data.frame( x=rnorm(20000, 10, 1.9), y=rnorm(20000, 10, 1.2) )
b <- data.frame( x=rnorm(20000, 14.5, 1.9), y=rnorm(20000, 14.5, 1.9) )
c <- data.frame( x=rnorm(20000, 9.5, 1.9), y=rnorm(20000, 15.5, 1.9) )
data <- rbind(a,b,c)

ggplot(data, aes(x=x, y=y) ) +  geom_point()
ggplot(data, aes(x=x, y=y) ) +  geom_hex() +  theme_bw()
ggplot(data, aes(x=x, y=y) ) +  geom_hex(bins = 70) + theme_bw()
ggplot(data, aes(x=x, y=y) ) +  geom_density_2d()
ggplot(data, aes(x=x, y=y) ) +  
  stat_density_2d(aes(fill = ..level..), geom = "polygon")
ggplot(data, aes(x=x, y=y) ) +
  stat_density_2d(aes(fill = ..level..), geom = "polygon", colour="white")
ggplot(data, aes(x=x, y=y) ) +
  stat_density_2d(aes(fill = ..density..), geom = "raster", contour = FALSE) +
  scale_x_continuous(expand = c(0, 0)) +
  scale_y_continuous(expand = c(0, 0)) +
  theme(legend.position='none')

x=seq(0, 2*pi, length.out=100)
data=data.frame(x=x, y=sin(x) + rnorm(100, sd=0.2))

data=data %>% mutate(mycolor = ifelse(y>0, "type1", "type2"))

ggplot(data, aes(x=x, y=y)) +
  geom_segment( aes(x=x, xend=x, y=0, yend=y, color=mycolor), size=1.3, alpha=0.9) +
  theme_light() +
  theme(legend.position = "none", 
        panel.border = element_blank()) +   xlab("") +   ylab("Value of Y")

