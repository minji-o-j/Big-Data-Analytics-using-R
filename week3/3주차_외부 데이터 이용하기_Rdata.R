#--------------
#Rdata 파일 활용하기
#• R 전용 데이터 파일
#• 용량 작고 빠름


#--------------
#데이터 프레임을 RData 파일로 저장하기
save(df_midterm, file = "df_midterm.rda")


#저장된 dataframe 삭제
rm(df_midterm)
df_midterm
## Error in eval(expr, envir, enclos): object 'df_midterm' not found
##에러: 객체 'df_midterm'를 찾을 수 없습니다


#RData 불러오기
load("df_midterm.rda")
df_midterm
# english math class
# 1      90   50     1
# 2      80   60     1
# 3      60  100     2
# 4      70   20     2

#--------------
#다른 파일을 불러올 때와 차이점
#• 엑셀, CSV는 파일을 불러와 새 변수에 할당해서 활용
#• rda는 불러오면 저장한 데이터 프레임이 자동 생성됨. 할당 없이 바로 활용


#--------------
# 엑셀 파일 불러와 df_exam에 할당하기
df_exam <- read_excel("Data/excel_exam.xlsx")

# csv 파일 불러와 df_csv_exam 에 할당하기
df_csv_exam <- read.csv("Data/csv_exam.csv")

# Rda 파일 불러오기: 할당할 필요없다! 바로 볼수있음
load("df_midterm.rda")
