### 데이터 분석 프로젝트 - 한국인의 삶을 파악하라
#7주차 실행한 후 실행..
### 09-6. 직업별 월급 차이-----------------------------------

## 1. 변수 검토하기----------
class(welfare$code_job)
# [1] "numeric"

table(welfare$code_job)



## 2. 전처리----------
# 직업분류코드 목록 불러오기
library(readxl)
list_job <- read_excel("data/Koweps_Codebook.xlsx", col_names=T,  sheet = 2)
head(list_job)
# # A tibble: 6 x 2
# code_job job                                
#       <dbl> <chr>                              
# 1      111 의회의원 고위공무원 및 공공단체임원
# 2      112 기업고위임원                       
# 3      120 행정 및 경영지원 관리자            
# 4      131 연구 교육 및 법률 관련 관리자      
# 5      132 보험 및 금융 관리자                
# 6      133 보건 및 사회복지 관련 관리자

dim(list_job)
# [1] 149   2



# welfare에 직업명 결합
welfare <- left_join(welfare, list_job, id = "code_job")

welfare %>%
  filter(!is.na(code_job)) %>%
  select(code_job, job) %>%
  head(10)



## 3. 직업별 월급 차이 분석하기----------

# 1. 직업별 월급 평균표 만들기
job_income <- welfare %>%
  filter(!is.na(job) & !is.na(income)) %>%
  group_by(job) %>%
  summarise(mean_income = mean(income))

head(job_income)
# # A tibble: 6 x 2
#   job                           mean_income
#   <chr>                               <dbl>
# 1 가사 및 육아 도우미                 80.2
# 2 간호사                              241. 
# 3 건설 및 광업 단순 종사원            190. 
# 4 건설 및 채굴 기계운전원             358. 
# 5 건설 전기 및 생산 관련 관리자       536. 
# 6 건설관련 기능 종사자                247. 


# 2. 상위 10개 추출
top10 <- job_income %>%
  arrange(desc(mean_income)) %>%
  head(10)

top10
# # A tibble: 10 x 2
#   job                                  mean_income
#   <chr>                                      <dbl>
# 1 금속 재료 공학 기술자 및 시험원             845.
# 2 의료진료 전문가                             844.
# 3 의회의원 고위공무원 및 공공단체임원         750 
# 4 보험 및 금융 관리자                         726.
# 5 제관원 및 판금원                            572.
# 6 행정 및 경영지원 관리자                     564.
# 7 문화 예술 디자인 및 영상 관련 관리자        557.
# 8 연구 교육 및 법률 관련 관리자               550.
# 9 건설 전기 및 생산 관련 관리자               536.
# 10 석유 및 화학물 가공장치 조작원              532.


# 3. 그래프 만들기
ggplot(data = top10, aes(x = reorder(job, mean_income), y = mean_income)) +
  geom_col() +
  coord_flip()


# 4. 하위 10위 추출
bottom10 <- job_income %>%
  arrange(mean_income) %>%
  head(10)
bottom10


# 5. 그래프 만들기
ggplot(data = bottom10, aes(x = reorder(job, -mean_income),
                            y = mean_income)) +
                            geom_col() +
                            coord_flip() +
                             ylim(0, 850) # top 10의 가로축이 약 850까지여서 비교를 위해 맞춰줌




### 09-7. 성별 직업 빈도-----------------------------------
## 1. 성별 직업 빈도표 만들기 ----------
job_male<-welfare %>% 
  filter(!is.na(job)&sex=="male") %>% 
  group_by(job) %>% 
  summarise(n=n()) %>% 
  arrange(desc(n)) %>% head(10)

job_male
# # A tibble: 10 x 2
#   job                          n
#   <chr>                    <int>
# 1 작물재배 종사자            640
# 2 자동차 운전원              251
# 3 경영관련 사무원            213
# 4 영업 종사자                141
# 5 매장 판매 종사자           132
# 6 제조관련 단순 종사원       104
# 7 청소원 및 환경 미화원       97
# 8 건설 및 광업 단순 종사원    95
# 9 경비원 및 검표원            95
# 10 행정 사무원                 92


