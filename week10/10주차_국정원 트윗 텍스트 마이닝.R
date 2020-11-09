## 데이터 준비하기-------------------
# 데이터 로드
twitter <- read.csv("data/twitter.csv",
                    header = T,
                    stringsAsFactors = F,
                    fileEncoding = "UTF-8")

# 변수명 수정
twitter <- rename(twitter,
                  no = 번호,
                  id = 계정이름,
                  date = 작성일,
                  tw = 내용)

# 특수문자 제거
twitter$tw <- str_replace_all(twitter$tw, "\\W", " ")

head(twitter$tw)
# [1] "민주당의 ISD관련 주장이 전부 거짓으로 속속 드러나고있다  미국이 ISD를 장악하고 있다고 주장하지만 중재인 123명 가운데 미국인은 10명뿐이라고 한다 "                                                                               
# [2] "말로만  미제타도   사실은  미제환장   김정일 운구차가 링컨 컨티넬탈이던데 북한의 독재자나 우리나라 종북들이나 겉으로는 노동자  서민을 대변한다면서 고급 외제차  아이팟에 자식들 미국 유학에 환장하는 위선자들인거죠"            
# [3] "한나라당이 보수를 버린다네요 뭔가착각하는모냥인에 국민들이보수를싫어하는게 아니라뻘짓거리하는분들을싫어하는겁니다야당이진보어쩌고저쩌고한다고해서그들을조아한다고생각하면대착각"               # [4] "FTA를 대하는 현명한 자세  사실 자유주의 경제의 가장 큰 수해자는 한국이죠  농어업분야 피해를 줄이는 정부대안을 최대한  보완하고 일자리 창출 등 실익을 최대화해 나가는게 현실적인 대처자세일듯 "                                  
# [5] "곽노현씨 갈수록 가관입니다  뇌물질에 아들 병역 의혹까지  도대체 아이들이 뮐 보고 배우겠습니까  이래도 자리 연연하시겠습니까 "                                                                                                  
# [6] "과거 집권시 한미FTA를 적극 추진하던 세력이 이제 집권하면 폐기하겠다고 주장합니다  어이없어 말도 안 나오네요  표만 얻을 수 있다면 국가 안보나 경제가 어떻게 되든 상관없다는 무책임한 행태들  우리 정치의 후진성을 드러내는 거죠 "



## 단어 빈도표 만들기-------------------
# 트윗에서 명사추출
nouns <- extractNoun(twitter$tw)

# 추출한 명사 l i st 를 문자열 벡터로 변환, 단어별 빈도표 생성
wordcount <- table(unlist(nouns))

# 데이터 프레임으로 변환
df_word <- as.data.frame(wordcount, stringsAsFactors = F)

# 변수명 수정
df_word <- rename(df_word,
                  word = Var1,
                  freq = Freq)



## 두 글자 이상으로 된 단어 추출, 빈도 상위 20개 단어 추출-------------------
# 두 글자 이상 단어만 추출
df_word <- filter(df_word, nchar(word) >= 2)

# 상위 20개 추출
top20 <- df_word %>%
  arrange(desc(freq)) %>%
  head(20)

top20
#     word freq
# 1    북한 1167
# 2    민국  804
# 3    대한  800
# 4    우리  778
# 5    좌파  640
# 6    국민  505
# 7    들이  411
# 8    세력  406
# 9    친북  387
# 10   종북  340
# 11   단체  336
# 12   대선  327
# 13   진보  327
# 14   사회  294
# 15 북한이  284
# 16   정부  279
# 17 전교조  278
# 18   주장  263
# 19 연평도  262
# 20   정권  259



## 단어 빈도 막대 그래프 만들기-------------------
library(ggplot2)
order <- arrange(top20, freq)$word # 빈도 순서 변수 생성
ggplot(data = top20, aes(x = word, y = freq)) +
  ylim(0, 2500) +
  geom_col() +
  coord_flip() +
  scale_x_discrete(limit = order) + # 빈도 순서 변수 기준 막대 정렬
  geom_text(aes(label = freq), hjust = -0.3) # 빈도 표시



## 워드클라우드 만들기-------------------
pal <- brewer.pal(8,"Dark2") # 색상 목록 생성
set.seed(1234) # 난수 고정
wordcloud(words = df_word$word, # 단어
          freq = df_word$freq, # 빈도
          min.freq = 10, # 최소 단어 빈도
          max.words = 200, # 표현 단어 수
          random.order = F, # 고빈도 단어 중앙 배치
          rot.per = .1, # 회전 단어 비율
          scale = c(6, 0.2), # 단어 크기 범위 목록
          colors = pal) # 색상


## 색깔 바꾸기-------------------
pal <- brewer.pal(9,"Blues")[5:9] # 색상 목록 생성
set.seed(1234) # 난수 고정
wordcloud(words = df_word$word, # 단어
          freq = df_word$freq, # 빈도
          min.freq = 10, # 최소 단어 빈도
          max.words = 200, # 표현 단어 수
          random.order = F, # 고빈도 단어 중앙 배치
          rot.per = .1, # 회전 단어 비율
          scale = c(6, 0.2), #단어 크기 범위 목록
          colors = pal) #색상
