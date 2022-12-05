library(tidyverse);
library(mltools)
library(data.table)
library(corrplot)
library(caTools)
library(car)
library(rpart)
library(rpart.plot)
library(naivebayes)
library(dplyr)
library(ggplot2)
library(psych)


data <- read.csv("source_data/cardio_train.csv", header=TRUE, sep=";");


#######################################
###########Data preprocessing##########
#######################################
#check is there is null data in the dataset and get false which means there is no null data
test_null <- is.null(data);

#check if there is duplicate data, I got unique data has the same dimension of original data, so no duplicate data
data_unique <- unique(data);

#plot the box plot for age and weight, I found the ranges are quite difference, so I think I need to normalize the data
png("figures/boxplot_age_weight.png")
boxplot(data$age , data$weight);
dev.off

#normalized all continous data
data$age <- as.data.frame(scale(data$age))
data$height <- as.data.frame(scale(data$height))
data$weight <- as.data.frame(scale(data$weight));
data$ap_hi <- as.data.frame(scale(data$ap_hi));
data$ap_lo <- as.data.frame(scale(data$ap_lo));

#there is no comparsion for gender between 1 and 2, so I did the one hot encoding to change 1 as 1,0 and 2 as 0,1
data$gender <- as.factor(data$gender)
newdata <- one_hot(as.data.table(data))

#######################################
############Feature Engineer###########
#######################################
#remove the unnecessary column, e.g.id
newdata <- newdata[,2:14];

#check balance data,like the numbers of 0 and 1 in cardio, I got exactly the same numbers for 0 and 1
png("figures/check_balance.png")
hist(newdata$cardio)
dev.off

#check the correlation between features,from the plot I found there is no duplicate features
png("figures/features_corr.png")
corrplot(cor(newdata), method="pie")
dev.off

df <- with(newdata, table(cardio, cholesterol))
png("figures/cholesterol_vs_cardio.png")
barplot(df, beside = TRUE, legend = TRUE)
dev.off

data2 <- read.csv("source_data/cardio_train.csv", header=TRUE, sep=";");
data2$age <- floor(data2$age/365)
df2 <- with(data2, table(cardio, age))
png("figures/age_vs_cardio.png")
barplot(df2, beside = TRUE, legend = TRUE)
dev.off


#######################################
########Build and train model##########
#######################################
#seperate the data, use first 48462(70%) data to do the training and use second 21538 to do testing
age <- newdata$age;
weight <- newdata$weight;
cholesterol <- newdata$cholesterol;
cardio <- newdata$cardio;
final_data <- data.frame(age,weight,cholesterol,cardio);
write.csv(final_data,"output/final_data.csv");

training_data  <- final_data[1:48462,]
testing_data   <- final_data[48463:70000,]

write.csv(training_data, "output/training_data.csv");
write.csv(training_data, "output/testing_data.csv");

#logistics regression
model_lr <- glm( cardio ~. , data = training_data, family = binomial)
summary(model_lr)$coef
probabilities <- model_lr %>% predict(testing_data, type = "response")
head(probabilities)
predicted.classes <- ifelse(probabilities > 0.5, "1", "0")
mean(predicted.classes == testing_data$cardio) #0.6417959

#decision tree
fit <- rpart(cardio~., data = training_data, method = 'class')
png("figures/Decision_Tree.png")
rpart.plot(fit, extra = 106)
dev.off
predict_unseen <-predict(fit, testing_data, type = 'class')
table_mat <- table(testing_data$cardio, predict_unseen)
table_mat   
accuracy_Test <- sum(diag(table_mat)) / sum(table_mat)
print(paste('Accuracy for test', accuracy_Test)) #0.618


#naive Bayes
model <- naive_bayes(as.factor(cardio) ~ ., data = training_data, usekernel = T) 
p <- predict(model, training_data, type = 'prob')
p1 <- predict(model, training_data)
tab1 <- table(p1, training_data$cardio)
misclassification <- 1 - sum(diag(tab1)) / sum(tab1) #Misclassification is around 38% Training model accuracy is around 62% not bad


