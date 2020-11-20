## 11-1. 미국 주별 강력 범죄율 단계 구분도 만들기 --------------------

install.packages("ggiraphExtra")
library(ggiraphExtra)

str(USArrests)
# 'data.frame':	50 obs. of  4 variables:
# $ Murder  : num  13.2 10 8.1 8.8 9 7.9 3.3 5.9 15.4 17.4 ...
# $ Assault : int  236 263 294 190 276 204 110 238 335 211 ...
# $ UrbanPop: int  58 48 80 50 91 78 77 72 80 60 ...
# $ Rape    : num  21.2 44.5 31 19.5 40.6 38.7 11.1 15.8 31.9 25.8 ...

head(USArrests)
#            Murder Assault UrbanPop Rape
# Alabama      13.2     236       58 21.2
# Alaska       10.0     263       48 44.5
# Arizona       8.1     294       80 31.0
# Arkansas      8.8     190       50 19.5
# California    9.0     276       91 40.6
# Colorado      7.9     204       78 38.7


#USArrests 데이터는 지역명 변수가 따로 없고, 행 이름(rownames)이 지역명으로 되어 있음
library(tibble)
# 행 이름을 state 변수로 바꿔 데이터 프레임 생성
crime <- rownames_to_column(USArrests, var = "state")
# 지도 데이터와 동일하게 맞추기 위해 state 의 값을 소문자로 수정
crime$state <- tolower(crime$state)



#미국 주별 범죄 데이터 준비하기-----------------
str(crime)
# 'data.frame':	50 obs. of  5 variables:
# $ state   : chr  "alabama" "alaska" "arizona" "arkansas" ...
# $ Murder  : num  13.2 10 8.1 8.8 9 7.9 3.3 5.9 15.4 17.4 ...
# $ Assault : int  236 263 294 190 276 204 110 238 335 211 ...
# $ UrbanPop: int  58 48 80 50 91 78 77 72 80 60 ...
# $ Rape    : num  21.2 44.5 31 19.5 40.6 38.7 11.1 15.8 31.9 25.8 ...



# 미국 주 지도 데이터 준비하기-----------------
install.packages("maps")
library(maps)
map(database="world", region="Japan")
korea <- c("South Korea", "North Korea")
map(database="world", region=korea)
map(database="world", region=korea, col="#01B8AA")
map(database="world", region=korea, col="#01B8AA", bg="#374649")
map(database="world", region=korea, col="#01B8AA", bg="#374649", fill=TRUE)

library(ggplot2)
states_map <- map_data("state")
str(states_map)



# 단계 구분도 만들기-----------------
install.packages("mapproj")
library(mapproj)

ggChoropleth(data = crime, # 지도에 표현할 데이터
             aes(fill = Murder, # 색깔로 표현할 변수
                 map_id = state), # 지역 기준 변수
             map = states_map) # 지도 데이터



# 인터랙티브 단계 구분도 만들기-----------------
ggChoropleth(data = crime, # 지도에 표현할 데이터
             aes(fill = Murder, # 색깔로 표현할 변수
                 map_id = state), # 지역 기준 변수
             map = states_map, # 지도 데이터
             interactive = T) # 인터랙티브
