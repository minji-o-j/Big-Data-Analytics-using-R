#--------------------------------------------
#------------ 변수 타입 간 차이 알아보기

#------ 변수 생성 및 차이 비교
var1 <- c(1,2,3,1,2) # numeric 변수 생성
var2 <- factor(c(1,2,3,1,2)) # factor 변수 생성

var1 # numeric 변수 출력
# [1] 1 2 3 1 2

var2 # factor 변수 출력
# [1] 1 2 3 1 2    
# Levels: 1 2 3        # 범주가 같이 나온다. factor 변수는 값은 지니는 동시에 값의 범주를 의미하는 Levels 정보를 가지고 있음



#------ factor 변수는 연산이 안 됨
var1+2 # numeric 변수로 연산
# [1] 3 4 5 3 4

var2+2 # factor 변수로 연산
# [1] NA NA NA NA NA
# 경고메시지(들): 
# In Ops.factor(var2, 2) : 요인(factors)에 대하여 의미있는 ‘+’가 아닙니다.


#------ 변수 타입 확인하기
class(var1)
# [1] "numeric"

class(var2)
# [1] "factor"



#------ factor 변수의 구성 범주 확인하기
levels(var1)
# NULL

levels(var2)
# [1] "1" "2" "3"



#------ 문자로 구성된 factor 변수 : factor 변수는 숫자로 구성될 수도 있고 문자로 구성될 수도 있음
var3 <- c("a", "b", "b", "c") # 문자 변수 생성
var4 <- factor(c("a", "b", "b", "c")) # 문자로 된 factor 변수 생성

var3
# [1] "a" "b" "b" "c"

var4
# [1] a b b c
# Levels: a b c

class(var3)
# [1] "character"

class(var4)
# [1] "factor"



#------ 함수마다 적용 가능한 변수 타입이 다르다
mean(var1)
# [1] 1.8

mean(var2)
# [1] NA
# 경고메시지(들): 
#   In mean.default(var2) :
#   인자가 수치형 또는 논리형이 아니므로 NA를 반환합니다



#--------------------------------------------
#------------ 변수 타입 바꾸기
var2 <- as.numeric(var2) # numeri c 타입으로 변환
mean(var2) # 함수 재적용
# [1] 1.8

class(var2) # 타입 확인
# [1] "numeric"

levels(var2) # 범주 확인
# NULL