job_female<-welfare %>% 
  filter(!is.na(job)&sex=="female") %>% 
  group_by(job) %>% 
  summarise(n=n()) %>% 
  arrange(desc(n)) %>% head(10)

job_female
# # A tibble: 10 x 2
#   job                              n
#   <chr>                        <int>
# 1 작물재배 종사자                680
# 2 청소원 및 환경 미화원          228
# 3 매장 판매 종사자               221
# 4 제조관련 단순 종사원           185
# 5 회계 및 경리 사무원            176
# 6 음식서비스 종사자              149
# 7 주방장 및 조리사               126
# 8 가사 및 육아 도우미            125
# 9 의료 복지 관련 서비스 종사자   121
# 10 음식관련 단순 종사원          104


## 2. 그래프 만들기 ----------
# 남성 직업 빈도 상위 10개 직업
ggplot(data = job_male, aes(x = reorder(job, n), y = n)) +
  geom_col() +
  coord_flip() #xy바뀜

# 여성 직업 빈도 상위 10개 직업
ggplot(data = job_female, aes(x = reorder(job, n), y = n)) +
  geom_col() +
  coord_flip() #xy바뀜




### 09-8. 종교 유무에 따른 이혼율-----------------------------------

## 종교 변수 검토 및 전처리하기 ----------
# 1. 변수 검토하기
class(welfare$religion)
# [1] "numeric"

table(welfare$religion)
#    1    2 
# 8047 8617


# 2. 전처리
# 종교 유무 이름 부여
welfare$religion <- ifelse(welfare$religion == 1, "yes", "no")
table(welfare$religion)
# no yes
# 8617 8047

qplot(welfare$religion)



## 혼인 상태 변수 검토 및 전처리하기 ----------
# 1. 변수 검토하기
class(welfare$marriage)
# [1] "numeric"

table(welfare$marriage)
#    0    1    2    3    4    5    6 
# 2861 8431 2117  712   84 2433   26 


# 2. 전처리
# 이혼 여부 변수 만들기
welfare$group_marriage <- ifelse(welfare$marriage == 1, "marriage",
                                 ifelse(welfare$marriage == 3, "divorce", NA ))
table(welfare$group_marriage)
# divorce marriage 
#     712     8431 

table(is.na(welfare$group_marriage))
# FALSE  TRUE 
#  9143  7521 

qplot(welfare$group_marriage)



## 종교 유무에 따른 이혼율 분석하기 ----------
# 1. 종교 유무에 따른 이혼율 표 만들기
religion_marriage <- welfare %>%
  filter(!is.na(group_marriage)) %>%
  group_by(religion, group_marriage) %>%
  summarise(n = n()) %>%
  mutate(tot_group = sum(n)) %>%
  mutate(pct = round(n/tot_group*100, 1))
religion_marriage
# # A tibble: 4 x 5
# # Groups:   religion [2]
#   religion group_marriage     n tot_group   pct
#   <chr>    <chr>          <int>     <int> <dbl>
# 1 no       divorce          384      4602   8.3
# 2 no       marriage        4218      4602  91.7
# 3 yes      divorce          328      4541   7.2
# 4 yes      marriage        4213      4541  92.8

# count() 활용
religion_marriage <- welfare %>%
  filter(!is.na(group_marriage)) %>%
  count(religion, group_marriage) %>%
  group_by(religion) %>%
  mutate(pct = round(n/sum(n)*100, 1))



# 2. 이혼율 표 만들기
# 이혼 추출
divorce <- religion_marriage %>%
  filter(group_marriage == "divorce") %>%
  select(religion, pct)
divorce
# # A tibble: 2 x 2
# # Groups:   religion [2]
# religion   pct
# <chr>    <dbl>
# 1 no         8.3   # 분석 결과 종교없는사람의 이혼률이 더 높다
# 2 yes        7.2



# 3. 그래프 만들기
ggplot(data = divorce, aes(x = religion, y = pct)) + geom_col()



