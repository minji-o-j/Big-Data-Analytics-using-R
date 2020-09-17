#문자로 된 변수 만들기
str1<-"a"
str1
# [1] "a"

str2<-"text"
str2
# [1] "text"

str3<-"Hello World"
str3
# [1] "Hello World"

#---
#연속 문자 변수 만들기
str4<- c("a","b","c")
str4
# [1] "a" "b" "c"

str5 <-c("Hello","World","I'm","Minji")
str5
# [1] "Hello" "World" "I'm"   "Minji"

#---문자로 된 변수는 연산 불가
str1+2
# Error in str1 + 2 : 이항연산자에 수치가 아닌 인수입니다