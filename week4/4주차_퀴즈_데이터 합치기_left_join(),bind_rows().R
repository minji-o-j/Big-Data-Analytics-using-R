#mpg 데이터를 이용해서 분석 문제를 해결해 보세요.
mpg <- as.data.frame(ggplot2::mpg) # mpg 데이터 불러오기
head(mpg,3)

#   manufacturer model displ year cyl      trans drv cty hwy fl   class
# 1         audi    a4   1.8 1999   4   auto(l5)   f  18  29  p compact
# 2         audi    a4   1.8 1999   4 manual(m5)   f  21  29  p compact
# 3         audi    a4   2.0 2008   4 manual(m6)   f  20  31  p compact


#mpg 데이터의 fl 변수는 자동차에 사용하는 연료(fuel)를 의미합니다. 아래는 자동차 연료별 가격을 나타낸 표입니다.

# 우선 이 정보를 이용해서 연료와 가격으로 구성된 데이터 프레임을 만들어 보세요.
fuel <- data.frame(fl = c("c", "d", "e", "p", "r"),
                   price_fl = c(2.35, 2.38, 2.11, 2.76, 2.22),
                   stringsAsFactors = F)
fuel # 출력
#   fl price_fl
# 1  c     2.35
# 2  d     2.38
# 3  e     2.11
# 4  p     2.76
# 5  r     2.22


#--------------
# • Q1. mpg 데이터에는 연료 종류를 나타낸 fl 변수는 있지만 연료 가격을 나타낸 변수는 없습니다. 위에서 만든 fuel 데이터를 이용해서 mpg 데이터에 price_fl(연료 가격) 변수를 추가하세요.

mpg<-left_join(mpg,fuel,by="fl")


#--------------
# • Q2. 연료 가격 변수가 잘 추가됐는지 확인하기 위해서 model, fl, price_fl 변수를 추출해 앞부분 5 행을 출력해 보세요.

mpg %>% 
  select(model,fl,price_fl) %>% 
  head(5)

#  model fl price_fl
# 1    a4  p     2.76
# 2    a4  p     2.76
# 3    a4  p     2.76
# 4    a4  p     2.76
# 5    a4  p     2.76