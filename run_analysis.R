setwd("/Users/arnon/Documents/Arnon/R/Data cleaning/courseProject/UCI\ HAR\ Dataset/")

# Load libraries
library(reshape2)
library(dplyr)

# Read the features list
featureNames <- read.table("./features.txt", header=F, as.is=T)
# Making the feature names nicer (more descriptive and more R style)
nicerFeatureNames <- gsub("\\-","\\_",featureNames[,2])
nicerFeatureNames <- gsub("\\(\\)","",nicerFeatureNames)
selected <- grep('mean|std',nicerFeatureNames)
write(nicerFeatureNames[selected], file = "NicerFeatures.txt")

activityLabels <- read.table("./activity_labels.txt", header=F)

trainDir <-"./train"
testDir <- "./test"
trainFiles <- list.files(trainDir, pattern="*.txt",full.names=T)
testFiles <- list.files(testDir, pattern="*.txt",,full.names=T)

# DF <- data.frame()
# for f %in% trainFiles {
#     col <- read.table(f,header=F)
#     DF <- rbind(DF, col)
# }

# DF <- rbind(DF, dat)
# data <- ldply(c("df1", "df2"), function(dn) data.frame(Filename=dn, get(dn)))

# Reading the data for the training group
subjects <- read.table(trainFiles[1],header=F,col.names="Subject")
X <- read.table(trainFiles[2], header=F, colClasses="numeric", col.names=nicerFeatureNames) %>%
    select(contains("mean"),contains("std"))
Y <- read.table(trainFiles[3],header=F,col.names="Activity")
Y <- mutate(Y,group="training")  # Adding indication for "training" group
trainDF <- data.frame(subjects,Y,X)

# Reading the data for the test group
subjects <- read.table(testFiles[1],header=F,col.names="Subject")
X <- read.table(testFiles[2], header=F, colClasses="numeric", col.names=nicerFeatureNames) %>%
    select(contains("mean"),contains("std"))
Y <- read.table(testFiles[3],header=F,col.names="Activity")
Y <- mutate(Y,group="test")  # Adding indication for "test" group
testDF <- data.frame(subjects,Y,X)

# Cleaning memory from redundent data
rm("X","Y")

# Combining the data sets ("on top" of each other)
DF <-bind_rows(trainDF,testDF)

# Cleaning memory from redundent data
rm("testDF","trainDF")

DF$Activity <- factor(DF$Activity,levels=1:6,labels=activityLabels[,2])
# DF$Subject <- factor(DF$Subject)

# Transforming the data to "tabulated data frame" 
# DF <- tbl_df(DF)
# aggregate(x=DF,by=Activity, FUN="mean", simplify = TRUE)
# summarize(group_by(DF, Subject, Activity),mean(tBodyAcc_mean_X))

# tidiedDF <- dcast(DF, Subject, mean)