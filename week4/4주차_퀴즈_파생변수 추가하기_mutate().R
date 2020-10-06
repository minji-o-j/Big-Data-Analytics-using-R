#mpg 데이터를 이용해서 분석 문제를 해결해보세요.
#mpg 데이터는 연비를 나타내는 변수가 hwy(고속도로 연비), cty(도시 연비) 두 종류로 분리되어 있습니다. 두변수를 각각 활용하는 대신 하나의 통합 연비 변수를 만들어 분석하려고 합니다.

mpg <- as.data.frame(ggplot2::mpg) # mpg 데이터 불러오기
head(mpg,3)

#   manufacturer model displ year cyl      trans drv cty hwy fl   class
# 1         audi    a4   1.8 1999   4   auto(l5)   f  18  29  p compact
# 2         audi    a4   1.8 1999   4 manual(m5)   f  21  29  p compact
# 3         audi    a4   2.0 2008   4 manual(m6)   f  20  31  p compact


#-------------------------------
##• Q1. mpg 데이터 복사본을 만들고, cty 와 hwy 를 더한 '합산 연비 변수'를 추가하세요.

# 복사본 생성
mpg_new<-mpg

#합산 변수 생성
mpg_new <- mpg_new %>% 
  mutate(total=cty+hwy)

#확인
mpg_new %>% 
  head(3)

#   manufacturer model displ year cyl      trans drv cty hwy fl   class total
# 1         audi    a4   1.8 1999   4   auto(l5)   f  18  29  p compact    47
# 2         audi    a4   1.8 1999   4 manual(m5)   f  21  29  p compact    50
# 3         audi    a4   2.0 2008   4 manual(m6)   f  20  31  p compact    51


#-------------------------------
##• Q2. 앞에서 만든 '합산 연비 변수'를 2 로 나눠 '평균 연비 변수'를 추가세요.

#평균 연비 변수 생성
mpg_new <- mpg_new %>% 
  mutate(mean=total/2)

#확인
mpg_new %>% 
  head(3)

#   manufacturer model displ year cyl      trans drv cty hwy fl   class total mean
# 1         audi    a4   1.8 1999   4   auto(l5)   f  18  29  p compact    47 23.5
# 2         audi    a4   1.8 1999   4 manual(m5)   f  21  29  p compact    50 25.0
# 3         audi    a4   2.0 2008   4 manual(m6)   f  20  31  p compact    51 25.5


#-------------------------------
##• Q3. '평균 연비 변수'가 가장 높은 자동차 3 종의 데이터를 출력하세요.

#출력
mpg_new %>% 
  arrange(desc(mean)) %>% 
  head(3)

#   manufacturer      model displ year cyl      trans drv cty hwy fl      class total mean
# 1   volkswagen new beetle   1.9 1999   4 manual(m5)   f  35  44  d subcompact    79 39.5
# 2   volkswagen      jetta   1.9 1999   4 manual(m5)   f  33  44  d    compact    77 38.5
# 3   volkswagen new beetle   1.9 1999   4   auto(l4)   f  29  41  d subcompact    70 35.0


#-------------------------------
##• Q4. 1~3 번 문제를 해결할 수 있는 하나로 연결된 dplyr 구문을 만들어 출력하세요. 데이터는 복사본 대신 mpg 원본을 이용하세요.

mpg %>% 
  mutate(total=cty+hwy, mean=total/2) %>% 
  arrange(desc(mean)) %>% 
  head(3)

#   manufacturer      model displ year cyl      trans drv cty hwy fl      class total mean
# 1   volkswagen new beetle   1.9 1999   4 manual(m5)   f  35  44  d subcompact    79 39.5
# 2   volkswagen      jetta   1.9 1999   4 manual(m5)   f  33  44  d    compact    77 38.5
# 3   volkswagen new beetle   1.9 1999   4   auto(l4)   f  29  41  d subcompact    70 35.0