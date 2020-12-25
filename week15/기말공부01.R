library(foreign) # SPSS 파일 로드
library(dplyr) # 전처리
library(ggplot2) # 시각화
library(readxl) # 엑셀 파일 불러오기
raw_welfare <- read.spss(file = "Data/Koweps_hpc10_2015_beta1.sav",
                         to.data.frame = T)
welfare <- raw_welfare


ggplot(data = df_divorce, aes(x = ageg, y = pct, fill = religion)) +
  
  geom_col(position = "dodge")
