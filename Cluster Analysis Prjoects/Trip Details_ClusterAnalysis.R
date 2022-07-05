#Getting the Data
tripDetails<- read.csv(file.choose(), header = TRUE)
str(tripDetails)
summary(tripDetails)

#Data Cleaning
sum(is.na(tripDetails))
tripfinal <- tripDetails
tripfinal$TripID <- NULL

#K-means Analysis
tripCluster <- kmeans(tripfinal,3)
tripCluster

#Elbow Method
k.max <- 10 #maximum 10 clusters
wss <- rep(NA, k.max) #within sum of squares wss
nClust <- list()

for (i in 1:k.max) {
  driveClasses <- kmeans(tripfinal,i)
  wss[1] <- driveClasses$tot.withinss
  nClust[[i]] <- driveClasses$size
} #command exactly like this, and then scree plot is plotted

#Scree Plot#
plot(1:k.max,wss,type = "b", xlab = "Number of clusters: K", ylab = "Total within-clusters sum of squares")

#plotting the result
plot(tripDetails[c("TripID","TripLength")], col = tripCluster$cluster)
