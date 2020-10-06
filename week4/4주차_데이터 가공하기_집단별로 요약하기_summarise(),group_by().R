# 집단별로 요약하기
## summarise() 통계치 산출
## group_by() 집단별로 나누기

#------------------------------
## dplyr 패키지로드& 데이터 준비

library(dplyr)
exam <- read.csv("Data/csv_exam.csv")
head(exam,3)

#    id class math english science
# 1   1     1   50      98      50
# 2   2     1   60      97      60
# 3   3     1   45      86      78


#------------------------------
## 요약하기
exam %>% summarise(mean_math = mean(math)) # math 평균 산출 
#   mean_math
# 1     57.45


#------------------------------
##집단별로 요약하기
exam %>%
  group_by(class) %>% # class 별로 분리
  summarise(mean_math = mean(math)) # math 평균 산출
# # A tibble: 5 x 2
#   class mean_math
#   <int>     <dbl>
# 1     1      46.2
# 2     2      61.2
# 3     3      45  
# 4     4      56.8
# 5     5      78  


#------------------------------
## 여러 요약통계량 한 번에 산출하기
exam %>%
  group_by(class) %>%                   # class 별로 분리
  summarise(mean_math = mean(math),     # math 평균
            sum_math = sum(math),       # math 합계
            median_math = median(math), # math 중앙값
            n = n())                    # 학생 수 , #n(): 빈도

# # A tibble: 5 x 5
#   class mean_math sum_math median_math     n
#   <int>     <dbl>    <int>       <dbl> <int>
# 1     1      46.2      185        47.5     4
# 2     2      61.2      245        65       4
# 3     3      45        180        47.5     4
# 4     4      56.8      227        53       4
# 5     5      78        312        79       4


#------------------------------
## 각 집단별로 다시 집단 나누기
mpg %>%
  group_by(manufacturer, drv) %>% # 회사별, 구방방식별 분리
  summarise(mean_cty = mean(cty)) %>% # ct y 평균 산출
  head(10) # 일부 출력

# # A tibble: 10 x 3
# # Groups:   manufacturer [5]
#   manufacturer drv   mean_cty
#   <chr>        <chr>    <dbl>
# 1  audi         4         16.8
# 2  audi         f         18.9
# 3  chevrolet    4         12.5
# 4  chevrolet    f         18.8
# 5  chevrolet    r         14.1
# 6  dodge        4         12  
# 7  dodge        f         15.8
# 8  ford         4         13.3
# 9  ford         r         14.8
# 10 honda        f         24.4


#------------------------------
### 회사별로 "suv" 자동차의 도시 및 고속도로 통합 연비 평균을 구해 내림차순으로 정렬하고, 1~5위까지 출력하기

##dplyr 조합하기
mpg %>%
  group_by(manufacturer) %>%    # 회사별로 분리
  filter(class == "suv") %>%    # suv 추출
  mutate(tot = (cty+hwy)/2) %>% # 통합 연비 변수 생성
  summarise(mean_tot = mean(tot)) %>% # 통합 연비 평균 산출
  arrange(desc(mean_tot)) %>% # 내림차순 정렬
  head(5) # 1~5 위까지 출력

# # A tibble: 5 x 2
#   manufacturer mean_tot
#    <chr>           <dbl>
# 1 subaru           21.9
# 2 toyota           16.3
# 3 nissan           15.9
# 4 mercury          15.6
# 5 jeep             15.6

#------------------------------
##