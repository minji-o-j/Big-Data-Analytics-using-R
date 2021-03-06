##----------------------------------------
# 1. 벡터(Vactor)
# • 하나 또는 여러 개의 값으로 구성된 데이터 구조
# • 여러 타입을 섞을 수 없고, 한 가지 타입으로만 구성 가능

# 벡터 만들기
a <- 1
a
## [1] 1

b <- "hello"
b
## [1] "hello"


# 변수 타입 확인
class(a)
## [1] "numeric"

class(b)
## [1] "character"



##----------------------------------------
# 2. 데이터 프레임(Data Frame)
# • 행과 열로 구성된 2차원 데이터 구조
# • 다양한 변수 타입으로 구성 가능


# 데이터 프레임 만들기
x1 <- data.frame(var1 = c(1,2,3),
                 var2 = c("a","b","c"))
x1
#   var1 var2
# 1    1    a
# 2    2    b
# 3    3    c


# 데이터 구조 확인
class(x1)
# [1] "data.frame"



##----------------------------------------
# 3. 매트릭스 (Matrix)
# • 행과 열로 구성된 2차원 데이터 구조
# •한 가지 타입으로만 구성 가능

# 매트릭스 만들기 - 1~12 로 2 열
x2<-matrix(c(1:12),ncol=2)
x2
#       [,1] [,2]
# [1,]    1    7
# [2,]    2    8
# [3,]    3    9
# [4,]    4   10
# [5,]    5   11
# [6,]    6   12

# 데이터 구조 확인
class(x2)
# [1] "matrix" "array" 



##----------------------------------------
# 4. 어레이(Array)
# • 2차원 이상으로 구성된 매트릭스
# •한 가지 타입으로만 구성 가능

# # array 만들기 - 1~20으로 2 행 x 5 열 x 2차원
x3 <- array (1:20, dim = c (2, 5, 2))
x3
# , , 1
# 
#     [,1] [,2] [,3] [,4] [,5]
# [1,]    1    3    5    7    9
# [2,]    2    4    6    8   10
# 
# , , 2
# 
#      [,1] [,2] [,3] [,4] [,5]
# [1,]   11   13   15   17   19
# [2,]   12   14   16   18   20



##----------------------------------------
# 5. 리스트 (List)
# 모든 데이터 구조를 포함하는 데이터 구조
# 여러 데이터 구조를 합해 하나의 리스트로 구성 가능

# 리스트 생성 - 앞에서 생성한 데이터 구조 활용
x4 <- list(f1=a,  # 벡터
           f2=x1, # 데이터프레임
           f3=x2, # 매트릭스
           f4=x3) # 어레이

x4


# 데이터 구조 확인
class(x4)
# [1] "list"



##----------------------------------------
# 리스트 활용
# • 함수의 결과물이 리스트 형태로 반환되는 경우 많음
# • 리스트를 활용하면 함수의 결과물에서 특정 값을 추출 가능

# boxplot() 출력 결과물에서 값 추출하기
mpg <- ggplot2::mpg
x <- boxplot(mpg$cty)

x
# $stats
# [,1]
# [1,]    9
# [2,]   14
# [3,]   17
# [4,]   19
# [5,]   26
# attr(,"class")
# 1 
# "integer" 
# 
# $n
# [1] 234
# 
# $conf
# [,1]
# [1,] 16.48356
# [2,] 17.51644
# 
# $out
# [1] 28 28 33 35 29
# 
# $group
# [1] 1 1 1 1 1
# 
# $names
# [1] "1"

x$stats[,1] # 요약 통계량 추출
# [1]  9 14 17 19 26

x$stats[,1][3] # 중앙값 추출
# [1] 17

x$stats[,1][2] # 1 분위수 추출
# [1] 14