## ggplot2 로드
library(ggplot2)
#----------------------
#mpg 데이터를 이용해서 분석 문제를 해결해 보세요.
library(dplyr)
head(mpg,3)
table(mpg$class)
#  2seater    compact    midsize    minivan     pickup subcompact        suv 
#        5         47         41         11         33         35         62 

#----------------------------
#• Q1. 어떤 회사에서 생산한 "suv" 차종의 도시 연비가 높은지 알아보려고 합니다. "suv" 차종을 대상으로 평균 cty(도시 연비)가 가장 높은 회사 다섯 곳을 막대 그래프로 표현해 보세요. 막대는 연비 가 높은 순으로 정렬하세요.

#평균 표 생성
df_suvcty <- mpg %>%
  filter(class=="suv") %>%  #suv 차종 대상
  group_by(manufacturer) %>%  #회사(제조사) 기준 cty 비교
  summarize(mean_cty=mean(cty)) %>% #cty 평균
  arrange(desc(mean_cty)) %>% #내림차순(큰순) 정렬
  head(5) #상위5개

#그래프 생성
ggplot(data = df_suvcty, aes(x = reorder(manufacturer,-mean_cty), y = mean_cty)) + geom_col()

#----------------------------
#• Q2. 자동차 중에서 어떤 class(자동차 종류)가 가장 많은지 알아보려고 합니다. 자동차 종류별 빈도를표현한 막대 그래프를 만들어 보세요.

ggplot(data=mpg, aes(x=class))+geom_bar()
