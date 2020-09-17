# 숫자를 다루는 함수 이용하기
## 변수 만들기
x<-c(1,2,3)
x
# [1] 1 2 3

##함수 적용하기
mean(x)  #평균
# [1] 2

max(x)  #최댓값
# [1] 3

min(x)  #최솟값
# [1] 1


#-----------
#문자를 다루는 함수 이용하기

str5
# [1] "Hello" "World" "I'm"   "Minji"

paste(str5,collapse=",") #"."를 구분자로 str5의 단어를 하나로 합치기
#[1] "Hello,World,I'm,Minji"

##함수의 옵션 설정하기 - 파라미터(함수의 옵션 설정)
paste(str5,collapse=" ") #space bar를 구분자로 str5의 단어를 하나로 합치기
#[1] "Hello World I'm Minji"


##함수의 결과물로 새 변수 만들기

x_mean<-mean(x)
x_mean
# [1] 2

str5_paste<-paste(str5,collapse=" ")
str5_paste
# [1] "Hello World I'm Minji"