# mpg데이터를 이용해서 분석 문제를 해결해 보세요.
# 아래는 dplyr 패키지 함수들을 이용해 "compact"와 "suv" 차종의 '도시 및 고속도로 통합 연비' 평균을 구하는 코드입니다.
library(dplyr)
mpg <- as.data.frame(ggplot2::mpg) # mpg 데이터 불러오기
mpg %>%
  mutate(tot = (cty + hwy)/2) %>% # 통합 연비 변수 생성
  filter(class == "compact" | class == "suv") %>% # compact , suv 추출
  group_by(class) %>% # class 별 분리
  summarise(mean_tot = mean(tot)) # tot 평균 산출

# # A tibble: 2 x 2
# class mean_tot
# <chr> <dbl>
# 1 compact 24.21277
# 2 suv 15.81452


#--------
#Q1. dplyr대신 R 내장 함수를 이용해 "suv"와 "compact"의 '도시 및 고속도로 통합 연비' 평균을 구해보세요.

# 힌트
# 우선 cty와 hwy를 이용해 '통합 연비 변수'를 만드세요. 그런 다음, class가 "compact"인 행과 "suv"인 행을 추출해 두 종류의 데이터를 만드세요. 이렇게 만든 두 데이터를 이용해 통합 연비 변수 평균을 각각 구하면 됩니다.

mpg$tot <- (mpg$cty+mpg$hwy)/2 #통합 연비 변수
df_comp <- mpg[mpg$class=="compact",] #class가 compact인 행만 추출
df_suv <- mpg[mpg$class=="suv",] #class가 suv인 행만 추출

mean(df_comp$tot)
# [1] 24.21277

mean(df_suv$tot)
# [1] 15.81452