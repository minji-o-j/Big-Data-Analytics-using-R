#-----------------------------------------------------------
# 3. CSV, XLS, TXT: 공공데이터포털
#-----------------------------------------------------------
library(readxl)
r_excel <- read_excel("Data/r_excel.xlsx", 
                      skip = 3)
View(r_excel)

write_tsv(r_excel, "C:/easy_R/Data/r_txt.txt")



#-----------------------------------------------------------
# 4. XML과 JSON: 서울열린데이터광장
#-----------------------------------------------------------
#--------------
# XML 데이터
# XML 패키지 설치
install.packages('XML')
library(XML)
# Open API에서 제공되는 데이터 확인
url <- 'http://openapi.seoul.go.kr:8088/716646734e6a696e3130375a66507755/xml/SebcPublicEnterpriseKor/1/1000/'
indata <- xmlToDataFrame(url)
View(indata)

# 1~2행과 1~3열 제거
indata <- indata[-1:-2,-1:-3] 

#--------------
#JSON 데이터
# jsonlite 패키지 설치
install.packages("jsonlite")
library(jsonlite)

# URL에서 JSON 데이터 가져오기(해들리 위컴이 속한 팀 프로젝트 정보)
install.packages("curl")
library(curl)
data2 <- fromJSON("https://api.github.com/users/hadley/orgs")
data2 <- as.data.frame(data2)
colnames(data2)
View(data2)


# 파일에서 JSON 데이터 가져오기
data <- fromJSON("C:/easy_R/Data/전국초등학교통학구역표준데이터.json")
names(data)
data <- as.data.frame(data$records)
View(data)


#-----------------------------------------------------------
# 5. 빅데이터(feather와 fst)
#-----------------------------------------------------------
# 내장 데이터셋 확인
data()
View(mtcars)

# 1억개의 난수 생성
data <- data.frame(number=rnorm(n=100000000))
dim(data)

# 패키지 설치 & 로드
install.packages("feather")
library(feather)
install.packages("fst")
library(fst)

# Rdata 파일 형식 쓰기
system.time({save(data,file="./Data/data.RData")})

# RData 파일 형식 읽기
system.time({load("./Data/data.RData")})

# csv 파일 형식 쓰기
system.time({write.csv(data,"./Data/data.csv")})

# csv 파일 형식 읽기
system.time({data1<-read.csv("./Data/data.csv")})

# feater 파일 형식 쓰기
system.time({write_feather(data,"./Data/data.feather")})

# feater 파일 형식 읽기
system.time({data2<-read_feather("./Data/data.feather")})

# fst 파일 형식 쓰기
system.time({write.fst(data,"./Data/data.fst")})

# fst 파일 형식 읽기
system.time({data3<-read.fst("./Data/data.fst")})