## ggplot2 로드
library(ggplot2)
#--------------------------------
#선그래프
#--------------------------------
#economics 데이터를 이용해서 분석 문제를 해결해 보세요.

#• Q1. psavert(개인 저축률)가 시간에 따라서 어떻게 변해왔는지 알아보려고 합니다. 시간에 따른 개인저축률의 변화를 나타낸 시계열 그래프를 만들어 보세요.
ggplot(data = economics, aes(x = date, y = psavert)) + geom_line()


#--------------------------------
# 상자 그림
#--------------------------------
# mpg 데이터를 이용해서 분석 문제를 해결해 보세요.

#• Q1. class(자동차 종류)가 "compact", "subcompact", "suv"인 자동차의 cty(도시 연비)가 어떻게 다른지 비교해보려고 합니다. 세 차종의 cty를 나타낸 상자 그림을 만들어보세요.
class_filter<-mpg %>% 
  filter(class %in% c("compact", "subcompact", "suv")) #match 연산자 이용

#class_filter

ggplot(data = class_filter, aes(x = class, y = cty)) + geom_boxplot()

