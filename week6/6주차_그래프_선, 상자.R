#08-4. 선 그래프 - 시간에 따라 달라지는 데이터 표현하기
#----------------------
## ggplot2 로드
library(ggplot2)
#----------------------
economics <- as.data.frame(ggplot2::economics)
View(economics)
summary(economics)

#--------------------------------
# 시계열 그래프 만들기
#--------------------------------
ggplot(data = economics, aes(x = date, y = unemploy)) + geom_line()



#----------------------
#08-5. 상자 그림 - 집단 간 분포 차이 표현하기
#--------------------------------
# 시계열 그래프 만들기
#--------------------------------
ggplot(data = mpg, aes(x = drv, y = hwy)) + geom_boxplot()