## 연령대 및 종교 유무에 따른 이혼율 분석하기 ----------
# 1. 연령대별 이혼율 표 만들기
ageg_marriage <- welfare %>%
  filter(!is.na(group_marriage)) %>%
  group_by(ageg, group_marriage) %>%
  summarise(n = n()) %>%
  mutate(tot_group = sum(n)) %>%
  mutate(pct = round(n/tot_group*100, 1))
ageg_marriage
# # A tibble: 5 x 5
# # Groups:   ageg [3]
#   ageg   group_marriage     n tot_group   pct
#   <chr>  <chr>          <int>     <int> <dbl>
# 1 middle divorce          325      4034   8.1
# 2 middle marriage        3709      4034  91.9
# 3 old    divorce          387      5098   7.6
# 4 old    marriage        4711      5098  92.4
# 5 young  marriage          11        11 100  

# count() 활용
ageg_marriage <- welfare %>%
  filter(!is.na(group_marriage)) %>%
  count(ageg, group_marriage) %>%
  group_by(ageg) %>%
  mutate(pct = round(n/sum(n)*100, 1))



# 2. 연령대별 이혼율 그래프 만들기
# 초년 제외, 이혼 추출
ageg_divorce <- ageg_marriage %>%
  filter(ageg != "young" & group_marriage == "divorce") %>%
  select(ageg, pct)
ageg_divorce
# # A tibble: 2 x 2
# # Groups:   ageg [2]
#  ageg      pct
#   <chr>   <dbl>
# 1 middle   8.1
# 2 old      7.6

# 그래프 만들기
ggplot(data = ageg_divorce, aes(x = ageg, y = pct)) + geom_col()



# 3. 연령대 및 종교 유무에 따른 이혼율 표 만들기
# 연령대, 종교유무, 결혼상태별 비율표 만들기
ageg_religion_marriage <- welfare %>%
  filter(!is.na(group_marriage) & ageg != "young") %>%
  group_by(ageg, religion, group_marriage) %>%
  summarise(n = n()) %>%
  mutate(tot_group = sum(n)) %>%
  mutate(pct = round(n/tot_group*100, 1))
ageg_religion_marriage
# # A tibble: 8 x 6
# # Groups:   ageg, religion [4]
# ageg   religion group_marriage     n tot_group   pct
# <chr>  <chr>    <chr>          <int>     <int> <dbl>
# 1 middle no       divorce          199      2273   8.8
# 2 middle no       marriage        2074      2273  91.2
# 3 middle yes      divorce          126      1761   7.2
# 4 middle yes      marriage        1635      1761  92.8
# 5 old    no       divorce          185      2323   8  
# 6 old    no       marriage        2138      2323  92  
# 7 old    yes      divorce          202      2775   7.3
# 8 old    yes      marriage        2573      2775  92.7

# count() 활용
ageg_religion_marriage <- welfare %>%
  filter(!is.na(group_marriage) & ageg != "young") %>%
  count(ageg, religion, group_marriage) %>%
  group_by(ageg, religion) %>%
  mutate(pct = round(n/sum(n)*100, 1))


# 연령대 및 종교 유무별 이혼율 표 만들기
df_divorce <- ageg_religion_marriage %>%
  filter(group_marriage == "divorce") %>%
  select(ageg, religion, pct)
df_divorce
# # A tibble: 4 x 3
# # Groups:   ageg, religion [4]
#   ageg   religion   pct
#   <chr>  <chr>    <dbl>
# 1 middle no         8.8
# 2 middle yes        7.2
# 3 old    no         8  
# 4 old    yes        7.3



# 4. 연령대 및 종교 유무에 따른 이혼율 그래프 만들기
ggplot(data = df_divorce, aes(x = ageg, y = pct, fill = religion )) +
  geom_col(position = "dodge") # 그래프 2개 분리해서 나옴




### 09-9. 지역별 연령대 비율-----------------------------------
## 지역 변수 검토 및 전처리하기 ----------
# 1. 변수 검토하기
class(welfare$code_region)
# [1] "numeric"

