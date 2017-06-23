## Coursera course #3: Getting and Cleaning Data - Final Project
## Brad Cooley
## Juen 23, 2017

# Data: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

# Instructions:
# 1.Merge the training and the test sets to create one data set.
# 2.Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy data set with the average 
#    of each variable for each activity and each subject.

# Libraries
library(dplyr)
library(stats)

# Files are split into train & test data sets. For each, three files: a subject file, an activity file,
# and the raw data files. Also, in the HAR root lives the description files.
# These I've already downloaded and unzipped into three folders:

train.path <- "/Users/bradcooley1/Desktop/HAR/train/"
test.path <- "/Users/bradcooley1/Desktop/HAR/test/"
HAR.path <- "/Users/bradcooley1/Desktop/HAR/"

# Read the subject (person) files from train & test files
train.subject <- read.table(paste(train.path,"subject_train.txt",sep = ""))
test.subject <- read.table(paste(test.path,"subject_test.txt",sep = ""))

# Read the activity (e.g. IDs for walk, climb stairs, etc.) files from train & test files
train.activity <- read.table(paste(train.path,"y_train.txt",sep = ""))
test.activity <- read.table(paste(test.path,"y_test.txt",sep = ""))

# Read the raw data files (561 variables) files from train & test files
train.ds <- read.table(paste(train.path,"X_train.txt",sep = ""))
test.ds <- read.table(paste(test.path,"X_test.txt",sep = ""))

# Read in feature names  
features <- read.table(paste(HAR.path,"features.txt",sep = ""))

# Next append the train and test data sets for subjects, activities and raw data
all.subject <- rbind(train.subject, test.subject)
setnames(all.subject, "V1", "subject")

all.activity <- rbind(train.activity,test.activity)
setnames(all.activity, "V1", "activity")

all.ds <- rbind(train.ds, test.ds)

# Extract only the measurements on the mean and standard deviation for each measurement (e.g. "std" & "mean")
lfeats <- grep("mean\\(\\)|std\\(\\)", features$V2)
all.ds <- all.ds[,lfeats]
setnames(all.ds, names(all.ds),as.vector(features[lfeats,"V2"]))

# Combine the three data sets
all.subject <- cbind(all.subject, all.activity)
all.ds <- cbind(all.subject, all.ds)

# Remove garbage datasets
rm(list = c("train.subject","test.subject", "train.activity", "test.activity", "train.ds", "test.ds"))

# Read in activity names  
activity.names <- read.table(paste(HAR.path,"activity_labels.txt",sep = ""))
setnames(activity.names, names(activity.names), c("activity","activity.name"))

# Merge activity names by activity, then drop the activity id col and convert activity.name & subject to Factors
all.ds <- merge(activity.names, all.ds, by="activity")
all.ds <- subset(all.ds, select = -c(activity) )
all.ds$activity.name <- as.factor(all.ds$activity.name)
all.ds$subject <- as.factor(all.ds$subject)

# Finally, create tidy data set with the average of each variable for each activity and each subject.
tidyHAR <- aggregate(x = all.ds[,c(3:length(names(all.ds)))], by = list(all.ds$subject, all.ds$activity.name), 
                     FUN = "mean", simplify = TRUE, na.action = na.omit)
names(tidyHAR)[c(1,2)] <- c("subject","activity")

# Output to a table
write.csv(as.data.frame(tidyHAR),"tidyHAR.csv",row.names = FALSE)





