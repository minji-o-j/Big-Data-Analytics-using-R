# mpg 데이터를 이용해서 분석 문제를 해결해 보세요.
# 우선 mpg 데이터를 불러와서 일부러 이상치를 만들겠습니다. drv(구동방식) 변수의 값은 4(사륜구동), f(전륜구동), r(후륜구동) 세 종류로 되어있습니다. 몇 개의 행에 존재할 수 없는 값 k를 할당하겠습니다.
# cty(도시 연비) 변수도 몇 개의 행에 극단적으로 크거나 작은 값을 할당하겠습니다.

mpg <- as.data.frame(ggplot2::mpg) # mpg 데이터 불러오기
mpg[c(10, 14, 58, 93), "drv"] <- "k"      # drv 이상치 할당
mpg[c(29, 43, 129, 203), "cty"] <- c(3, 4, 39, 42)  #cty 이상치 할당

head(mpg,3)
#   manufacturer model displ year cyl      trans drv cty hwy fl   class
# 1         audi    a4   1.8 1999   4   auto(l5)   f  18  29  p compact
# 2         audi    a4   1.8 1999   4 manual(m5)   f  21  29  p compact
# 3         audi    a4   2.0 2008   4 manual(m6)   f  20  31  p compact

#--------------------
#이상치가 들어있는 mpg 데이터를 활용해서 문제를 해결해보세요.
#구동방식별로 도시 연비가 다른지 알아보려고 합니다. 분석을 하려면 우선 두 변수에 이상치가 있는지 확인하려고 합니다.
#--------------------

# • Q1. drv 에 이상치가 있는지 확인하세요. 이상치를 결측 처리한 다음 이상치가 사라졌는지 확인하세요. 결측 처리 할 때는 %in% 기호를 활용하세요.

## 이상치 확인
table(mpg$drv)
#   4   f   k   r 
# 100 106   4  24 
### k(이상치)가 4개 존재


## 이상치를 결측처리
mpg$drv<-ifelse(mpg$drv %in% c("4","f","r"),mpg$drv,NA) #%in%이용했으니까 저 안에 "안"드는게 NA임!

## 사라졌나 확인
table(mpg$drv)
#   4   f   r 
# 100 106  24 



#--------------------
# • Q2. 상자 그림을 이용해서 cty 에 이상치가 있는지 확인하세요. 상자 그림의 통계치를 이용해 정상 범위를 벗어난 값을 결측 처리한 후 다시 상자 그림을 만들어 이상치가 사라졌는지 확인하세요.

## 상자그림 생성
boxplot(mpg$cty) #그림으로는 8개 보임

##상자그림 통계치 출력
boxplot(mpg$cty)$stats
#       [,1]
# [1,]    9
# [2,]   14
# [3,]   17
# [4,]   19
# [5,]   26

## 결측 처리하기
# 9~26 벗어나면 NA 할당
mpg$cty <- ifelse(mpg$cty < 9 | mpg$cty > 26, NA, mpg$cty) #or(|) 씀에 유의

## 상자그림 생성하여 결측치 없어졌나 확인
boxplot(mpg$cty)



#--------------------
# • Q3. 두 변수의 이상치를 결측처리 했으니 이제 분석할 차례입니다. 이상치를 제외한 다음 drv 별로 cty 평균이 어떻게 다른지 알아보세요. 하나의 dplyr 구문으로 만들어야 합니다.

mpg %>% 
  filter(!is.na(drv)&!is.na(cty)) %>% #결측치 제외
  group_by(drv) %>% #drv별로
  summarise(cty_mean=mean(cty)) #cty 평균
# # A tibble: 3 x 2
# drv   cty_mean
# <chr>    <dbl>
# 1 4         14.2
# 2 f         19.5
# 3 r         14.0
