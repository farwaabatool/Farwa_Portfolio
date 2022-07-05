
#bring in the data
data <- read.table('CDNow.txt', sep = "", header = F, nrows = 69659, na.strings = "", stringsAsFactors = F)
colnames(data) <- c('cust', 'date', 'orders', 'sales')
data$date <- as.Date(as.character(data$date), format= '%Y%m%d', origin = "1970-01-01")


#using BYTDplus package for CLV
install.packages("BTYDplus")
library(BTYDplus)


customer_data<- BTYDplus::elog2cbs(data, unit = 'days', T.cal = max(data$date), T.tot = max(data$date)) #x=no. of recurring orders, sales= sum of sales, sales.x=exclude first transaction, first= first transaction


customer_data$sales_avg = customer_data$sales/(customer_data$x + 1)
customersales <- customer_data
customersales$T.star <- 365

#Estimate Model Parameters
params_cust<- BTYD::bgnbd.EstimateParameters(customersales)

#predict Expected Transactions
customersales$predicted_transaction <- BTYD::bgnbd.ConditionalExpectedTransactions(params = params_cust, T.star=customersales$T.star,
                                                                                   x = customersales$x, t.x = customersales$t.x, T.cal = customersales$T.cal)

#calculate CLV
customersales$predicted_clv <- customersales$sales_avg*customersales$predicted_transaction

#Visualize CLV
hist(customersales$predicted_clv, xlim = c(0,100), breaks=3000, col=rainbow(10))








