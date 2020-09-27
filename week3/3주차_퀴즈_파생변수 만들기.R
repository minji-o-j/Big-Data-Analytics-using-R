#ggplot2 패키지에는 미국 동북중부 437개 지역의 인구통계 정보를 담은 midwest라는 데이터가 포함되어 있습니다

#midwest 데이터를 사용해 데이터 분석 문제를 해결해보세요.

##---------------------------
##• 문제1. ggplot2의 midwest 데이터를 데이터 프레임 형태로 불러와서 데이터의 특성을 파악하세요.

midwest <- as.data.frame(ggplot2::midwest)
head(midwest)
#생략

tail(midwest)
#생략

View(midwest)

dim(midwest)
#[1] 437  28

str(midwest)
# 'data.frame':	437 obs. of  28 variables:
# $ PID                 : int  561 562 563 564 565 566 567 568 569 570 ...
# $ county              : chr  "ADAMS" "ALEXANDER" "BOND" "BOONE" ...
# $ state               : chr  "IL" "IL" "IL" "IL" ...
# $ area                : num  0.052 0.014 0.022 0.017 0.018 0.05 0.017 0.027 0.024 0.058 ...
# $ poptotal            : int  66090 10626 14991 30806 5836 35688 5322 16805 13437 173025 ...
# $ popdensity          : num  1271 759 681 1812 324 ...
# $ popwhite            : int  63917 7054 14477 29344 5264 35157 5298 16519 13384 146506 ...
# $ popblack            : int  1702 3496 429 127 547 50 1 111 16 16559 ...
# $ popamerindian       : int  98 19 35 46 14 65 8 30 8 331 ...
# $ popasian            : int  249 48 16 150 5 195 15 61 23 8033 ...
# $ popother            : int  124 9 34 1139 6 221 0 84 6 1596 ...
# $ percwhite           : num  96.7 66.4 96.6 95.3 90.2 ...
# $ percblack           : num  2.575 32.9 2.862 0.412 9.373 ...
# $ percamerindan       : num  0.148 0.179 0.233 0.149 0.24 ...
# $ percasian           : num  0.3768 0.4517 0.1067 0.4869 0.0857 ...
# $ percother           : num  0.1876 0.0847 0.2268 3.6973 0.1028 ...
# $ popadults           : int  43298 6724 9669 19272 3979 23444 3583 11323 8825 95971 ...
# $ perchsd             : num  75.1 59.7 69.3 75.5 68.9 ...
# $ percollege          : num  19.6 11.2 17 17.3 14.5 ...
# $ percprof            : num  4.36 2.87 4.49 4.2 3.37 ...
# $ poppovertyknown     : int  63628 10529 14235 30337 4815 35107 5241 16455 13081 154934 ...
# $ percpovertyknown    : num  96.3 99.1 95 98.5 82.5 ...
# $ percbelowpoverty    : num  13.15 32.24 12.07 7.21 13.52 ...
# $ percchildbelowpovert: num  18 45.8 14 11.2 13 ...
# $ percadultpoverty    : num  11.01 27.39 10.85 5.54 11.14 ...
# $ percelderlypoverty  : num  12.44 25.23 12.7 6.22 19.2 ...
# $ inmetro             : int  0 0 0 1 0 0 0 0 0 1 ...
# $ category            : chr  "AAR" "LHR" "AAR" "ALU" ...

summary(midwest)
#생략


##---------------------------
##• 문제2. poptotal(전체 인구)을 total로, popasian(아시아 인구)을 asian으로 변수명을 수정하세요.

#패키지 로드
library(dplyr) # dplyr 로드

#복사
midwest_new <- midwest

#변수명 수정
midwest_new <- rename(midwest_new, total=poptotal)
midwest_new <- rename(midwest_new, asian=popasian)


##---------------------------
##• 문제3. total, asian 변수를 이용해 '전체 인구 대비 아시아 인구 백분율' 파생변수를 만들고, 히스토그램을 만들어 도시들이 어떻게 분포하는지 살펴보세요.

#파생변수 생성
midwest_new$asian_pertotal <- midwest_new$asian/midwest_new$total*100

#확인
head(midwest_new,1)

#히스토그램
hist(midwest_new$asian_pertotal)


##---------------------------
##• 문제4. 아시아 인구 백분율 전체 평균을 구하고, 평균을 초과하면 "large", 그 외에는 "small"을 부여하는 파생변수를 만들어 보세요.

#평균 구하기
asian_ratio_mean<-mean(midwest_new$asian_pertotal)
asian_ratio_mean
#[1] 0.4872462


#조건문
midwest_new$compare_mean<- ifelse(midwest_new$asian_pertotal>asian_ratio_mean,"large","small")

#확인
head(midwest_new,10)


##---------------------------
##• 문제5. "large"와 "small"에 해당하는 지역이 얼마나 되는지, 빈도표와 빈도 막대 그래프를 만들어 확인해 보세요.
table(midwest_new$compare_mean)
#large small 
#119   318 

qplot(midwest_new$compare_mean)
