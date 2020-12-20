var <- as.numeric(var)

# 1.데이터 추출하기
exam[1,] # 행 번호로 행 추출
exam[exam$class == 1,] # 조건을 충족하는 행 추출
exam[exam$class == 1 & exam$math >= 50,] # 여러 조건을 충족하는 행 추출
exam[,1] # 열 번호로 변수 추출
exam[, "class"] # 변수명으로 변수 추출
exam[,c("class", "math", "english")] # 변수명으로 여러 변수 추출
exam[1,3] # 행, 변수 동시 추출 - 인덱스
exam[exam$math >= 50, "english"] # 행, 변수 동시 추출 - 조건문, 변수명


# 2.변수 타입
var <- c(1,2,3,1,2) # numeric 변수 만들기
var <- factor(c(1,2,3,1,2)) # factor 변수 만들기
var <- factor(c("a", "b", "b", "c")) # 문자로 구성된 factor 변수 만들기
class(var) # 변수 타입 확인하기
levels(var) # factor 변수의 구성 범주 확인
var <- as.numeric(var) # factor 타입을 numeric 타입으로 변환하기


# 3. 데이터 구조
# 벡터 만들기
a <- 1 
b <- "hello"

# 데이터 프레임 만들기
x1 <- data.frame(var1 = c(1,2,3),
                 var2 = c("a","b","c"))

# 매트릭스 만들기
x2 <- matrix(c(1:12), ncol = 2)

# 어레이 만들기
x3 <- array(1:20, dim=c(2, 5, 2))

# 리스트 만들기
x4 <- list(f1 = a,
           f2 = x1,
           f3 = x2,
           f4 = x3)

# 리스트 활용하기
x <- boxplot(mpg$cty) # 상자 그림 만들기
x$stats[,1] # 요약 통계량 추출