install.packages("CLVTools")
install.packages("BTYDplus")
library(CLVTools)

data("apparelTrans")

Apparel <- clvdata(apparelTrans, date.format = "ymd", time.unit = "week", estimation.split = 40, name.id = "Id", name.date = "Date", name.price = "Price")

Apparel


est_apparel <- pnbd(clv.data = Apparel)
est_apparel
coef(est_apparel)

results <- predict(est_apparel)
print(results)

#Plot the CLV

hist(results$predicted.CLV, col = rainbow(7), xlab = "Predicted CLV", main = "Histogram for the predicted CLV from 11th October 2005 till 16th July 2006")

     
#estimate spending
est_spend<- gg(clv.data = Apparel) #Gamma - Gamma Model
results.spending <- predict(est_spend)

#plot Spending
plot(est_spend)
hist(results.spending$predicted.mean.spending, xlab = "Average Predicted Spending", main = "Average Predicted Spending", col = rainbow(8), xlim = c(20,70))
