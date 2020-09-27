#--------------
# ggplot2의 mpg 데이터를 데이터 프레임 형태로 불러오기

mpg <- as.data.frame(ggplot2::mpg)
#ggplot2 패키지 안에 mpg데이터 불러와서 dataframe을 만든다.
#as.data.frame -  형식 바꿈
#:: - 특정 패키지에 있는 함수나 data 지정

#--------------
head(mpg) # Raw 데이터 앞부분 확인
#   manufacturer model displ year cyl      trans drv cty hwy fl   class
# 1         audi    a4   1.8 1999   4   auto(l5)   f  18  29  p compact
# 2         audi    a4   1.8 1999   4 manual(m5)   f  21  29  p compact
# 3         audi    a4   2.0 2008   4 manual(m6)   f  20  31  p compact
# 4         audi    a4   2.0 2008   4   auto(av)   f  21  30  p compact
# 5         audi    a4   2.8 1999   6   auto(l5)   f  16  26  p compact
# 6         audi    a4   2.8 1999   6 manual(m5)   f  18  26  p compact


#--------------
tail(mpg) # Raw 데이터 뒷부분 확인
#     manufacturer  model displ year cyl      trans drv cty hwy fl   class
# 229   volkswagen passat   1.8 1999   4   auto(l5)   f  18  29  p midsize
# 230   volkswagen passat   2.0 2008   4   auto(s6)   f  19  28  p midsize
# 231   volkswagen passat   2.0 2008   4 manual(m6)   f  21  29  p midsize
# 232   volkswagen passat   2.8 1999   6   auto(l5)   f  16  26  p midsize
# 233   volkswagen passat   2.8 1999   6 manual(m5)   f  18  26  p midsize
# 234   volkswagen passat   3.6 2008   6   auto(s6)   f  17  26  p midsize


#--------------
View(mpg) # Raw 데이터 뷰어 창 확인


#--------------
dim(mpg)  # 행, 열 출력
# [1] 234  11 #자동차 234종에 대한 11개의 변수


#--------------
str(mpg)  # 데이터 속성 확인
# 'data.frame':	234 obs. of  11 variables:
# $ manufacturer: chr  "audi" "audi" "audi" "audi" ...
# $ model       : chr  "a4" "a4" "a4" "a4" ...
# $ displ       : num  1.8 1.8 2 2 2.8 2.8 3.1 1.8 1.8 2 ...
# $ year        : int  1999 1999 2008 2008 1999 1999 2008 1999 1999 2008 ...
# $ cyl         : int  4 4 4 4 6 6 6 4 4 4 ...
# $ trans       : chr  "auto(l5)" "manual(m5)" "manual(m6)" "auto(av)" ...
# $ drv         : chr  "f" "f" "f" "f" ...
# $ cty         : int  18 21 20 21 16 18 18 18 16 20 ...
# $ hwy         : int  29 29 31 30 26 26 27 26 25 28 ...
# $ fl          : chr  "p" "p" "p" "p" ...
# $ class       : chr  "compact" "compact" "compact" "compact" ...


#numeric: 실수(소수점 있을수도) intiger: 정수


#--------------
summary(mpg) # 요약통계량 출력
# manufacturer          model               displ            year     
# Length:234         Length:234         Min.   :1.600   Min.   :1999  
# Class :character   Class :character   1st Qu.:2.400   1st Qu.:1999  
# Mode  :character   Mode  :character   Median :3.300   Median :2004  
# Mean   :3.472   Mean   :2004  
# 3rd Qu.:4.600   3rd Qu.:2008  
# Max.   :7.000   Max.   :2008  
# cyl           trans               drv                 cty       
# Min.   :4.000   Length:234         Length:234         Min.   : 9.00  
# 1st Qu.:4.000   Class :character   Class :character   1st Qu.:14.00  
# Median :6.000   Mode  :character   Mode  :character   Median :17.00  
# Mean   :5.889                                         Mean   :16.86  
# 3rd Qu.:8.000                                         3rd Qu.:19.00  
# Max.   :8.000                                         Max.   :35.00  
# hwy             fl               class          
# Min.   :12.00   Length:234         Length:234        
# 1st Qu.:18.00   Class :character   Class :character  
# Median :24.00   Mode  :character   Mode  :character  
# Mean   :23.44                                        
# 3rd Qu.:27.00                                        
# Max.   :44.00  
