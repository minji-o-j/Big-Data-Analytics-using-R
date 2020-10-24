#8-2. 산점도 - 변수 간 관계 표현하기
#----------------------
## ggplot2 로드
library(ggplot2)
library(dplyr) #mpg

## 1. 배경 설정하기
# x 축 displ , y 축 hwy 로 지정해 배경 생성
ggplot(data = mpg, aes(x = displ, y = hwy))


## 2. 그래프 추가하기
# 배경에 산점도 추가
ggplot(data = mpg, aes(x = displ, y = hwy)) + geom_point() 

####################
# dplyr: 연결시 %>%
# ggplot2: +
####################


## 3. 축 범위를 조정하는 설정 추가하기
# x 축 범위 3~6으로 지정
ggplot(data = mpg, aes(x = displ, y = hwy)) + geom_point() + xlim(3, 6) # x 범위 지정, +이용하여 추가 #기본은 최소~최댓값

# x 축 범위 3~6, y 축 범위 10~30으로 지정
ggplot(data = mpg, aes(x = displ, y = hwy)) +
  geom_point() +
  xlim(3, 6) +
  ylim(10, 30)


#----------------------
## ggplot2 코드 가독성 높이기
#한 줄로 작성
ggplot(data = mpg, aes(x = displ, y = hwy)) + geom_point() + xlim(3, 6) + ylim(10, 30)

#뒤에서 줄 바꾸기
ggplot(data = mpg, aes(x = displ, y = hwy)) +
  geom_point() +
  xlim(3, 6) +
  ylim(10, 30)