#------------------------------
#변수 조합하여 파생변수 만들기
##데이터 프레임 생성
df <- data.frame(var1 = c(4, 3, 8),
                 var2 = c(2, 6, 1))
df
#   var1 var2
# 1    4    2
# 2    3    6
# 3    8    1


##파생변수 생성
df$var_sum <- df$var1 + df$var2 # var_sum 파생변수 생성
df
#   var1 var2 var_sum
# 1    4    2       6
# 2    3    6       9
# 3    8    1       9

df$var_mean <- (df$var1 + df$var2)/2 # var_mean 파생변수 생성
df
#   var1 var2 var_sum var_mean
# 1    4    2       6      3.0
# 2    3    6       9      4.5
# 3    8    1       9      4.5



#------------------------------
#mpg 통합 연비 변수 만들기
mpg$total <- (mpg$cty + mpg$hwy)/2 # 통합 연비 변수 생성
head(mpg)
# manufacturer model displ year cyl      trans drv cty hwy fl   class total
# 1         audi    a4   1.8 1999   4   auto(l5)   f  18  29  p compact  23.5
# 2         audi    a4   1.8 1999   4 manual(m5)   f  21  29  p compact  25.0
# 3         audi    a4   2.0 2008   4 manual(m6)   f  20  31  p compact  25.5
# 4         audi    a4   2.0 2008   4   auto(av)   f  21  30  p compact  25.5
# 5         audi    a4   2.8 1999   6   auto(l5)   f  16  26  p compact  21.0
# 6         audi    a4   2.8 1999   6 manual(m5)   f  18  26  p compact  22.0

mean(mpg$total)
#[1] 20.14957  #head이외에 전체 값 평균



#------------------------------
#조건문을 활용하여 파생변수 만들기

#-----
##1.기준값 정하기
summary(mpg$total) # 요약 통계량 산출
#  Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
# 10.50   15.50   20.50   20.15   23.50   39.50 

hist(mpg$total) # 히스토그램 생성


#-----
##2. 조건문으로 합격 판정 변수 만들기
# 20 이상이면 pass, 그렇지 않으면 fail 부여
mpg$test <- ifelse(mpg$total >= 20, "pass", "fail") #mpg에 추가
#ifelse(조건,조건이 맞을때, 조건이 안맞을때)

head(mpg, 20)
#    total test
# 1   23.5 pass
# 2   25.0 pass
# 3   25.5 pass
# 4   25.5 pass
# 5   21.0 pass
# 6   22.0 pass
# 7   22.5 pass
# 8   22.0 pass
# 9   20.5 pass
# 10  24.0 pass
# 11  23.0 pass
# 12  20.0 pass
# 13  21.0 pass
# 14  21.0 pass
# 15  20.0 pass
# 16  19.5 fail
# 17  21.0 pass
# 18  19.5 fail
# 19  17.0 fail
# 20  13.0 fail


#-----
##3. 빈도표로 합격 판정 자동차 수 살펴보기
table(mpg$test) # 연비 합격 빈도표 생성
# fail pass 
# 106  128


#-----
##4. 막대 그래프빈 빈도 표현하기
library(ggplot2) # ggplot2 로드
qplot(mpg$test) # 연비 합격 빈도 막대 그래프 생성



#------------------------------
#중첩 조건문 활용하기 – 연비 등급 변수 만들기
#-----
# total을 기준으로 A, B, C 등급 부여: A-30이상 B-20~29 C-20 미만
mpg$grade <- ifelse(mpg$total >= 30, "A",
                    ifelse(mpg$total >= 20, "B", "C"))

head(mpg, 20) # 데이터 확인

#    manufacturer              model displ year cyl      trans drv cty hwy fl   class total test grade grade2
# 1          audi                 a4   1.8 1999   4   auto(l5)   f  18  29  p compact  23.5 pass     B      C
# 2          audi                 a4   1.8 1999   4 manual(m5)   f  21  29  p compact  25.0 pass     B      B
# 3          audi                 a4   2.0 2008   4 manual(m6)   f  20  31  p compact  25.5 pass     B      B
# 4          audi                 a4   2.0 2008   4   auto(av)   f  21  30  p compact  25.5 pass     B      B
# 5          audi                 a4   2.8 1999   6   auto(l5)   f  16  26  p compact  21.0 pass     B      C
# 6          audi                 a4   2.8 1999   6 manual(m5)   f  18  26  p compact  22.0 pass     B      C
# 7          audi                 a4   3.1 2008   6   auto(av)   f  18  27  p compact  22.5 pass     B      C
# 8          audi         a4 quattro   1.8 1999   4 manual(m5)   4  18  26  p compact  22.0 pass     B      C
# 9          audi         a4 quattro   1.8 1999   4   auto(l5)   4  16  25  p compact  20.5 pass     B      C
# 10         audi         a4 quattro   2.0 2008   4 manual(m6)   4  20  28  p compact  24.0 pass     B      C
# 11         audi         a4 quattro   2.0 2008   4   auto(s6)   4  19  27  p compact  23.0 pass     B      C
# 12         audi         a4 quattro   2.8 1999   6   auto(l5)   4  15  25  p compact  20.0 pass     B      C
# 13         audi         a4 quattro   2.8 1999   6 manual(m5)   4  17  25  p compact  21.0 pass     B      C
# 14         audi         a4 quattro   3.1 2008   6   auto(s6)   4  17  25  p compact  21.0 pass     B      C
# 15         audi         a4 quattro   3.1 2008   6 manual(m6)   4  15  25  p compact  20.0 pass     B      C
# 16         audi         a6 quattro   2.8 1999   6   auto(l5)   4  15  24  p midsize  19.5 fail     C      D
# 17         audi         a6 quattro   3.1 2008   6   auto(s6)   4  17  25  p midsize  21.0 pass     B      C
# 18         audi         a6 quattro   4.2 2008   8   auto(s6)   4  16  23  p midsize  19.5 fail     C      D
# 19    chevrolet c1500 suburban 2wd   5.3 2008   8   auto(l4)   r  14  20  r     suv  17.0 fail     C      D
# 20    chevrolet c1500 suburban 2wd   5.3 2008   8   auto(l4)   r  11  15  e     suv  13.0 fail     C      D

##[유의] ifelse()가 두 번 반복되므로 열리는 괄호와 닫히는 괄호가 각각 두 개, 쉼표도 각각 두 개


#-----
#빈도표, 막대 그래프로 연비 등급 살펴보기
table(mpg$grade) # 등급 빈도표 생성
#  A   B   C 
# 10 118 106

qplot(mpg$grade) # 등급 빈도 막대 그래프 생성


#-----
#원하는 만큼 범주 만들기
# A, B, C, D 등급 부여
mpg$grade2 <- ifelse(mpg$total >= 30, "A",
                     ifelse(mpg$total >= 25, "B",
                            ifelse(mpg$total >= 20, "C", "D")))
