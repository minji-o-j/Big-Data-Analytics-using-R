#시험공부
# midwest랑 mpg data 이용한다고 하셨음
### 연결?
library(dplyr)
#------------------------------------
## midwest
library(ggplot2) #여기에 데이터있다! 그래프 그릴때도 사용하는애
ggplot(data = midwest, aes(x = poptotal, y = popasian)) +
  geom_point() +
  xlim(0, 500000) +
  ylim(0, 10000)

#or

midwest <- as.data.frame(ggplot2::midwest)
#------------------------------------
## mpg
mpg <- as.data.frame(ggplot2::mpg)

table(mpg$year)

mpg$grade <- ifelse(mpg$total >= 30, "A",
                    ifelse(mpg$total >= 20, "B", "C"))

table(mpg$grade)
qplot(mpg$grade) # 등급 빈도 막대 그래프 생성

mpg$grade2 <- ifelse(mpg$total >= 30, "A",
                     ifelse(mpg$total >= 25, "B",
                            ifelse(mpg$total >= 20, "C", "D")))
table(mpg$grade2)

#---
#  4-groupby, summarise 퀴즈
# 1. 
mpg <- as.data.frame(ggplot2::mpg)
mpg %>% 
  head(3)
#  manufacturer model displ year cyl      trans drv cty hwy fl   class
# 1         audi    a4   1.8 1999   4   auto(l5)   f  18  29  p compact
# 2         audi    a4   1.8 1999   4 manual(m5)   f  21  29  p compact
# 3         audi    a4   2.0 2008   4 manual(m6)   f  20  31  p compact

mpg %>%
  group_by(class) %>% 
  summarise(mean_cty=mean(cty)) # mean_cty 안쓰면 그냥 mean(cty)로 나옴


#2
mpg %>%
  group_by(class) %>% 
  summarise(mean_cty=mean(cty)) %>% 
  arrange(desc(mean_cty)) # 평균이 높은 순서

#3
mpg %>% 
  group_by(manufacturer) %>% 
  summarise(mean_hwy=mean(hwy)) %>% 
  arrange(desc(mean_hwy)) %>% 
  head(3)

#4
mpg %>% 
  filter(class=='compact') %>% 
  group_by(manufacturer) %>% 
  summarise(count_compact=n()) %>% 
  arrange(desc(count_compact))

-----------------
  