## Q1. data.frame()과 c()를 조합해서 표의 내용을 데이터 프레임으로 만들어 출력해보세요
fruits <- data.frame(product=c("사과","딸기","수박"),
                    cost=c(1800,1500,3000),
                    sale_c= c(24,38,13))
fruits
#   product cost sale_c
# 1    사과 1800     24
# 2    딸기 1500     38
# 3    수박 3000     13



##Q2. 앞에서 만든 데이터 프레임을 이용해서 과일 가격 평균, 판매량 평균을 구해보세요.
mean(fruits$cost)
#[1] 2100

mean(fruits$sale_c)
#[1] 25