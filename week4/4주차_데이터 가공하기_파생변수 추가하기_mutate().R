# 파생변수 추가하기

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
exam %>%
  mutate(total = math + english + science) %>% # 총합 변수 추가
  head # 일부 추출

#   id class math english science total
# 1  1     1   50      98      50   198
# 2  2     1   60      97      60   217
# 3  3     1   45      86      78   209
# 4  4     1   30      98      58   186
# 5  5     2   25      80      65   170
# 6  6     2   50      89      98   237


#------------------------------
## 여러 파생변수 한 번에 추가하기

exam %>%
  mutate(total = math + english + science,         # 총합 변수 추가
         mean = (math + english + science)/3) %>%  # 총평균 변수 추가
  head                                             # 일부 추출

#   id class math english science total     mean
# 1  1     1   50      98      50   198 66.00000
# 2  2     1   60      97      60   217 72.33333
# 3  3     1   45      86      78   209 69.66667
# 4  4     1   30      98      58   186 62.00000
# 5  5     2   25      80      65   170 56.66667
# 6  6     2   50      89      98   237 79.00000




#------------------------------
## mutate()에 ifelse() 적용하기
exam %>%
  mutate(test = ifelse(science >= 60, "pass", "fail")) %>%
  head

#   id class math english science test
# 1  1     1   50      98      50 fail
# 2  2     1   60      97      60 pass
# 3  3     1   45      86      78 pass
# 4  4     1   30      98      58 fail
# 5  5     2   25      80      65 pass
# 6  6     2   50      89      98 pass



#------------------------------
## 추가한 변수를 dplyr 코드에 바로 활용하기

exam %>%
  mutate(total = math + english + science) %>%   # 총합 변수 추가
  arrange(total) %>%                             # 총합 변수 기준 정렬
  head                                           # 일부 추출

#   id class math english science total
# 1  9     3   20      98      15   133
# 2 14     4   48      87      12   147
# 3 12     3   45      85      32   162
# 4  5     2   25      80      65   170
# 5  4     1   30      98      58   186
# 6  8     2   90      78      25   193
