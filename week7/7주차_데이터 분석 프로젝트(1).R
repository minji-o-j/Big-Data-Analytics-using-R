### 데이터 분석 프로젝트 - 한국인의 삶을 파악하라

### 09-1. '한국복지패널데이터' 분석 준비하기-----------------------------------
##데이터 분석 준비하기-----------
## 패키지 준비하기
install.packages("foreign") # foreign 패키지 설치
library(foreign) # SPSS 파일 로드
library(dplyr) # 전처리
library(ggplot2) # 시각화
library(readxl) # 엑셀 파일 불러오기


## 데이터 준비하기
# 데이터 불러오기
raw_welfare <- read.spss(file = "Data/Koweps_hpc10_2015_beta1.sav",
                         to.data.frame = T) #dataframe 형태로, T가 아니면 list 형태로 불러온다.
# 복사본 만들기
welfare <- raw_welfare


## 데이터 검토하기
head(welfare)
tail(welfare)
View(welfare)
dim(welfare)
# [1] 16664   957
str(welfare)
summary(welfare)


## 변수명 바꾸기
welfare <- rename(welfare,
                  sex = h10_g3,
                  birth = h10_g4,
                  marriage = h10_g10,
                  religion = h10_g11,
                  income = p1002_8aq1,
                  code_job = h10_eco9,
                  # 성별
                  # 태어난 연도
                  # 혼인 상태
                  # 종교
                  # 월급
                  # 직종 코드
                  code_region = h10_reg7) # 지역 코드




### 09-2. 성별에 따른 월급 차이-----------------------------------
##성별 변수 검토 및 전처리-----------
## 1.변수 검토하기
class(welfare$sex)
# [1] "numeric"

table(welfare$sex)
#    1    2 #1:남자 2: 여자 9: 모른다/무응답
# 7578 9086 


## 2. 전처리
# 이상치 확인
table(welfare$sex)
#    1    2 
# 7578 9086 

# 이상치 결측 처리
welfare$sex <- ifelse(welfare$sex == 9, NA , welfare$sex) #모름/무응답 9라고 되어있었음

# 결측치 확인
table(is.na(welfare$sex))
# FALSE 
# 16664 #결측X

# 성별 항목 이름 부여
welfare$sex <- ifelse(welfare$sex == 1, "male", "female")
table(welfare$sex)
# female   male 
#   9086   7578 

qplot(welfare$sex)



##월급 변수 검토 및 전처리-----------
## 1. 변수 검토하기
class(welfare$income)
# [1] "numeric"

summary(welfare$income)
#    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
#     0.0   122.0   192.5   241.6   316.6  2400.0   12030 

qplot(welfare$income)

qplot(welfare$income) + xlim(0, 1000)


## 2. 전처리
# 이상치 확인
summary(welfare$income)
#    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
#     0.0   122.0   192.5   241.6   316.6  2400.0   12030  # 결측 12030

# 이상치 결측 처리 # 코드북 열어보면 1~9998 범위라고 한다. 따라서 나머지는 결측처리

welfare$income <- ifelse(welfare$income %in% c(0, 9999), NA , welfare$income)

# 결측치 확인
table(is.na(welfare$income))
# FALSE  TRUE 
# 4620 12044


##성별에 따른 월급 차이 분석하기
# 1. 성별 월급 평균표 만들기
sex_income <- welfare %>%
  filter(!is.na(income)) %>%
  group_by(sex) %>%
  summarise(mean_income = mean(income))

sex_income
#   sex    mean_income
#   <chr>        <dbl>
# 1 female        163.
# 2 male          312.

# 2. 그래프 만들기
ggplot(data = sex_income, aes(x = sex, y = mean_income)) + geom_col()



### 09-3. 나이와 월급의 관계-----------------------------------
##-----------
##1. 변수 검토하기
class(welfare$birth) #'나이'변수는 없고, 태어난 년도만 있다.
# [1] "numeric"

summary(welfare$birth)
#    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
#    1907    1946    1966    1968    1988    2014 

qplot(welfare$birth)


##2. 전처리
# 이상치 확인
summary(welfare$birth)
#    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
#    1907    1946    1966    1968    1988    2014 

# 결측치 확인
table(is.na(welfare$birth))
# FALSE 
# 16664

