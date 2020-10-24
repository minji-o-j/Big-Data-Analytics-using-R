#결측치 찾기-----------------

## 결측치 만들기
df <- data.frame(sex = c("M", "F", NA, "M", "F"),
                 score = c(5, 4, 3, 4, NA))   ### [유의] NA 앞 뒤에 겹따옴표 없음

df
#    sex score
# 1    M     5
# 2    F     4
# 3 <NA>     3  # 문자열은 <NA>
# 4    M     4
# 5    F    NA  # 숫자는 그냥 NA



## 결측치 확인하기

is.na(df) # 결측치 확인 is.na()   ->있으면 True
#        sex score
# [1,] FALSE FALSE
# [2,] FALSE FALSE
# [3,]  TRUE FALSE
# [4,] FALSE FALSE
# [5,] FALSE  TRUE
      
   
table(is.na(df)) # 결측치 빈도 출력

# FALSE  TRUE 
#     8     2 



## 변수별로 결측치 확인하기

table(is.na(df$sex)) # sex 결측치 빈도 출력
# FALSE  TRUE 
#     4     1

table(is.na(df$score)) # score 결측치 빈도 출력
# FALSE  TRUE 
#     4     1



## 결측치 포함된 상태로 분석  --> NA가 나온다.
mean(df$score) # 평균 산출
# [1] NA

sum(df$score) # 합계 산출
# [1] NA




#결측치 제거하기-----------------

## 결측치 있는 행 제거하기

library(dplyr) # dplyr 패키지 로드

df %>% filter(is.na(score)) # score 가 NA 인 데이터만 출력
#   sex score
# 1   F    NA

df %>% filter(!is.na(score)) # score 결측치 제거, !를 이용해 결측치가 아닌 것을 보여준다.
#    sex score
# 1    M     5
# 2    F     4
# 3 <NA>     3
# 4    M     4



## 결측치 제외한 데이터로 분석하기

df_nomiss <- df %>% filter(!is.na(score)) # score 결측치 제거
mean(df_nomiss$score) # score 평균 산출
# [1] 4

sum(df_nomiss$score) # score 합계 산출
# [1] 16



## 여러 변수 동시에 결측치 없는 데이터 추출하기

# score, sex 결측치 제외
df_nomiss <- df %>% filter(!is.na(score) & !is.na(sex))
df_nomiss
#   sex score
# 1   M     5
# 2   F     4
# 3   M     4


## 결측치가 하나라도 있으면 제거하기
### 분석에 필요한 데이터까지 손실 될 가능성 유의 
### : ex) 성별-소득 관계 분석하는데 지역 결측치까지 제거 ->na.omit 보다 filter함수가 좀더 안전..

df_nomiss2 <- na.omit(df) # 모든 변수에 결측치 없는 데이터 추출 "na.omit()"
df_nomiss2 # 출력
#   sex score
# 1   M     5
# 2   F     4
# 3   M     4




#함수의 결측치 제외 기능 이용하기 - na.rm = T : 함수의 파라미터임!-----------------

mean(df$score, na.rm = T) # 결측치 제외하고 평균 산출
# [1] 4
sum(df$score, na.rm = T) # 결측치 제외하고 합계 산출
# [1] 16


## 결측치 생성
exam <- read.csv("Data/csv_exam.csv") # 데이터 불러오기
exam[c(3, 8, 15), "math"] <- NA # 3, 8, 15 행의 math 에 NA 할당
exam
#    id class math english science
# 1   1     1   50      98      50
# 2   2     1   60      97      60
# 3   3     1   NA      86      78
# 4   4     1   30      98      58
# 5   5     2   25      80      65
# 6   6     2   50      89      98
# 7   7     2   80      90      45
# 8   8     2   NA      78      25
# 9   9     3   20      98      15
# 10 10     3   50      98      45
# 11 11     3   65      65      65
# 12 12     3   45      85      32
# 13 13     4   46      98      65
# 14 14     4   48      87      12
# 15 15     4   NA      56      78
# 16 16     4   58      98      65
# 17 17     5   65      68      98
# 18 18     5   80      78      90
# 19 19     5   89      68      87
# 20 20     5   78      83      58



## summarise()에서 na.rm = T사용하기

#- 평균 구하기
exam %>% summarise(mean_math = mean(math)) # 평균 산출
#   mean_math
# 1        NA

exam %>% summarise(mean_math = mean(math, na.rm = T)) # 결측치 제외하고 평균 산출
#   mean_math
# 1  55.23529


#-다른 함수들에 적용
exam %>% summarise(mean_math = mean(math, na.rm = T), # 평균 산출
                   sum_math = sum(math, na.rm = T), # 합계 산출
                  median_math = median(math, na.rm = T)) # 중앙값 산출

#   mean_math sum_math median_math
# 1  55.23529      939          50




# 결측치 대체하기 -----------------

## 모두 대체하면 데이터 손실이 크므로 다른 값을 채워넣자!
### 대표값(평균, 최빈값 등)으로
### 통계분석 기법을 적용하여 예측값 추정


# 평균값으로 결측치 대체하기 -----------------

## 평균 구하기
mean(exam$math, na.rm = T) # 결측치 제외하고 math 평균 산출 
# [1] 55.23529


## 평균으로 대체하기
exam$math <- ifelse(is.na(exam$math), 55, exam$math) # math가 NA면 55로 대체, 아니면 원래값 그대로
table(is.na(exam$math)) # 결측치 빈도표 생성
# 
# FALSE 
#   20 


exam # 출력
#    id class math english science
# 1   1     1   50      98      50
# 2   2     1   60      97      60
# 3   3     1   55      86      78
# 4   4     1   30      98      58
# 5   5     2   25      80      65
# 6   6     2   50      89      98
# 7   7     2   80      90      45
# 8   8     2   55      78      25
# 9   9     3   20      98      15
# 10 10     3   50      98      45
# 11 11     3   65      65      65
# 12 12     3   45      85      32
# 13 13     4   46      98      65
# 14 14     4   48      87      12
# 15 15     4   55      56      78
# 16 16     4   58      98      65
# 17 17     5   65      68      98
# 18 18     5   80      78      90
# 19 19     5   89      68      87
# 20 20     5   78      83      58

mean(exam$math) ##math 평균 산출
# [1] 55.2 #결측치 대체되어서 평균도 바뀜
