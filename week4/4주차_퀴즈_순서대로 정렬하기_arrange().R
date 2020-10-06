#mpg 데이터를 이용해서 분석 문제를 해결해보세요.

mpg <- as.data.frame(ggplot2::mpg) # mpg 데이터 불러오기
head(mpg,3)

#   manufacturer model displ year cyl      trans drv cty hwy fl   class
# 1         audi    a4   1.8 1999   4   auto(l5)   f  18  29  p compact
# 2         audi    a4   1.8 1999   4 manual(m5)   f  21  29  p compact
# 3         audi    a4   2.0 2008   4 manual(m6)   f  20  31  p compact


#------------------------------
##• "audi"에서 생산한 자동차 중에 어떤 자동차 모델의 hwy(고속도로 연비)가 높은지 알아보려고 합니다. "audi"에서 생산한 자동차 중 hwy가 1~5위에 해당하는 자동차의 데이터를 출력하세요.


mpg %>% filter(manufacturer=="audi") %>%  #audi에서 생산한 자동차만 추출
  arrange(desc(hwy)) %>% 
  head(5)

#   manufacturer      model displ year cyl      trans drv cty hwy fl   class
# 1         audi         a4   2.0 2008   4 manual(m6)   f  20  31  p compact
# 2         audi         a4   2.0 2008   4   auto(av)   f  21  30  p compact
# 3         audi         a4   1.8 1999   4   auto(l5)   f  18  29  p compact
# 4         audi         a4   1.8 1999   4 manual(m5)   f  21  29  p compact
# 5         audi a4 quattro   2.0 2008   4 manual(m6)   4  20  28  p compact