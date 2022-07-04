intent <- read.csv(file.choose(), header = TRUE)


sum(is.na(intent))

library(dplyr)

AB <- intent %>% group_by(segment) %>% summarise( customer = n(), Avg_45 = mean(Price_45), Avg_65 = mean(Price_65))

library(ggplot2)
                                                  
ggplot(AB, aes(x = segment, y = Avg_45)) + geom_col(aes(fill=segment))
ggplot(AB, aes(x = segment, y = Avg_65)) + geom_col(aes(fill=segment))


#STEP1#Hypothesis Testing#
##Null: There is no difference in the purchase intent of both segments
##Alt: There is a difference in the purchase intent of both segments

#Step 2: Determin type of test
#Is it one-sided or two-sided?
##two-sided test since no directionality is involved

#Step 3: Calculate test statistic
t.test(Price_45 ~ segment, data = intent, var.equal= TRUE, paired= FALSE)

t.test(Price_65 ~ segment, data = intent, var.equal= TRUE, paired= FALSE)

#Step 4: Report result
#for avg_45 = t<- 1.6966 p <- 0.09 > 0.05
#for avg_65 = t<- -6.53239 p <- 1.447e-09 <0.05
#Step 5: State your conclusion
#for avg_45; reject null hypothesis as there is a difference in the purchase intent