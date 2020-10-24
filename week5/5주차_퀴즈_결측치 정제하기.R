# mpg 데이터를 이용해서 분석 문제를 해결해 보세요.
# mpg 데이터 원본에는결측치가 없습니다. 우선 mpg 데이터를 불러와 몇 개의 값을 결측치로 만들겠습니다.

# 아래 코드를 실행하면 다섯 행의 hwy 변수에 NA가 할당됩니다.

mpg <- as.data.frame(ggplot2::mpg) # mpg 데이터 불러오기
mpg[c(65, 124, 131, 153, 212), "hwy"] <- NA # NA 할당하기

head(mpg,3)
# manufacturer model displ year cyl      trans drv cty hwy fl   class
# 1         audi    a4   1.8 1999   4   auto(l5)   f  18  29  p compact
# 2         audi    a4   1.8 1999   4 manual(m5)   f  21  29  p compact
# 3         audi    a4   2.0 2008   4 manual(m6)   f  20  31  p compact

#--------------------
#결측치가 들어있는 mpg 데이터를 활용해서 문제를 해결해보세요.
#--------------------

#• Q1. drv(구동방식)별로 hwy(고속도로 연비) 평균이 어떻게 다른지 알아보려고 합니다. 분석을 하기 전에 우선 두 변수에 결측치가 있는지 확인해야 합니다. drv 변수와 hwy 변수에 결측치가 몇 개 있는지 알아보 세요

table(is.na(mpg$drv)) #결측치 없음
# FALSE 
#   234 

table(is.na(mpg$hwy)) #결측치 5개 있음
# FALSE  TRUE 
#   229     5

#--------------------
# • Q2. filter()를 이용해 hwy 변수의 결측치를 제외하고, 어떤 구동방식의 hwy 평균이 높은지 알아보세요. 하나의 dplyr 구문으로 만들어야 합니다.

library(dplyr) # dplyr 패키지 로드

mpg %>% 
  filter(!is.na(hwy)) %>% #결측치 제외
  group_by(drv) %>%     #drv 별로 분리
  summarise(hwy_mean_of_drv=mean(hwy)) #평균 구해서 summarise

# # A tibble: 3 x 2
#   drv   hwy_mean_of_drv
#   <chr>           <dbl>
# 1 4                19.2
# 2 f                28.2
# 3 r                21  