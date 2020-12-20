# mpg 데이터의 drv 변수는 자동차의 구동 방식을 나타냅니다. mpg 데이터를 이용해 아래 문제를 해결해 보세요.
library(dplyr)
mpg <- as.data.frame(ggplot2::mpg) # mpg 데이터 불러오기


#• Q1. drv 변수의 타입을 확인해 보세요.
class(mpg$drv) # 타입 확인
# [1] "character"


#• Q2. drv 변수를 as.factor()를 이용해 factor 타입으로 변환한 후 다시 타입을 확인해 보세요.
mpg$drv <- as.factor(mpg$drv) # factor 로 변환
class(mpg$drv) # 타입 확인
# [1] "factor"


#• Q3. drv가 어떤 범주로 구성되는지 확인해 보세요
levels(mpg$drv) # 범주 확인
# [1] "4" "f" "r"