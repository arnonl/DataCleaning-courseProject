# Data Cleaning - Course Project
This repository was created as part of the Data Cleaning course to manage the course project materials 
```
Thank you for reading this file!	
Here you will find explanations about the way the author	 
chose to manipulate the data and to reorganize it.
```
The R code that make the data tidy is called:  **run_analysis.R**	
To run the script, in the Rstudio command line type:	
```
> source('file_path/run_analysis.R')
> finalDF()
```

The code reads from the directory "UCI HAR Dataset" which is located under your working directory [ check with: `getwd()` ]
The code reads the following files (under "UCI HAR Dataset"):

**activity_labels.txt**		
contains labels for the categorial variable "Activity"

**features.txt**	
contains the measurements variable names 
(see further explanation on manipulations done on this file below)

**./test/subject_test.txt**		
contains a list of the subject numbers under the group "test" 

**./test/X_test.txt**	
contains all the numerical measurements, see further explanation below

**./test/y_test.txt**		
contains a list of numbers that represent the activity level 

**./train/subject_train.txt**	
contains a list of the subject numbers under the group "train"

**./train/X_train.txt**			
contains all the numerical measurements, see further explanation below

**./train/y_train.txt** 		
contains a list of numbers that represent the activity level
---
The analysed data (the output) stored in this file:
**finalTidyData.txt**

To view the final table generated by this code please type:
```
data <- read.table(file_path, header = TRUE) 
View(data)   # V capitalized! 
```
__Further explanation on the manipulations done to the variable names at "features.txt":__

Whether or not the author of this file aimed for this list to be the 
variable names, at least in R, some of them are not legal variable names. Special characters 
like `,` `-` and `()` are not accepted. Therefore I changed the names on this list using the "gsub"
command, using regular expressions. I changed any `-` to `_` and removed any `()`. 
Among the 561 variable names, only 86 were selected, containing the string "mean" or "std" within them.
(I chose to ignore the variables with capital 'm' , i.e. "Mean". 

__Further explanation on the meaning of the data stored in "X_train.txt" and "X_text.txt":__

The features selected for this database come from the accelerometer and gyroscope 3-axial
raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time)
were captured at a constant rate of 50 Hz. Then they were filtered using a median filter
and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise.
Similarly, the acceleration signal was then separated into body and gravity acceleration
signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with
a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time
to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of
these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag,
tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing
fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag,
fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.