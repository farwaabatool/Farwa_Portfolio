
mydata <- read.csv(file.choose(), header = TRUE)
str(mydata)
head(mydata)

#Scatter plot
plot(mydata$Fuel_Cost ~ mydata$Sales, data = mydata)
with(mydata,text(mydata$Fuel_Cost ~ mydata$Sales,  labels=mydata$Company, pos=4, cex=0.4))

#data cleaning#
sum(is.na(mydata))
final <- mydata
final$Company<- NULL

#normalize#
means = apply(final, 2, mean)
sds = apply(final, 2, sd)
nor = scale(final, center = means, scale = sds)
nor <- data.frame(nor)

#elbow method#
k.max<- 10 #max 10 clusters
wss <- rep(NA, k.max)
nClust <- list()
for (i in 1:k.max) {
  scree <- kmeans(nor,1) 
  wss[[i]]<-scree$tot.withinss
  nClust[[i]] <- scree$size
}

#plotting scree plot
plot(1:k.max,wss,type = "b", xlab = "Number of clusters: k", ylab = "Total within-clusters sum of squares")

#k-means clustering
kc <- kmeans(nor, 5)
kc

#plotting the results
plot(mydata[c("D.Demand", "Sales")], col = kc$cluster)

#selected segmentation variables
ksel <-kmeans(nor[,c("D.Demand","Sales", "Fuel_Cost")],5)
ksel

#Plotting the Result#
plot(mydata[c("D.Demand", "Sales")], col = ksel$cluster)
