library(data.table)
library(dplyr)
adt <- fread("./ADT/Data/train_sample.csv")
iris3A <- iris %>% filter(Species == "setosa") %>%
  select(Sepal.Length, Sepal.Width, Species)
head(iris3A)
iris3A <- iris3A %>% rename(sLength = Sepal.Length, sWidth = Sepal.Width)
iris3B <- iris3A %>% 
  mutate(sLength0_1 = ifelse(sLength >= 5.4, 1, 0))
head(iris3B)

iris %>%
  filter(!is.na(Sepal.Length)) %>%
  group_by(Species) %>%
  summarise(meanSL = mean(Sepal.Length), 
            meanSW = mean(Sepal.Width), 
            meanPL = mean(Petal.Length), 
            meanPW = mean(Petal.Width))

foo <- mtcars %>% filter(!is.na(cyl)) %>% group_by(cyl, am) %>%
  summarise(mean_mpg = mean(mpg))


library(ggplot2)
str(foo)
ggplot(data = foo, aes(x=cyl, y=mean_mpg, fill=as.factor(am))) + 
         geom_col()

ggplot(data = foo, aes(x=factor(cyl), y=mean_mpg, fill=as.factor(am))) + 
  geom_col()

os_is_attr <- adt %>% 
  filter(!is.na(is_attributed)) %>% 
  group_by(os) %>%
  summarise(sum_os_attr = sum(is_attributed)) %>% 
  arrange(desc(sum_os_attr)) %>% head(10)

ggplot(data = os_is_attr, aes(x=os, y=sum_os_attr)) + geom_col()
ggplot(data = os_is_attr, 
       aes(x=reorder(os, sum_os_attr), y=sum_os_attr)) + 
  geom_col() + coord_flip()
??grid.arrange
