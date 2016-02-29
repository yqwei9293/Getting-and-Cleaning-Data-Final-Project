Getting and Cleaning Data Course Project
========================================

Instructions for project The purpose of this project is to demonstrate
your ability to collect, work with, and clean a data set. The goal is to
prepare tidy data that can be used for later analysis. You will be
graded by your peers on a series of yes/no questions related to the
project. You will be required to submit: 1) a tidy data set as described
below, 2) a link to a Github repository with your script for performing
the analysis, and 3) a code book that describes the variables, the data,
and any transformations or work that you performed to clean up the data
called CodeBook.md. You should also include a README.md in the repo with
your scripts. This repo explains how all of the scripts work and how
they are connected.

One of the most exciting areas in all of data science right now is
wearable computing - see for example this article . Companies like
Fitbit, Nike, and Jawbone Up are racing to develop the most advanced
algorithms to attract new users. The data linked to from the course
website represent data collected from the accelerometers from the
Samsung Galaxy S smartphone. A full description is available at the site
where the data was obtained:

<http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>

Here are the data for the project:

<https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>

You should create one R script called run\_analysis.R that does the
following.

-   Merges the training and the test sets to create one data set.
-   Extracts only the measurements on the mean and standard deviation
    for each measurement.
-   Uses descriptive activity names to name the activities in the data
    set
-   Appropriately labels the data set with descriptive variable names.
-   From the data set in step 4, creates a second, independent tidy data
    set with the average of each variable for each activity and
    each subject.

Description of the data
-----------------------

The features selected for this database come from the accelerometer and
gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain
signals (prefix ‘t’ to denote time) were captured at a constant rate of
50 Hz. and the acceleration signal was then separated into body and
gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) – both
using a low pass Butterworth filter.

The body linear acceleration and angular velocity were derived in time
to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also
the magnitude of these three-dimensional signals were calculated using
the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag,
tBodyGyroMag, tBodyGyroJerkMag).

A Fast Fourier Transform (FFT) was applied to some of these signals
producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ,
fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the ‘f’ to
indicate frequency domain signals).

### Description of abbreviations of measurements

leading t or f is based on time or frequency measurements. Body =
related to body movement. Gravity = acceleration of gravity Acc =
accelerometer measurement Gyro = gyroscopic measurements Jerk = sudden
movement acceleration Mag = magnitude of movement mean and SD are
calculated for each subject for each activity for each mean and SD
measurements. The units given are g’s for the accelerometer and rad/sec
for the gyro and g/sec and rad/sec/sec for the corresponding jerks.

These signals were used to estimate variables of the feature vector for
each pattern: ‘-XYZ’ is used to denote 3-axial signals in the X, Y and Z
directions. They total 33 measurements including the 3 dimensions - the
X,Y, and Z axes.

tBodyAcc-XYZ tGravityAcc-XYZ tBodyAccJerk-XYZ tBodyGyro-XYZ
tBodyGyroJerk-XYZ tBodyAccMag tGravityAccMag tBodyAccJerkMag
tBodyGyroMag tBodyGyroJerkMag fBodyAcc-XYZ fBodyAccJerk-XYZ
fBodyGyro-XYZ fBodyAccMag fBodyAccJerkMag fBodyGyroMag fBodyGyroJerkMag
\#\#\#The set of variables that were estimated from these signals are:

mean(): Mean value std(): Standard deviation

Data Set Information
--------------------

