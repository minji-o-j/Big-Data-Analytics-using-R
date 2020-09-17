# ggplot2 패키지 설치, 로드하기
install.packages("ggplot2") # 패키지 설치 - 따옴표 붙는다
library(ggplot2)            # 패키지 로드 - 따옴표x

#----
# 함수 사용하기
## 여러 문자로 구성된 변수 생성
x<-c("a","a","b","c")
x
# [1] "a" "a" "b" "c"

#빈도 그래프 출력
qplot(x)

##ggplot2의 mpg 데이터로 그래프 만들기
### data에 mpg, x축에 hwy 변수 지정하여 그래프 생성
qplot(data=mpg, x=hwy) #함수의 성능을 측정할 수 있는 데이터들 사용

#----
##qplot()파라미터 바꿔보기
###x축이 cty
qplot(data=mpg,x=cty)

###x축 drv, y축 hwy, 점 그래프
qplot(data=mpg,x=drv, y=hwy)

### x축 drv, y축 hwy, 선그래프
qplot(data=mpg,x=drv, y=hwy, geom="line")

### x축 drv, y축 hwy, 상자 그림 형태
qplot(data=mpg,x=drv, y=hwy, geom="boxplot")

### x축 drv, y축 hwy, 상자 그림 형태, drv별 색 표현
qplot(data=mpg,x=drv, y=hwy, geom="boxplot", colour=drv)


#---
#함수 기능 확인
?qplot
