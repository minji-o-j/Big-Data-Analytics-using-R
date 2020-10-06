#mpg 데이터를 이용해 분석 문제를 해결해 보세요.
mpg <- as.data.frame(ggplot2::mpg) # mpg 데이터 불러오기
head(mpg,3)

#   manufacturer model displ year cyl      trans drv cty hwy fl   class
# 1         audi    a4   1.8 1999   4   auto(l5)   f  18  29  p compact
# 2         audi    a4   1.8 1999   4 manual(m5)   f  21  29  p compact
# 3         audi    a4   2.0 2008   4 manual(m6)   f  20  31  p compact


#-------------------------
##• Q1. 자동차 배기량에 따라 고속도로 연비가 다른지 알아보려고 합니다. displ(배기량)이 4 이하인 자동차와 5 이상인 자동차 중 어떤 자동차의 hwy(고속도로 연비)가 평균적으로 더 높은지 알아보세요.

# 배기량 4이하인 자동차
mpg_un4 <- mpg %>% filter(displ<=4)

# 배기량 5 이상인 자동차
mpg_up5 <- mpg %>% filter(displ>=5)

# 고속도로 연비(hwy)비교
mean(mpg_un4$hwy)
## [1] 25.96319

mean(mpg_up5$hwy)
## [1] 18.07895


#-------------------------
##• Q2. 자동차 제조 회사에 따라 도시 연비가 다른지 알아보려고 합니다. "audi"와 "toyota" 중 어느 manufacturer(자동차 제조 회사)의 cty(도시 연비)가 평균적으로 더 높은지 알아보세요.

# 회사별 변수 설정
mpg_audi <- mpg %>% filter(manufacturer=="audi")
mpg_toyota <- mpg %>% filter(manufacturer=="toyota")

# 도시 연비(cty) 비교
mean(mpg_audi$cty)
## [1] 17.61111

mean(mpg_toyota$cty)
## [1] 18.52941


#-------------------------
##• Q3. "chevrolet", "ford", "honda" 자동차의 고속도로 연비 평균을 알아보려고 합니다. 이 회사들의 자동차를 추출한 뒤 hwy 전체 평균을 구해보세요

# 자동차 추출
mpg_cfh <- mpg %>% filter(manufacturer %in% c("chevrolet", "ford", "honda"))

# hwy 평균
mean(mpg_cfh$hwy)
## [1] 22.50943