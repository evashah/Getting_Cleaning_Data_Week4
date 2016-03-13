# Getting and Cleaning Data
# Coursera
# John Hopkins University

# Week 4 - Assignment Codebook

# Codebook: This file describes the variables, the data, and any transformations or work that have been performed to clean up the data:
# Data source: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

# Created R script created called "run_analysis.R" that does the following:

# Step 1: Merges the training and the test sets to create one data set.
# a. Merged training and test data to created 3 distinct data sets containing data, labels and subjects: 
# - testAndtrainData with dimensions 10299 * 561
# - testAndtrainDataLabel with dimensions 10299 * 1
# - testAndtrainSubject with dimensions 10299 * 1
# Step 2: Extracts only the measurements on the mean and standard deviation for each measurement.
# a. Read the features file to a variable called "features" and extracted the measurements for mean and standard deviation into variable called "estVariables" that included 66 indices
# b. Combined "estVariables" with "testAndtrainData" to create a subset with 66 columns
# c. Edited names of the columns in the "testAndtrainData" subset 
# Step 3: Use descriptive activity names to name the activities in the data set
# a. Read activity labels into variable called "activityNames"
# b. Tidied the activity labels in the second column by turning all labels to lower case, removing underscores and then capitalizing letters right after the underscores
# Step 4.	Appropriately labels the data set with descriptive variable names.
# a. Transformed the values of "testAndtrainDataLabel" according to the "activityNames" data set
# b. Created a "tidyData" data set by combining the data sets - "testAndtrainData", "testAndtrainSubject", "testAndtrainDataLabel" using cbind. 
# Step 5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
# a. Created a "total" data matrix consisting of 6 subjects, 30 activityNames resulting in a data frame of 180 * 68
# b. Calculated mean of each measurement with a corresponding combination of subjects and activityNames
# c. Wrote the result to the table "tidyDataSet.txt"
