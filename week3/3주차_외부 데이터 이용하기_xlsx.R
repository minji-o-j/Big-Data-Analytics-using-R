#--------------------
#엑셀 파일 불러오기- 패키지 설치, 로드
## readxl 패키지 설치
install.packages("readxl")

## readxl 패키지 로드
library(readxl)

df_exam <- read_excel("Data/excel_exam.xlsx") # 엑셀 파일을 불러와서 df_exam에 할당

df_exam # 출력

## # A tibble: 20 x 5
##     id  class  math english science
##   <dbl> <dbl> <dbl>   <dbl>   <dbl>
## 1     1    1     50      98     50
## 2     2    1     60      97     60
## 3     3    1     45      86     78
## 4     4    1     30      98     58
## 5     5    2     25      80     65
## 6     6    2     50      89     98
## 7     7    2     80      90     45
## 8     8    2     90      78     25
## 9     9    3     20      98     15
## 10   10    3     50      98     45
## 11   11    3     65      65     65
## 12   12    3     45      85     32
## 13   13    4     46      98     65
## 14   14    4     48      87     12
## 15   15    4     75      56     78
## 16   16    4     58      98     65
## 17   17    5     65      68     98
## 18   18    5     80      78     90
## 19   19    5     89      68     87
## 20   20    5     78      83     58



#--------------------
#엑셀 파일 불러오기- 분석하기
mean(df_exam$english)
## [1] 84.9

mean(df_exam$science)
## [1] 59.45


#--------------------
#엑셀 파일 첫 번째 행이 변수명이 아니라면? (데이터가 바로 시작)
df_exam_novar_x <- read_excel("Data/excel_exam_novar.xlsx")
df_exam_novar_x
# `1...1` `1...2` `50...3`  `98` `50...5`
# <dbl>   <dbl>    <dbl> <dbl>    <dbl>
#   1       2       1       60    97       60
# 2       3       2       25    80       65
# 3       4       2       50    89       98
# 4       5       3       20    98       15
# 5       6       3       50    98       45
# 6       7       4       46    98       65
# 7       8       4       48    87       12


## col_names = F: colum 이름을 가져오지 않겠다는 의미
df_exam_novar <- read_excel("Data/excel_exam_novar.xlsx", col_names = F)
df_exam_novar

# ...1  ...2  ...3  ...4  ...5
# <dbl> <dbl> <dbl> <dbl> <dbl>
#   1     1     1    50    98    50
# 2     2     1    60    97    60
# 3     3     2    25    80    65
# 4     4     2    50    89    98
# 5     5     3    20    98    15
# 6     6     3    50    98    45
# 7     7     4    46    98    65
# 8     8     4    48    87    12


#--------------------
#엑셀 파일에 시트가 여러 개 있다면?
df_exam_sheet <- read_excel("Data/excel_exam_sheet.xlsx", sheet = 3) #3번째 시트 가져옴
df_exam_sheet

#      id class  math english science
#    <dbl> <dbl> <dbl>   <dbl>   <dbl>
# 1     1     1    50      98      50
# 2     2     1    60      97      60
# 3     3     2    25      80      65
# 4     4     2    50      89      98
# 5     5     3    20      98      15
# 6     6     3    50      98      45
# 7     7     4    46      98      65
# 8     8     4    48      87      12
