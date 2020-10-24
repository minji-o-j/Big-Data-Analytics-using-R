#이상치 제거하기 - 1. 존재할 수 없는 값-----------------
## ex) 성별 변수인데 3      --> 결측 처리
## ex) 몸무게 변수인데 300  --> 정상범위 기준 정해서 결측 처리


##이상치 포함된 데이터 생성 - sex 3, score 6
outlier <- data.frame(sex = c(1, 2, 1, 3, 2, 1),
                      score = c(5, 4, 3, 4, 2, 6))
outlier
#   sex score
# 1   1     5
# 2   2     4
# 3   1     3
# 4   3     4
# 5   2     2
# 6   1     6


## 이상치 확인하기
table(outlier$sex)

#
# 1 2 3 
# 3 2 1 


table(outlier$score)

#
# 2 3 4 5 6 
# 1 1 2 1 1 


## 결측 처리하기 - sex ##이상치를 결측치로!

# sex 가 3 이면 NA 할당
outlier$sex <- ifelse(outlier$sex == 3, NA, outlier$sex)
outlier
#   sex score
# 1   1     5
# 2   2     4
# 3   1     3
# 4  NA     4
# 5   2     2
# 6   1     6


## 결측 처리하기 - score  ##이상치를 결측치로!

# score 가 1~5 아니면 NA 할당
outlier$score <- ifelse(outlier$score > 5, NA, outlier$score)
outlier
#   sex score
# 1   1     5
# 2   2     4
# 3   1     3
# 4  NA     4
# 5   2     2
# 6   1    NA


## 결측치 제외하고 분석
outlier %>%
  filter(!is.na(sex) & !is.na(score)) %>%
  group_by(sex) %>%
  summarise(mean_score = mean(score))
# # A tibble: 2 x 2
#    sex mean_score
#   <dbl>      <dbl>
# 1     1          4
# 2     2          3





#이상치 제거하기 - 2. 극단적인 값-----------------
## ex) 논리적 판단 : 성인 몸무게 40kg~150kg 벗어나면 극단치
## ex) 통계적 판단 : 상하위 0.3% 극단치 또는 상자그림 1.5 IQR 벗어나면 극단치



## 상자그림으로 극단치 기준 정해서 제거하기
# 상자그림 생성
mpg <- as.data.frame(ggplot2::mpg)
boxplot(mpg$hwy)


#상자그림 통계치 출력
boxplot(mpg$hwy)$stats 
#       [,1]
# [1,]   12
# [2,]   18
# [3,]   24
# [4,]   27
# [5,]   37
# attr(,"class")
# 1 
# "integer" 


# 결측 처리하기
# 12~37 벗어나면 NA 할당
mpg$hwy <- ifelse(mpg$hwy < 12 | mpg$hwy > 37, NA, mpg$hwy)
table(is.na(mpg$hwy))

# FALSE  TRUE 
#   231     3 


# 결측치 제외하고 분석하기
mpg %>%
  group_by(drv) %>%
  summarise(mean_hwy = mean(hwy, na.rm = T))

# # A tibble: 3 x 2
#   drv   mean_hwy
#   <chr>    <dbl>
# 1 4         19.2
# 2 f         27.7
# 3 r         21  