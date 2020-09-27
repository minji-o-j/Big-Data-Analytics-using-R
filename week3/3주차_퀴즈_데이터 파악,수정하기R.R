# mpg 데이터의 변수명은 긴 단어를 짧게 줄인 축약어로 되어있습니다. cty 변수는 도시 연비, hwy 변수는 고속도로 연비를 의미합니다. 변수명을 이해하기 쉬운 단어로 바꾸려고 합니다. mpg 데이터를 이용해서 아래 문제를 해결해 보세요.


## Q1. ggplot2 패키지의 mpg 데이터를 사용할 수 있도록 불러온 뒤 복사본을 만드세요
mpg <- as.data.frame(ggplot2::mpg)



## Q2. 복사본 데이터를 이용해서 cty는 city로, hwy는 highway로 변수명을 수정하세요
#패키지 로드
library(dplyr) # dplyr 로드

#복사
mpg_new<- mpg


#변수 바꾸기
mpg_new <- rename(mpg_new, city = cty)
mpg_new <- rename(mpg_new, highway = hwy)



## Q3. 데이터 일부를 출력해서 변수명이 바뀌었는지 확인해 보세요.
#바꾼것
head(mpg_new, 1)
#  manufacturer model displ year cyl    trans drv city highway fl   class
#1         audi    a4   1.8 1999   4 auto(l5)   f   18      29  p compact


#원본
head(mpg,1)
#   manufacturer model displ year cyl    trans drv cty hwy fl   class
# 1         audi    a4   1.8 1999   4 auto(l5)   f  18  29  p compact