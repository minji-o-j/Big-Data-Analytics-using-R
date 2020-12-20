##------------------ 실업자 수와 개인 소비 지출의 상관관계  unemploy(실업자 수)와 pce(개인 소비 지출)
#----- 데이터 준비
economics <- as.data.frame(ggplot2::economics)


#----- 상관분석
cor.test(economics$unemploy, economics$pce)

# Pearson's product-moment correlation
# 
# data:  economics$unemploy and economics$pce
# t = 18.63, df = 572, p-value < 2.2e-16
# alternative hypothesis: true correlation is not equal to 0
# 95 percent confidence interval:
#  0.5608868 0.6630124
# sample estimates:
#       cor 
# 0.6145176 # <<<< 상관계수: 0.7에가깝 - 어느정도 관계 있다.


##------------------12주차 건강검진데모자료(GJ_2002_SAMPLE.CSV)에서 신장과 체중이 관계가 있는지, 있다면 얼마나 있는지 분석

#-----  건강검진데모자료에서 신장과 체중 데이터 가져오기
HE_WE <- GJ_2002 %>%
  select(HEIGHT, WEIGHT)

head(HE_WE)

# # A tibble: 6 x 2
#    HEIGHT WEIGHT
# <dbl>  <dbl>
# 1    150     40
# 2    160     45
# 3    175     55
# 4    175     70
# 5    150     50
# 6    155     50


#-----  컬럼을 지정한 상관분석
cor(HE_WE$HEIGHT, HE_WE$WEIGHT, method="pearson") #pearson으로할 경우 안써도됨
# [1] 0.6790954


#-----  데이터 전체를 지정한 상관분석
cor(HE_WE, method="pearson")
#           HEIGHT    WEIGHT
# HEIGHT 1.0000000 0.6790954
# WEIGHT 0.6790954 1.0000000

#-----  p 값을 확인하기 위한 상관분석
cor.test(HE_WE$HEIGHT, HE_WE$WEIGHT)

# 	Pearson's product-moment correlation
# data:  HE_WE$HEIGHT and HE_WE$WEIGHT
# t = 13.018, df = 198, p-value < 2.2e-16 #t값도 유의함
# alternative hypothesis: true correlation is not equal to 0
# 95 percent confidence interval:
#   0.5965615 0.7474161
# sample estimates:
#   cor 
# 0.6790954 #<<상관관계가 꽤 있다.


##------------------ 상관행렬 히트맵 만들기, cor()를 이용하여 상관행렬을 만들 수 있음
#-----  데이터 준비
head(mtcars) #자동차 32종의 11개 속성에 대한 정보를 담고 있는 데이터

#                   mpg cyl disp  hp drat    wt  qsec vs am gear carb
# Mazda RX4         21.0   6  160 110 3.90 2.620 16.46  0  1    4    4
# Mazda RX4 Wag     21.0   6  160 110 3.90 2.875 17.02  0  1    4    4
# Datsun 710        22.8   4  108  93 3.85 2.320 18.61  1  1    4    1
# Hornet 4 Drive    21.4   6  258 110 3.08 3.215 19.44  1  0    3    1
# Hornet Sportabout 18.7   8  360 175 3.15 3.440 17.02  0  0    3    2
# Valiant           18.1   6  225 105 2.76 3.460 20.22  1  0    3    1

#-----  상관행렬 만들기
car_cor <- cor(mtcars) # 상관행렬 생성
round(car_cor, 2) # 소수점 셋째 자리에서 반올림해서 출력(2자리까지)
#        mpg   cyl  disp    hp  drat    wt  qsec    vs    am  gear  carb
# mpg   1.00 -0.85 -0.85 -0.78  0.68 -0.87  0.42  0.66  0.60  0.48 -0.55
# cyl  -0.85  1.00  0.90  0.83 -0.70  0.78 -0.59 -0.81 -0.52 -0.49  0.53
# disp -0.85  0.90  1.00  0.79 -0.71  0.89 -0.43 -0.71 -0.59 -0.56  0.39
# hp   -0.78  0.83  0.79  1.00 -0.45  0.66 -0.71 -0.72 -0.24 -0.13  0.75
# drat  0.68 -0.70 -0.71 -0.45  1.00 -0.71  0.09  0.44  0.71  0.70 -0.09
# wt   -0.87  0.78  0.89  0.66 -0.71  1.00 -0.17 -0.55 -0.69 -0.58  0.43
# qsec  0.42 -0.59 -0.43 -0.71  0.09 -0.17  1.00  0.74 -0.23 -0.21 -0.66
# vs    0.66 -0.81 -0.71 -0.72  0.44 -0.55  0.74  1.00  0.17  0.21 -0.57
# am    0.60 -0.52 -0.59 -0.24  0.71 -0.69 -0.23  0.17  1.00  0.79  0.06
# gear  0.48 -0.49 -0.56 -0.13  0.70 -0.58 -0.21  0.21  0.79  1.00  0.27
# carb -0.55  0.53  0.39  0.75 -0.09  0.43 -0.66 -0.57  0.06  0.27  1.00

#-----  상관행렬 히트맵 만들기
install.packages("corrplot") #히트맵그리기
library(corrplot)

corrplot(car_cor)
#상관관계 양수: 파란색, 음수:빨간색
#상관관계 클수록 원의 크기가 크고 색깔이 진함

#-----  원 대신 상관계수 표시
corrplot(car_cor, method = "number")

#-----  다양한 파라미터 지정하기
col <- colorRampPalette(c("#BB4444", "#EE9988", "#FFFFFF", "#77AADD", "#4477AA"))
corrplot(car_cor,
         method = "color", # 색깔로 표현
         col = col(200), # 색상 200개 선정
         type = "lower", # 왼쪽 아래 행렬만 표시
         order = "hclust", # 유사한 상관계수끼리 군집화
         addCoef.col = "black", # 상관계수 색깔
         tl.col = "black", # 변수명 색깔
         tl.srt = 45, # 변수명 45도 기울임
         diag = F) # 대각 행렬 제외
