getwd()
adt <- read.csv("./Data/AD_Tracking/train_sample.csv")
plot(adt$ip, main = "ip")
library(ggplot2)
library(ggthemes)
str(adt)
seq_along(ip)

ggplot(data = adt, aes(x = 1:nrow(adt) , y=ip, colour=as.factor(is_attributed))) + 
  geom_point(alpha=0.1, size=0.06) + labs(x="Index", colour ="is_attributed")


ggplot(data = adt, 
       aes(x = 1:nrow(adt) , y=app, 
           colour=as.factor(is_attributed))) + 
  geom_point(alpha=0.1, size=0.06) + 
  labs(x="Index", colour ="is_attributed") +
  theme(axis.text.x = element_text(angle =45, vjust = 0.5))

ggplot(data = adt, 
       aes(x = 1:nrow(adt) , y=device, 
           colour=as.factor(is_attributed))) + 
  geom_point(alpha=0.1, size=0.06) + 
  labs(x="Index", colour ="is_attributed") +
  theme(axis.text.x = element_text(angle =45, vjust = 0.5))

ggplot(data = adt, 
       aes(x = 1:nrow(adt) , y=os, 
           colour=as.factor(is_attributed))) + 
  geom_point(alpha=0.1, size=0.06) + 
  labs(x="Index", colour ="is_attributed") +
  theme(axis.text.x = element_text(angle =45, vjust = 0.5))


ggplot(data = adt, 
       aes(x = 1:nrow(adt) , y=channel, 
           colour=as.factor(is_attributed))) + 
  geom_point(alpha=0.1, size=0.06) + 
  labs(x="Index", colour ="is_attributed") +
  theme(axis.text.x = element_text(angle =45, vjust = 0.5))


library(gridExtra)
p1 <- ggplot(data = adt, 
            aes(x = 1:nrow(adt) , y=os, 
                colour=as.factor(is_attributed))) + 
  geom_point(alpha=0.1, size=0.06) + 
  labs(x="Index", colour ="is_attributed") +
  theme(axis.text.x = element_text(angle =45, vjust = 0.5))
p2 <- ggplot(data = adt, 
             aes(x = 1:nrow(adt) , y=channel, 
                 colour=as.factor(is_attributed))) + 
  geom_point(alpha=0.1, size=0.06) + 
  labs(x="Index", colour ="is_attributed") +
  theme(axis.text.x = element_text(angle =45, vjust = 0.5))
grid.arrange(p1,p2, ncol=2)
