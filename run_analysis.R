# This code was written in order to read the data collected during the project: "Human Activity Recognition Using Smartphones"
# The purpose of the code is to clean up the information and organize it according to the standards of 'tidy data' 
# and plots the mean of all variables ordered by "Subject" and "Activity".

finalDF <- function() {
# Sets the path to my local project library (change to yours if you want to check the code) 
setwd("/Users/arnon/Documents/Arnon/R/Data cleaning/courseProject/UCI\ HAR\ Dataset/")

# Loads libraries
library(reshape2)
library(dplyr)

# Reads the features list
featureNames <- read.table("./features.txt", header=F, as.is=T)

# Makes the feature names nicer (more descriptive and more "R style")
nicerFeatureNames <- gsub("\\-","\\_",featureNames[,2])
nicerFeatureNames <- gsub("\\(\\)","",nicerFeatureNames)

# Reads annotation of activity levels from "activity_labels.txt"
activityLabels <- read.table("./activity_labels.txt", header=F)

# Sets folders and stores a list of the input files path
trainDir <-"./train"
testDir <- "./test"
trainFiles <- list.files(trainDir, pattern="*.txt",full.names=T)
testFiles <- list.files(testDir, pattern="*.txt",,full.names=T)

# DF <- rbind(DF, dat)
# data <- ldply(c("df1", "df2"), function(dn) data.frame(Filename=dn, get(dn)))

## Reads the data for the training group:
subjects <- read.table(trainFiles[1],header=F,col.names="Subject")
# Reads the data and redirects it to "select()" to filter only the neccesary columns  
X <- read.table(trainFiles[2], header=F, colClasses="numeric", col.names=nicerFeatureNames) %>%
    select(contains("mean"),contains("std"))
# Reads the list of activity indications and sets it under the variable/column name "Activity"
Y <- read.table(trainFiles[3],header=F,col.names="Activity")
# Creates a new column indicating that this data belongs to the "training" group of the study
Y <- mutate(Y,group="training")
# Creates a temporary data frame containing all the data of the training group
trainDF <- data.frame(subjects,Y,X)

## Reads the data for the test group:
subjects <- read.table(testFiles[1],header=F,col.names="Subject")
# Reads the data and redirects it to "select()" to filter only the neccesary columns  
X <- read.table(testFiles[2], header=F, colClasses="numeric", col.names=nicerFeatureNames) %>%
    select(contains("mean"),contains("std"))
# Reads the list of activity indications and sets it under the variable/column name "Activity"
Y <- read.table(testFiles[3],header=F,col.names="Activity")
# Creates a new column indicating that this data belongs to the "test" group of the study
Y <- mutate(Y,group="test")
# Creates a temporary data frame containing all the data of the test group
testDF <- data.frame(subjects,Y,X)

# Cleans memory from redundant data
rm("X","Y")

# Combines the datasets of the training and test groups ("on top" of each other)
DF <-bind_rows(trainDF,testDF)

# Cleans memory from redundant data
rm("testDF","trainDF")

# Defines all the factorial variables (categorical variables)
DF$Activity <- factor(DF$Activity,levels=1:6, labels=activityLabels[,2])
DF$Subject <- factor(DF$Subject, levels=1:30)
DF$group <- factor(DF$group,levels=c("training","test"))

# Transforms the data to "tabulated data frame", just for nicer output
DF <- tbl_df(DF)

# Groups the data by "Subject" and "Activity" and summarizes it using the "dplyr" tools
# (I added the "group" category to the group_by() function so it shows the label
# for the group in the output)
finalDF <- group_by(DF, Subject, Activity, group) %>% summarise_each(funs(mean)) %>% print

# write.table(finalDF, "./finalTidyData.txt", row.name=FALSE)
}
