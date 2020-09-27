#-------------
#dplyr 패키지 설치 & 로드
install.packages("dplyr") # dplyr 설치
library(dplyr) # dplyr 로드


#-------------
#데이터 프레임 생성
df_raw<- data.frame(var1 = c(1,2,1),
                    var2 = c(2,3,2))
df_raw
#   var1 var2
# 1    1    2
# 2    2    3
# 3    1    2


#-------------
#1. 데이터 프레임 복사본 만들기
df_new<- df_raw # 복사본 생성 ---- 원본보다 복사본 만들어서 원래상태로 되돌리기 위함! 아니면 변형 과정 확인 위함

df_new # 출력
#   var1 var2
# 1    1    2
# 2    2    3
# 3    1    2


#-------------
df_new <- rename(df_new, v2 = var2) # var2를 v2로 수정
df_new
#   var1 v2
# 1    1  2
# 2    2  3
# 3    1  2

##[유의] rename()에 '새 변수명 = 기존 변수명' 순서로 입력