# 이상치 결측 처리
welfare$birth <- ifelse(welfare$birth == 9999, NA , welfare$birth)
table(is.na(welfare$birth))
# FALSE 
# 16664 

##3. 파생변수 만들기 - 나이
welfare$age <- 2020 - welfare$birth + 1
summary(welfare$age)
# Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
# 2.00   28.00   50.00   48.43   70.00  109.00 

qplot(welfare$age)

## 나이와 월급의 관계 분석하기-----------
## 1. 나이에 따른 월급 평균표 만들기
age_income <- welfare %>%
  filter(!is.na(income)) %>%
  group_by(age) %>%
  summarise(mean_income = mean(income))

head(age_income)
# # A tibble: 6 x 2
#     age mean_income
#   <dbl>       <dbl>
# 1    25        121.
# 2    26        106.
# 3    27        130.
# 4    28        142.
# 5    29        134.
# 6    30        145.


##2. 그래프 만들기
ggplot(data = age_income, aes(x = age, y = mean_income)) + geom_line() # 선그래프



### 09-4. 연령대에 따른 월급 차이-----------------------------------
## 연령대 변수 검토 및 전처리하기-----------
## 파생변수 만들기 - 연령대
welfare <- welfare %>%
  mutate(ageg = ifelse(age < 30, "young",
                       ifelse(age <= 59, "middle", "old")))
table(welfare$ageg)
# middle    old  young 
#   5655   7342   3667

qplot(welfare$ageg)

## 연령대에 따른 월급 차이 분석하기-----------
## 1. 연령대별 월급 평균표 만들기
ageg_income <- welfare %>%
  filter(!is.na(income)) %>%
  group_by(ageg) %>%
  summarise(mean_income = mean(income))

ageg_income
# # A tibble: 3 x 2
#   ageg   mean_income
#   <chr>        <dbl>
# 1 middle        273.
# 2 old           174.
# 3 young         129.

## 2. 그래프 만들기
ggplot(data = ageg_income, aes(x = ageg, y = mean_income)) + geom_col() #알파벳순 정렬


## 막대 정렬 : 초년, 중년, 노년 나이 순
ggplot(data = ageg_income, aes(x = ageg, y = mean_income)) +
  geom_col() +
  scale_x_discrete(limits = c("young", "middle", "old")) #정렬 다시


### 09-5. 연령대 및 성별 월급 차이-----------------------------------
## 연령대 및 성별 월급 차이 분석하기 -----------
## 1. 연령대 및 성별 월급 평균표 만들기
sex_income <- welfare %>%
  filter(!is.na(income)) %>%
  group_by(ageg, sex) %>%
  summarise(mean_income = mean(income))

sex_income
# # A tibble: 6 x 3
# # Groups:   ageg [3]
#   ageg   sex    mean_income
#   <chr>  <chr>        <dbl>
# 1 middle female        191.
# 2 middle male          340.
# 3 old    female        103.
# 4 old    male          244.
# 5 young  female        128.
# 6 young  male          130.

## 2. 그래프 만들기
ggplot(data = sex_income, aes(x = ageg, y = mean_income, fill = sex)) + #fill: 성벌에 따라 다른 색
  geom_col() +
  scale_x_discrete(limits = c("young", "middle", "old")) # 축 순서 수정


## 성별 막대 분리
ggplot(data = sex_income, aes(x = ageg, y = mean_income, fill = sex)) +
  geom_col(position = "dodge") + # 막대를 분리
  scale_x_discrete(limits = c("young", "middle", "old"))



## 나이 및 성별 월급 차이 분석하기-----------
## 1. 성별 연령별 월급 평균표 만들기
sex_age <- welfare %>%
  filter(!is.na(income)) %>% 
  group_by (age,sex) %>% 
  summarise (mean_income = mean(income))

head(sex_age)
# A tibble: 6 x 3
# Groups:   age [3]
#     age sex    mean_income
#   <dbl> <chr>        <dbl>
# 1    25 female        147.
# 2    25 male           69 
# 3    26 female        107.
# 4    26 male          102.
# 5    27 female        140.
# 6    27 male          118.

## 2. 그래프 만들기
ggplot(data = sex_age, aes(x = age, y = mean_income, col = sex)) + geom_line() # col = sex 을 넣어서 성별별로 다른 색의 그래프를 그렸다.