The experiments have been carried out with a group of 30 volunteers
within an age bracket of 19-48 years. Each person performed six
activities (WALKING, WALKING\_UPSTAIRS, WALKING\_DOWNSTAIRS, SITTING,
STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the
waist. Using its embedded accelerometer and gyroscope, we captured
3-axial linear acceleration and 3-axial angular velocity at a constant
rate of 50Hz. The experiments have been video-recorded to label the data
manually. The obtained dataset has been randomly partitioned into two
sets, where 70% of the volunteers was selected for generating the
training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by
applying noise filters and then sampled in fixed-width sliding windows.
From each window, a vector of features was obtained by calculating
variables from the time and frequency domain.

Download Data
-------------

    #download dataset
    if(!file.exists("/Users/Yvette/Desktop/Coursera/Data")){dir.create("/Users/Yvette/Desktop/Coursera/Data")}
    fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(fileUrl, destfile = "/Users/Yvette/Desktop/Coursera/Data/Dataset.zip", method = "curl")

    #unzip data file
    unzip(zipfile = "/Users/Yvette/Desktop/Coursera/Data/Dataset.zip", exdir = "/Users/Yvette/Desktop/Coursera/Data")

    #get list of the files
    path <- file.path("/Users/Yvette/Desktop/Coursera/Data", "UCI HAR Dataset")
    files <- list.files(path, recursive = TRUE)
    files

    ##  [1] "activity_labels.txt"                         
    ##  [2] "features_info.txt"                           
    ##  [3] "features.txt"                                
    ##  [4] "README.txt"                                  
    ##  [5] "test/Inertial Signals/body_acc_x_test.txt"   
    ##  [6] "test/Inertial Signals/body_acc_y_test.txt"   
    ##  [7] "test/Inertial Signals/body_acc_z_test.txt"   
    ##  [8] "test/Inertial Signals/body_gyro_x_test.txt"  
    ##  [9] "test/Inertial Signals/body_gyro_y_test.txt"  
    ## [10] "test/Inertial Signals/body_gyro_z_test.txt"  
    ## [11] "test/Inertial Signals/total_acc_x_test.txt"  
    ## [12] "test/Inertial Signals/total_acc_y_test.txt"  
    ## [13] "test/Inertial Signals/total_acc_z_test.txt"  
    ## [14] "test/subject_test.txt"                       
    ## [15] "test/X_test.txt"                             
    ## [16] "test/y_test.txt"                             
    ## [17] "train/Inertial Signals/body_acc_x_train.txt" 
    ## [18] "train/Inertial Signals/body_acc_y_train.txt" 
    ## [19] "train/Inertial Signals/body_acc_z_train.txt" 
    ## [20] "train/Inertial Signals/body_gyro_x_train.txt"
    ## [21] "train/Inertial Signals/body_gyro_y_train.txt"
    ## [22] "train/Inertial Signals/body_gyro_z_train.txt"
    ## [23] "train/Inertial Signals/total_acc_x_train.txt"
    ## [24] "train/Inertial Signals/total_acc_y_train.txt"
    ## [25] "train/Inertial Signals/total_acc_z_train.txt"
    ## [26] "train/subject_train.txt"                     
    ## [27] "train/X_train.txt"                           
    ## [28] "train/y_train.txt"

### read datasets from files into variables

    ##activity variable
    ActivityTest <- read.table(file.path(path, "test", "Y_test.txt"), header = FALSE)
    ActivityTrain <- read.table(file.path(path, "train", "Y_train.txt"), header = FALSE)

    ##subject variable
    SubjectTest <- read.table(file.path(path, "test", "subject_test.txt"), header = FALSE)
    SubjectTrain <- read.table(file.path(path, "train", "subject_train.txt"), header = FALSE)

    ##feature variable
    FeatureTest <- read.table(file.path(path, "test", "X_test.txt"), header = FALSE)
    FeatureTrain <- read.table(file.path(path, "train", "X_train.txt"), header = FALSE)

### merge datasets into each variable

    dataActivity <- rbind(ActivityTrain, ActivityTest)
    dataSubject <- rbind(SubjectTrain, SubjectTest)
    dataFeature <- rbind(FeatureTrain, FeatureTest)

### set names

    names(dataActivity) <- c("Activity")
    names(dataSubject) <- c("Subject")
    dataFeatureNames <- read.table(file.path(path, "features.txt"), header = FALSE)
    names(dataFeature) <- dataFeatureNames$V2

### merge all datasets

    dataCombine <- cbind(dataActivity, dataSubject)
    Dta <- cbind(dataFeature, dataCombine)

Extracts only the measurements on the mean and standard deviation for each measurement
--------------------------------------------------------------------------------------

    subdataFeatureNames <- dataFeatureNames$V2[grep("mean\\(\\)|std\\(\\)", dataFeatureNames$V2)]
    selectNames <- c(as.character(subdataFeatureNames), "Subject", "Activity")
    Data <- subset(Dta, select = selectNames)

Uses descriptive activity names to name the activities in the data set
----------------------------------------------------------------------

    activityLabel <- read.table(file.path(path, "activity_labels.txt"), header = FALSE)
    head(Data$Acticity, 30)

    ## NULL

    Data$Activity <- factor(Data$Activity)
    Data$Activity <- factor(Data$Activity, labels = as.character(activityLabel$V2))
    head(Data$Activity, 30)

    ##  [1] STANDING STANDING STANDING STANDING STANDING STANDING STANDING
    ##  [8] STANDING STANDING STANDING STANDING STANDING STANDING STANDING
    ## [15] STANDING STANDING STANDING STANDING STANDING STANDING STANDING
    ## [22] STANDING STANDING STANDING STANDING STANDING STANDING SITTING 
    ## [29] SITTING  SITTING 
    ## 6 Levels: WALKING WALKING_UPSTAIRS WALKING_DOWNSTAIRS ... LAYING

Appropriately labels the data set with descriptive variable names
-----------------------------------------------------------------

    names(Data)<-gsub("^t", "time", names(Data))
    names(Data)<-gsub("^f", "frequency", names(Data))
    names(Data)<-gsub("Acc", "Accelerometer", names(Data))
    names(Data)<-gsub("Gyro", "Gyroscope", names(Data))
    names(Data)<-gsub("Mag", "Magnitude", names(Data))
    names(Data)<-gsub("BodyBody", "Body", names(Data))

Create independent tidy data set with the average of each variable for each activity and each subject
-----------------------------------------------------------------------------------------------------

    library(plyr)
    Data2 <- aggregate(.~Subject + Activity, Data, mean)
    Data2 <- Data2[order(Data2$Subject, Data2$Activity), ]
    write.table(Data2, file = "tidydata.txt", row.name = FALSE)
