library(dplyr)
library(ggplot2)
midwest <- as.data.frame(ggplot2::midwest)
mpg <- as.data.frame(ggplot2::mpg)

df_sports<-data.f
df_sports

#-----
df<-mpg %>% select(class, cty)
df

midwest$ratio_asian <- midwest$popasian/midwest$poptotal*100
midwest %>% 
  arrange(midwest$ratio) %>% 
  select('state','county','ratio_asian') %>% 
  head(10)
