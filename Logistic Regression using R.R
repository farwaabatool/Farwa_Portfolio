# Read data
spw <- read.csv(file.choose(), header = TRUE)

# Some basic tasks
str(spw)

# Turn gender and success into categorical variables
spw$Gender <- as.factor(spw$Gender)
spw$Success <- as.factor(spw$Success)

# Remove first two columns
spw <- spw[ ,-1] # Run this twice to remove first two columns

# Split my data into training and test
train <- spw[1:1000, ]
test <- spw[1001:2000, ]

# Make a logistic regression model
model <- glm(formula = Success~ ., 
             family = "binomial", #fixed argument for logistic regression 
             data = train)

# Get probability predictions for training and testing data
trainpreds <- model$fitted.values
testpreds <- predict(model, test, type = "response") # Use model to make predictions on test data

# Append all predictions in one column and save as csv
allpreds <- c(trainpreds, testpreds)
write.csv(allpreds, file = "predictions.csv")
