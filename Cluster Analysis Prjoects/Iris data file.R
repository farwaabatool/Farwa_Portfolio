#GETTING NEW DATA#
data(iris)
head(iris)
str(iris)

#NEW DATA WITH FEATURES ONLY#
iris_features <-iris
iris_features$Species <- NULL

#DATA CLEANING#
sum(is.na(iris_features)) 
na.omit(iris_features)

#K MEAN ANALYSIS#
results <- kmeans(iris_features,3) 
results

#OBSERVATIONS
results$size
results$cluster

#CHECKING#
table(iris$Species, results$cluster)
plot(iris[c("Petal.Length","Petal.Width")], col = results$cluster)
plot(iris[c("Petal.Length","Petal.Width")], col = iris$Species)
plot(iris[c("Sepal.Length","Sepal.Width")], col = results$cluster)
plot(iris[c("Sepal.Length","Sepal.Width")], col = iris$Species)
