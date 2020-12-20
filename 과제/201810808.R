##----------------------------------------------------------------------------------------------------
## 1. 데이터 준비 : Koweps_hpwc14_2019_beta1.sav
##----------------
# ①데이터 준비하기
### foreign 패키지 설치
install.packages("foreign") 

### SPSS 파일 로드
library(foreign)

### 전처리
library(dplyr)

### 시각화
library(ggplot2)

##----------------
# ②데이터 불러오기
### 데이터 불러오기
raw_welfare <- read.spss(file = "Data/koweps_hpwc14_2019_beta1.sav",
                         to.data.frame = T)
### 복사본 만들기
welfare <- raw_welfare

##----------------
# ③데이터 검토하기 – 6개 함수 사용
head(welfare)
tail(welfare)
View(welfare)
dim(welfare)
str(welfare)
summary(welfare)

##----------------
# ④변수명 바꾸기
welfare <- rename(welfare,
                  sex = h14_g3, # 성별
                  birth = h14_g4, # 태어난 연도
                  marriage = h14_g10, # 혼인 상태
                  religion = h14_g11,  # 종교
                  income = p1402_8aq1, # 월급
                  code_job = h14_eco9, # 직종 코드
                  code_region = h14_reg7) # 지역 코드


##----------------------------------------------------------------------------------------------------
## 2. 성별에 따른 월급 차이

##----------------
# ①성별 변수 검토 및 전처리
### 성별 변수 검토
class(welfare$sex)
table(welfare$sex)

### 전처리
# 이상치 확인
table(welfare$sex)

# 이상치 결측 처리
welfare$sex <- ifelse(welfare$sex == 9, NA , welfare$sex)

# 결측치 확인
table(is.na(welfare$sex))

# 성별 항목 이름 부여
welfare$sex <- ifelse(welfare$sex == 1, "male", "female")
table(welfare$sex)

##----------------
# ②월급 변수 검토 및 전처리
### 월급 변수 검토
class(welfare$income)
summary(welfare$income)
qplot(welfare$income) + xlim(0, 1000)

### 전처리
# 이상치 확인
summary(welfare$income)

# 이상치 결측 처리
welfare$income <- ifelse(welfare$income %in% c(0, 9999), NA , welfare$income)

# 결측치 확인
table(is.na(welfare$income))

##----------------
# ③성별에 따른 월급 차이 분석하기
### 성별 월급 평균표 만들기
sex_income <- welfare %>%
  filter(!is.na(income)) %>%
  group_by(sex) %>%
  summarise(mean_income = mean(income))

sex_income

### 그래프 만들기
ggplot(data = sex_income, aes(x = sex, y = mean_income)) + geom_col()


##----------------------------------------------------------------------------------------------------
## 3. 나이와 월급의 관계
##----------------
# ①나이 변수 검토 및 전처리
### 변수 검토하기
class(welfare$birth)
summary(welfare$birth)
qplot(welfare$birth)

### 전처리
# 이상치 확인
summary(welfare$birth)

# 결측치 확인
table(is.na(welfare$birth))

# 이상치 결측 처리
welfare$birth <- ifelse(welfare$birth == 9999, NA , welfare$birth)
table(is.na(welfare$birth))

### 파생변수 만들기(나이)
welfare$age <- 2019 - welfare$birth + 1
summary(welfare$age)
qplot(welfare$age)

##----------------
# ②나이와 월급의 관계 분석하기
###나이에 따른 월급 평균표 만들기
age_income <- welfare %>%
  filter(!is.na(income)) %>%
  group_by(age) %>%
  summarise(mean_income = mean(income))
head(age_income)

### 그래프 만들기
ggplot(data = age_income, aes(x = age, y = mean_income)) + geom_line()


##----------------------------------------------------------------------------------------------------
## 4.자유 분석 – 주어진 변수를 가지고 각자 자유롭게 주제를 정해서 분석
## 주제: 지역에 따른 월급 차이
##----------------
# ①지역 변수 검토 및 전처리
### 지역 변수 검토
class(welfare$code_region)
table(welfare$code_region)

### 전처리
# 이상치 확인
table(welfare$code_region)

# 이상치 결측 처리
welfare$code_region <- ifelse(welfare$code_region <0, NA , welfare$code_region) #지역 1~7
welfare$code_region <- ifelse(welfare$code_region >7, NA , welfare$code_region) #지역 1~7

# 결측치 확인
table(is.na(welfare$code_region))

# 지역 항목 이름 부여 파생변수 만들기
# 1. 서울          2. 수도권(인천/경기)    3. 부산/경남/울산   4.대구/경북   
# 5. 대전/충남   6. 강원/충북               7.광주/전남/전북/제주도
welfare<-welfare %>% 
  mutate(region_name= ifelse(welfare$code_region == 1, "Seoul", ifelse(welfare$code_region == 2, "Incheon/Gyeonggi", ifelse(welfare$code_region == 3, "Bu/Gyeongnam/Ul", ifelse(welfare$code_region == 4, "Daegu/Gyeongbuk", ifelse(welfare$code_region == 5, "Daejeon/Chungnam", ifelse(welfare$code_region == 6, "Gang/Chungbuk", "Honam")))))))

table(welfare$region_name)

##----------------
# ② 지역과 월급의 관계 분석하기
### 지역 월급 평균표 만들기
region_income <- welfare %>%
  filter(!is.na(income)) %>%
  group_by(region_name) %>%
  summarise(mean_region_income = mean(income))

region_income

### 그래프 만들기
ggplot(data = region_income, aes(x = region_name, y = mean_region_income)) + geom_col()
##----------------