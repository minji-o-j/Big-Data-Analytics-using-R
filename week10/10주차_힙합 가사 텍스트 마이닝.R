# 패키지 설치 및 로드----------------------
# 패키지 설치
install.packages("rJava")
install.packages("memoise")
install.packages("KoNLP")
install.packages("multilinguer")
library(multilinguer)
install.packages(c("stringr", "hash", "tau", "Sejong", "RSQLite", "devtools"), type =
                   "binary")
install.packages("https://cran.r-project.org/src/contrib/Archive/KoNLP/KoNLP_0.80.2.tar.gz", repos = NULL, type = "source",
                 upgrade = "never", INSTALL_opts=c("--no-multiarch"))


# 패키지 로드
library(KoNLP)
## Checking user defined dictionary!
library(dplyr)



# 사전 설정하기----------------------
useNIADic()



#데이터 준비----------------------
# 데이터 불러오기(멜론 차트 랩/힙합 부문 상위 50곡의 가사가 들어있는 파일)
txt <- readLines("Data/hiphop.txt")
## Warning in readLines("hiphop.txt"): incomplete final line found on
## 'hiphop.txt'
head(txt)



# 특수문자 제거----------------------
library(stringr)

# 특수문자 제거(문자 처리 패키지인 stringr의 str_replace_all() 이용)
txt <- str_replace_all(txt, " \\W", " ")

