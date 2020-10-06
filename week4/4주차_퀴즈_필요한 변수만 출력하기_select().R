# mpg 데이터를 이용해서 분석 문제를 해결해보세요.
mpg <- as.data.frame(ggplot2::mpg) # mpg 데이터 불러오기
head(mpg,3)

#   manufacturer model displ year cyl      trans drv cty hwy fl   class
# 1         audi    a4   1.8 1999   4   auto(l5)   f  18  29  p compact
# 2         audi    a4   1.8 1999   4 manual(m5)   f  21  29  p compact
# 3         audi    a4   2.0 2008   4 manual(m6)   f  20  31  p compact


#----------------------
##• Q1. mpg 데이터는 11 개 변수로 구성되어 있습니다. 이 중 일부만 추출해서 분석에 활용하려고 합니다. mpg데이터에서 class(자동차 종류), cty(도시 연비) 변수를 추출해 새로운 데이터를 만드세요. 새로 만든 데이터의 일부를 출력해서 두 변수로만 구성되어 있는지 확인하세요.

# 변수 추출
mpg_clct <- mpg %>% select(class,cty)

# data 확인
head(mpg_clct, 3)

#     class cty
# 1 compact  18
# 2 compact  21
# 3 compact  20


#----------------------
##• Q2. 자동차 종류에 따라 도시 연비가 다른지 알아보려고 합니다. 앞에서 추출한 데이터를 이용해서 class(자동차 종류)가 "suv"인 자동차와 "compact"인 자동차 중 어떤 자동차의 cty(도시 연비)가 더 높은지 알아보세요.

# 변수 설정
mpg_suv <- mpg_clct %>% filter(class=="suv")
mpg_compact <- mpg_clct %>% filter(class=="compact")

# 도시 연비(cty) 비교
mean(mpg_suv$cty)
## [1] 13.5

mean(mpg_compact$cty)
## [1] 20.12766
