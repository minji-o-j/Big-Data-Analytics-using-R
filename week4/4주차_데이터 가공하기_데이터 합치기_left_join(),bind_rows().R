#데이터 합치기
## left_join() 데이터 합치기(열) - 가로 변수 추가
## bind_rows() 데이터 합치기(행)

#------------------------
## 가로로 합치기

#### 데이터 생성
# 중간고사 데이터 생성
test1 <- data.frame(id = c(1, 2, 3, 4, 5),
                    midterm = c(60, 80, 70, 90, 85))

# 기말고사 데이터 생성
test2 <- data.frame(id = c(1, 2, 3, 4, 5),
                    final = c(70, 83, 65, 95, 80))

test1
#   id midterm
# 1  1      60
# 2  2      80
# 3  3      70
# 4  4      90
# 5  5      85

test2
#   id final
# 1  1    70
# 2  2    83
# 3  3    65
# 4  4    95
# 5  5    80


#### id 기준으로 합치기
total <- left_join(test1, test2, by = "id") # id 기준으로 합쳐 total 에 할당

## [주의] by에 변수명을 지정할 때 변수명 앞 뒤에 겹따옴표 입력


total # total 출력

#   id midterm final
# 1  1      60    70
# 2  2      80    83
# 3  3      70    65
# 4  4      90    95
# 5  5      85    80




#------------------------
## 다른 데이터 활용해 변수 추가하기

#### 반별 담임교사 명단 생성
name <- data.frame(class = c(1, 2, 3, 4, 5),
                   teacher = c("kim", "lee", "park", "choi", "jung"))
name

#   class teacher
# 1     1     kim
# 2     2     lee
# 3     3    park
# 4     4    choi
# 5     5    jung


head(exam,5)
#   id class math english science
# 1  1     1   50      98      50
# 2  2     1   60      97      60
# 3  3     1   45      86      78
# 4  4     1   30      98      58
# 5  5     2   25      80      65



#### class 기준 합치기
exam_new <- left_join(exam,name,by="class")
head(exam_new,5)

#   id class math english science teacher
# 1  1     1   50      98      50     kim
# 2  2     1   60      97      60     kim
# 3  3     1   45      86      78     kim
# 4  4     1   30      98      58     kim
# 5  5     2   25      80      65     lee


#------------------------
## 세로로 합치기

#### data 생성
# 학생 1~5 번 시험 데이터 생성
group_a <- data.frame(id = c(1, 2, 3, 4, 5),
                      test = c(60, 80, 70, 90, 85))
# 학생 6~10 번 시험 데이터 생성
group_b <- data.frame(id = c(6, 7, 8, 9, 10),
                      test = c(70, 83, 65, 95, 80))

group_a
#   id test
# 1  1   60
# 2  2   80
# 3  3   70
# 4  4   90
# 5  5   85


group_b
#   id test
# 1  6   70
# 2  7   83
# 3  8   65
# 4  9   95
# 5 10   80



#### 세로로 합치기
group_all <- bind_rows(group_a, group_b) #데이터 합쳐서 group_all에 할당
group_all # group_all 출력
#    id test
# 1   1   60
# 2   2   80
# 3   3   70
# 4   4   90
# 5   5   85
# 6   6   70
# 7   7   83
# 8   8   65
# 9   9   95
# 10 10   80