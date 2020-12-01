## t 검정 - 두 집단의 평균 비교
##------------------compact 자동차와 suv 자동차의 도시 연비 t 검정
#---- 데이터 준비
mpg <- as.data.frame(ggplot2::mpg)

library(dplyr)

mpg_diff <- mpg %>%
  select(class, cty) %>%
  filter(class %in% c("compact", "suv"))

head(mpg_diff)
#     class cty
# 1 compact  18
# 2 compact  21
# 3 compact  20
# 4 compact  21
# 5 compact  16
# 6 compact  18

table(mpg_diff$class) #빈도 확인
# compact     suv 
#     47      62 



#---- t-test
t.test(data = mpg_diff, cty ~ class, var.equal = T) # var.equal분산(퍼져있는 정도)

# 	Two Sample t-test
# data:  cty by class
# t = 11.917, df = 107, p-value < 2.2e-16  ##<<<<<p값이 작다: 유의
# alternative hypothesis: true difference in means is not equal to 0
# 95 percent confidence interval:
#   5.525180 7.730139
# sample estimates:
#   mean in group compact     mean in group suv 
#        20.12766              13.50000 



##------------------ 일반 휘발유와 고급 휘발유의 도시 연비 t 검정
#---- 데이터 준비
mpg_diff2 <- mpg %>%
  select(fl, cty) %>%
  filter(fl %in% c("r", "p")) # r: r egular, p: premium

table(mpg_diff2$fl)
#   p   r 
#  52 168 

#---- t-test
t.test(data = mpg_diff2, cty ~ fl, var.equal = T)

# 	Two Sample t-test
# data:  cty by fl
# t = 1.0662, df = 218, p-value = 0.2875  ##<<<<<p가 0.05(일반적인 값)보다크다: 통계적으로 의미가 없다.
# alternative hypothesis: true difference in means is not equal to 0
# 95 percent confidence interval:
#   -0.5322946  1.7868733
# sample estimates:
#   mean in group p mean in group r 
# 17.36538        16.73810 #실제로는 차이가 없는데 우연에의해 일어났을확률이 28.75%정도




##------------------ 12주차 건강검진데모자료(GJ_2002_SAMPLE.CSV)에서 성별에 따른 신장에 차이가 있는지 분석
# 건강검진데모자료 데이터 읽어오기
library(readr)
GJ_2002 <- read_csv("./Data/GJ_2002_SAMPLE.CSV", locale = locale(encoding = "euc-kr"))

# 데이터 요약
summary(GJ_2002)

# 데이터에서 성별코드와 신장 데이터
height_diff <- GJ_2002 %>%
  select(SEX, HEIGHT) %>%
  filter(SEX %in% c("1", "2"))

head(height_diff)
#     SEX HEIGHT
# <dbl>  <dbl>
# 1     2    150
# 2     2    160
# 3     1    175
# 4     1    175
# 5     2    150
# 6     2    155

# table 함수를 이용한 성별과 신장의 교차표
table(height_diff)
# HEIGHT
# SEX 140 145 150 155 160 165 170 175 180
# 1   0   0   1   6  19  40  42  19   9
# 2   5   3  19  21  11   5   0   0   0

# 성별과 신장의 t-검정
t.test(data = height_diff, HEIGHT ~ SEX, var.equal = T)

# 	Two Sample t-test
# data:  HEIGHT by SEX
# t = 14.864, df = 198, p-value < 2.2e-16 ##<작다: 유의
# alternative hypothesis: true difference in means is not equal to 0
# 95 percent confidence interval:
#   12.28846 16.04794
# sample estimates:
#   mean in group 1 mean in group 2 
# 167.6838        153.5156 
