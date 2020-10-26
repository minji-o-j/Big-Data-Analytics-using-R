library(dplyr)
library(ggplot2)
midwest <- as.data.frame(ggplot2::midwest)

midwest$ratio_asian <- midwest$popasian/midwest$poptotal*100
midwest %>% 
  arrange(midwest$ratio) %>% 
  select('state','county','ratio_asian') %>% 
  head(10)