
Chipotle <- read_excel(file.choose())
str(Chipotle)
head(Chipotle)
summary(Chipotle)


sum(is.na(Chipotle))
final <- na.omit(Chipotle)
final$top1 <- NULL
View(final)



means = apply(final,2,mean)
sds = apply(final,2,sd)
nor = scale(final,center=means,scale=sds)
nor <- data.frame(nor)



k.max <- 4 #Maximum 10 clusters
wss <- rep(NA, k.max)
nClust <- list()
for(i in 1:k.max) {
  scree <- kmeans(nor, i)
  wss[i] <- scree$tot.withinss
  nClust[[i]] <- scree$size
}

plot(1:k.max,wss,type = "b", xlab = "Number of clusters: k", ylab = "Total within-clusters sum of squares")


Dem_seg <- kmeans(nor[ ,c("female","age","income")], 3)
Dem_seg$size

Psy_seg <- kmeans(nor[ ,c("importantconvenience","importantvariety","importantprice","importantambience","importanttaste","importanthealthy")],3)
Psy_seg$size

Behav_seg <- kmeans(nor[ ,c("plan","spending","buylocal","healthyimportanttome","patronage")],3)
Behav_seg$size

Market_mix <- kmeans(nor[,c("wom","sm","walk","billboard","chipotleprice", "chipotlehealthy","chipotlevariety", "chipotletaste","chipotleambience", "chipotleconvenient")],3)
Market_mix$size


plot(final[c("age","income")],col= Dem_seg$cluster)


plot(final[c("importantconvenience","importantvariety")],col= Psy_seg$cluster)
plot(final[c("importantprice","importanthealthy")],col= Psy_seg$cluster)
plot(final[c("importantprice","importanttaste")],col= Psy_seg$cluster)


plot(final[c("plan","spending")],col= Behav_seg$cluster)
plot(final[c("buylocal","patronage")],col= Behav_seg$cluster)

plot(final[c("chipotleprice","chipotlehealthy")],col= Market_mix$cluster)
plot(final[c("chipotlevariety","chipotlehealthy")],col= Market_mix$cluster)
plot(final[c("chipotleambience","chipotleconvenient")],col= Market_mix$cluster)
plot(final[c("wom","sm")],col= Market_mix$cluster)
