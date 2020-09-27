#------------
#CSV 파일 불러오기
df_csv_exam <- read.csv("Data/csv_exam.csv") #변수로 시작한 경우 header=F사용 
df_csv_exam

# id class math english science
# 1   1     1   50      98      50
# 2   2     1   60      97      60
# 3   3     1   45      86      78
# 4   4     1   30      98      58
# 5   5     2   25      80      65
# 6   6     2   50      89      98
# 7   7     2   80      90      45
# 8   8     2   90      78      25
# 9   9     3   20      98      15
# 10 10     3   50      98      45
# 11 11     3   65      65      65
# 12 12     3   45      85      32
# 13 13     4   46      98      65
# 14 14     4   48      87      12
# 15 15     4   75      56      78
# 16 16     4   58      98      65
# 17 17     5   65      68      98
# 18 18     5   80      78      90
# 19 19     5   89      68      87
# 20 20     5   78      83      58


#------------
#문자가 들어 있는 파일을 불러올 때는 stringsAsFactors = F
#df_csv_exam <- read.csv("data/csv_exam.csv", stringsAsFactors = F)
#변수를 문자타입으로 인식해서 불러온다.

#------------
#dataframe을 csv파일로 저장하기
df_midterm <- data.frame(english = c(90, 80, 60, 70),
                         math = c(50, 60, 100, 20),
                         class = c(1, 1, 2, 2))
df_midterm
# english math class
# 1      90   50     1
# 2      80   60     1
# 3      60  100     2
# 4      70   20     2

write.csv(df_midterm, file = "Data/df_midterm.csv")
