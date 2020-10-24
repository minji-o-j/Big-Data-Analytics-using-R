#08-3. 막대 그래프 - 집단 간 차이 표현하기
#----------------------
## ggplot2 로드
library(ggplot2)
#--------------------------------
# 막대 그래프 1 - 평균 막대 그래프 만들기
#--------------------------------
## 데이터 요약 평균표 생성-> 평균표를 이용한 그래프 생성 "geom_col()


##각 집단의 평균값을 막대 길이로 표현한 그래프

#1. 집단별 평균표 만들기
library(dplyr)
df_mpg <- mpg %>%
  group_by(drv) %>%
  summarise(mean_hwy = mean(hwy))

df_mpg
# # A tibble: 3 x 2
#   drv   mean_hwy
#   <chr>    <dbl>
# 1 4         19.2
# 2 f         28.2
# 3 r         21 


# 2. 그래프 생성하기
ggplot(data = df_mpg, aes(x = drv, y = mean_hwy)) + geom_col()


#3. 크기 순으로 정렬하기
ggplot(data = df_mpg, aes(x = reorder(drv, -mean_hwy), y = mean_hwy)) + geom_col()
### reorder: 정렬, 기본값 오름차순, -사용하면 내림차순


#--------------------------------
#막대 그래프 2 - 빈도 막대 그래프
#--------------------------------
## 별도의 표 만들지 않고 원자료 이용하여 그래프 생성 -> "geom_bar"

## 값의 개수(빈도)로 막대의 길이를 표현한 그래프

# x 축 범주 변수, y 축 빈도
ggplot(data = mpg, aes(x = drv)) + geom_bar()

# x 축 연속 변수, y 축 빈도 --> 값의 분포 확인 하기 좋다
ggplot(data = mpg, aes(x = hwy)) + geom_bar()
