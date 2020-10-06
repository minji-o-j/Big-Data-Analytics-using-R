#mpg 데이터를 이용해서 분석 문제를 해결해 보세요.
mpg <- as.data.frame(ggplot2::mpg) # mpg 데이터 불러오기
head(mpg,3)

#   manufacturer model displ year cyl      trans drv cty hwy fl   class
# 1         audi    a4   1.8 1999   4   auto(l5)   f  18  29  p compact
# 2         audi    a4   1.8 1999   4 manual(m5)   f  21  29  p compact
# 3         audi    a4   2.0 2008   4 manual(m6)   f  20  31  p compact

#---------------------------
##• Q1. mpg 데이터의 class 는 "suv", "compact" 등 자동차를 특징에 따라 일곱 종류로 분류한 변수입니다. 어떤 차종의 연비가 높은지 비교해보려고 합니다. class 별 cty 평균을 구해보세요.


mpg %>% 
  group_by(class) %>% #분리
  summarise(mean_cty=mean(cty)) #평균

# # A tibble: 7 x 2
#   class      mean_cty
#   <chr>         <dbl>
# 1 2seater        15.4
# 2 compact        20.1
# 3 midsize        18.8
# 4 minivan        15.8
# 5 pickup         13  
# 6 subcompact     20.4
# 7 suv            13.5



#---------------------------
##• Q2. 앞 문제의 출력 결과는 class 값 알파벳 순으로 정렬되어 있습니다. 어떤 차종의 도시 연비가 높은지 쉽게 알아볼 수 있도록 cty 평균이 높은 순으로 정렬해 출력하세요.

mpg %>% 
  group_by(manufacturer) %>% #분리
  summarise(mean_cty=mean(cty)) %>% #평균
  arrange(desc(mean_cty)) # 내림차순 정렬

# # A tibble: 7 x 2
#   class      mean_cty
#   <chr>         <dbl>
# 1 subcompact     20.4
# 2 compact        20.1
# 3 midsize        18.8
# 4 minivan        15.8
# 5 2seater        15.4
# 6 suv            13.5
# 7 pickup         13 


#---------------------------
##• Q3. 어떤 회사 자동차의 hwy(고속도로 연비)가 가장 높은지 알아보려고 합니다. hwy 평균이 가장 높은 회사 세 곳을 출력하세요.

mpg %>% 
  group_by(manufacturer) %>% #분리
  summarise(mean_hwy=mean(hwy)) %>% #평균
  arrange(desc(mean_hwy)) %>%  # 내림차순 정렬
  head(3)

# # A tibble: 3 x 2
#   manufacturer mean_hwy
#   <chr>           <dbl>
# 1 honda            32.6
# 2 volkswagen       29.2
# 3 hyundai          26.9


#---------------------------
##• Q4. 어떤 회사에서 "compact"(경차) 차종을 가장 많이 생산하는지 알아보려고 합니다. 각 회사별 "compact" 차종 수를 내림차순으로 정렬해 출력하세요.
mpg %>%
  filter(class=="compact") %>%  # 경차만
  group_by(manufacturer) %>%    # 제조사별 분류
  summarise(count=n()) %>%      # count
  arrange(desc(count))          #내림차순

# # A tibble: 5 x 2
#   manufacturer count
#   <chr>        <int>
# 1 audi            15
# 2 volkswagen      14
# 3 toyota          12
# 4 subaru           4
# 5 nissan           2