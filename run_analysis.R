# Getting and Cleaning Data
# Coursera
# John Hopkins University

# Week 4 - Assignment

# check / set working directory and load packages
rm(list=ls())
library(dplyr)
getwd()
setwd("C:/Users/SV Tech Holdings/Documents/Coursera/Getting_Cleaning_Data/Getting_Cleaning_Data_Week4")

#1. Merges the training and the test sets to create one data set.
trainData<-read.table("./data/train/X_train.txt") #dim 7352 * 561
testData<-read.table("./data/test/X_test.txt") #dim 2947 * 561
testAndtrainData<-rbind(trainData,testData) #dim 10299 * 561
rm(trainData)
rm(testData)

trainDataLabel<-read.table("./data/train/y_train.txt") #dim 7352*1
testDataLabel<-read.table("./data/test/y_test.txt") #dim 2947 * 1
testAndtrainDataLabel<-rbind(trainDataLabel,testDataLabel) #dim 10299 * 1
rm(trainDataLabel)
rm(testDataLabel)


trainSubject<-read.table("./data/train/subject_train.txt") #dim 7352 * 1
testSubject<-read.table("./data/test/subject_test.txt") #dim 2947 * 1
testAndtrainSubject<-rbind(trainSubject,testSubject) #dim 10299 * 1
rm(trainSubject)
rm(testSubject)

#2. Extracts only the measurements on the mean and standard 
features <- read.table("./data/features.txt") #dim 561 * 2
estVariables <- grep("mean\\(\\)|std\\(\\)", features[, 2]) 
length(estVariables)
testAndtrainData <- testAndtrainData[, estVariables]
names(testAndtrainData) <- gsub("\\(\\)", "", features[estVariables, 2]) # remove "()"
names(testAndtrainData) <- gsub("mean", "Mean", names(testAndtrainData)) # capitalize M
names(testAndtrainData) <- gsub("std", "Std", names(testAndtrainData)) # capitalize S
names(testAndtrainData) <- gsub("-", "", names(testAndtrainData)) # remove "-" in column names

#3. Uses descriptive activity names to name the activities in the data set
activityNames<-read.table("./data/activity_labels.txt")
activityNames[, 2] <- tolower(gsub("_", "", activityNames[, 2]))
substr(activityNames[2, 2], 8, 8) <- toupper(substr(activityNames[2, 2], 8, 8))
substr(activityNames[3, 2], 8, 8) <- toupper(substr(activityNames[3, 2], 8, 8))
activityLabel<-activityNames[testAndtrainDataLabel[,1],2]
testAndtrainDataLabel[,1]<-activityLabel
names(testAndtrainDataLabel)<-"activity"
str(testAndtrainDataLabel)

#4. Appropriately label the data set with descriptive activity names
names(testAndtrainSubject)<-"subject"
tidyData<-cbind(testAndtrainSubject,testAndtrainDataLabel, testAndtrainData)
write.table(tidyData,"tidyData.txt")

#5. Create a second, independent tidy data set with the average of each variable for each activity and each subject. 
subjects <- length(table(testAndtrainSubject)) #6
activities <- dim(activityNames)[1] #30
columns <- dim(tidyData)[2]
total <- as.data.frame(matrix(NA,nrow=subjects*activities,ncol=columns))
colnames(total) <- colnames(tidyData)
row <- 1
for(i in 1:subjects) {
  for(j in 1:activities) {
    total[row, 1] <- sort(unique(testAndtrainSubject)[, 1])[i]
    total[row, 2] <- activityNames[j,2]
    bool1 <- i == tidyData$subject
    bool2 <- activityNames[j, 2] == tidyData$activity
    total[row, 3:columns] <- colMeans(tidyData[bool1&bool2, 3:columns])
    row <- row + 1
  }
    
}
head(total)
write.table(total,"meanoftidyData.txt",row.names = FALSE)