table(welfare$code_region)
#    1    2    3    4    5    6    7 
# 2486 3711 2785 2036 1467 1257 2922 



# 2. 전처리
# 지역 코드 목록 만들기
list_region <- data.frame(code_region = c(1:7),
                          region = c("서울",
                                     "수도권(인천/경기)",
                                     "부산/경남/울산",
                                     "대구/경북",
                                     "대전/충남",
                                     "강원/충북",
                                     "광주/전남/전북/제주도"))

list_region
#   code_region                region
# 1           1                  서울
# 2           2     수도권(인천/경기)
# 3           3        부산/경남/울산
# 4           4             대구/경북
# 5           5             대전/충남
# 6           6             강원/충북
# 7           7 광주/전남/전북/제주도



# welfare에 지역명 변수 추가
welfare <- left_join(welfare, list_region, id = "code_region")
# Joining, by = "code_region"

welfare %>%
  select(code_region, region) %>%
  head
# code_region region
# 1           1   서울
# 2           1   서울
# 3           1   서울
# 4           1   서울
# 5           1   서울
# 6           1   서울



## 지역별 연령대 비율 분석하기 ----------
# 1. 지역별 연령대 비율표 만들기
region_ageg <- welfare %>%
  group_by(region, ageg) %>%
  summarise(n = n()) %>%
  mutate(tot_group = sum(n)) %>%
  mutate(pct = round(n/tot_group*100, 2))

head(region_ageg)
# # A tibble: 6 x 5
# # Groups:   region [2]
#   region                ageg       n tot_group   pct
#   <chr>                 <chr>  <int>     <int> <dbl>
# 1 강원/충북             middle   386      1257  30.7
# 2 강원/충북             old      630      1257  50.1
# 3 강원/충북             young    241      1257  19.2
# 4 광주/전남/전북/제주도 middle   898      2922  30.7
# 5 광주/전남/전북/제주도 old     1389      2922  47.5
# 6 광주/전남/전북/제주도 young    635      2922  21.7


# count() 활용
region_ageg <- welfare %>%
  count(region, ageg) %>%
  group_by(region) %>%
  mutate(pct = round(n/sum(n)*100, 2))



# 2. 그래프 만들기
ggplot(data = region_ageg, aes(x = region, y = pct, fill = ageg)) +
  geom_col() +
  coord_flip() # xy 바꿈



# 3. 막대 정렬하기 : 노년층 비율 높은 순
# 노년층 비율 내림차순 정렬
list_order_old<-region_ageg %>% 
  filter(ageg=="old") %>% 
  arrange(desc(pct))

list_order_old
# # A tibble: 7 x 4
# # Groups:   region [7]
#   region                ageg      n   pct
#   <chr>                <chr>  <int> <dbl>
# 1 대구/경북             old    1051  51.6
# 2 강원/충북             old     630  50.1
# 3 광주/전남/전북/제주도 old    1389  47.5
# 4 부산/경남/울산        old    1307  46.9
# 5 대전/충남             old     633  43.2
# 6 서울                  old     999  40.2
# 7 수도권(인천/경기)     old    1333  35.9


order<-list_order_old$region
order
# [1] "대구/경북"             "강원/충북"             "광주/전남/전북/제주도"
# [4] "부산/경남/울산"        "대전/충남"             "서울"                 
# [7] "수도권(인천/경기)


ggplot(data = region_ageg, aes(x = region, y = pct, fill = ageg)) +
  geom_col() +
  coord_flip() +
  scale_x_discrete(limits = order)




# 4. 연령대 순으로 막대 색깔 나열하기
class(region_ageg$ageg)
# [1] "character"

levels(region_ageg$ageg)
# NULL

region_ageg$ageg <- factor(region_ageg$ageg,
                           level = c("old", "middle", "young"))
class(region_ageg$ageg)
# [1] "factor"

levels(region_ageg$ageg)
# [1] "old"    "middle" "young" 


ggplot(data = region_ageg, aes(x = region, y = pct, fill = ageg)) +
  geom_col() +
  coord_flip() +
  scale_x_discrete(limits = order)
