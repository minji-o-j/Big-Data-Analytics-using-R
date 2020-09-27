#-----------
#변수 만들기
english <- c(90, 80, 60, 70) # 영어 점수 변수 생성
english
## [1] 90 80 60 70

math <- c(50, 60, 100, 20) # 수학 점수 변수 생성
math
## [1] 50 60 100 20

#-----------
#데이터 프레임 만들기
# english, math로 데이터 프레임 생성해서 df_midterm에 할당
df_midterm <- data.frame(english, math)
df_midterm
##   english math
## 1      90   50
## 2      80   60
## 3      60  100
## 4      70   20

#-----------
#반에 대한 정보가 추가된 데이터 프레임 만들기
class <- c(1, 1, 2, 2)
class
## [1] 1 1 2 2

df_midterm <- data.frame(english, math, class)
df_midterm
## english math class
## 1    90   50     1
## 2    80   60     1
## 3    60  100     2
## 4    70   20     2


#-----------
#분석하기
#### $: dataframe 안의 변수 명

mean(df_midterm$english) # df_midterm의 english로 평균 산출
## [1] 75
mean(df_midterm$math) # df_midterm의 math로 평균 산술
## [1] 57.5


#-----------
#한번에 만들기
df_midterm <- data.frame(english = c(90, 80, 60, 70),
                         math = c(50, 60, 100, 20),
                         class = c(1, 1, 2, 2))
df_midterm
## english math class
## 1 90 50 1
## 2 80 60 1
## 3 60 100 2
## 4 70 20 2