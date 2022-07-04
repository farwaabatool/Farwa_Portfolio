mydata <- read.csv(file.choose(), header = TRUE)
str(mydata)
head(mydata)

install.packages("psych")
library(psych)
pairs.panels(mydata[2:15])

mlr <- lm(Sales ~ Sales.Event + Wechat2 + Wechat1 + Facebook2 + Facebook1 + Display2 + Display1 + NationalTV1 + NationalTV2 + Magazine1 + Magazine2 + PaidSearch1 + PaidSearch2, mydata)
mlr
summary(mlr)


final_mlr <- lm(Sales ~ Sales.Event + Wechat2 + Wechat1, mydata)
final_mlr
summary(final_mlr)

mlr_se <- lm(Sales ~ Sales.Event, mydata)
mlr_se
summary(mlr_se)

anova(final_mlr, mlr)

anova(mlr_se, final_mlr)



#2nd part#

pairs(mydata[2:4])

results_nc1Xm1 <- lm(Sales ~ Magazine1 + NationalTV1 + (Magazine1*NationalTV1), mydata)
summary(results_nc1Xm1)

mydata$cNationalTV1 <- (mydata$NationalTV1 - mean(mydata$NationalTV1))
results_CENnc1Xm1 <- lm(Sales ~ Magazine1 + cNationalTV1 + (Magazine1*cNationalTV1), mydata)
summary(results_CENnc1Xm1)

mydata$hNationalTV1 <- (mydata$NationalTV1 - sd(mydata$NationalTV1))
results_Hnc1Xm1 <- lm(Sales ~ Magazine1 + hNationalTV1 + (Magazine1*hNationalTV1), mydata)
summary(results_Hnc1Xm1)

mydata$lNationalTV1 <- (mydata$NationalTV1 + sd(mydata$NationalTV1))
results_Lnc1Xm1 <- lm(Sales ~ Magazine1 + lNationalTV1 + (Magazine1*lNationalTV1), mydata)
summary(results_Lnc1Xm1)


#part 3#
pairs(mydata[2:3])


results_nc1Xnc2 <- lm(Sales ~ NationalTV2 + NationalTV1 + (NationalTV2*NationalTV1), mydata)
summary(results_nc1Xnc2)


mydata$hNationalTV1 <- (mydata$NationalTV1 - sd(mydata$NationalTV1))
results_Hnc1Xnc2 <- lm(Sales ~ NationalTV2 + hNationalTV1 + (NationalTV2*hNationalTV1), mydata)
summary(results_Hnc1Xnc2)

