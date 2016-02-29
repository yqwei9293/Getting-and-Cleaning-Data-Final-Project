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

#read datasets from files into variables
##activity variable
ActivityTest <- read.table(file.path(path, "test", "Y_test.txt"), header = FALSE)
ActivityTrain <- read.table(file.path(path, "train", "Y_train.txt"), header = FALSE)

##subject variable
SubjectTest <- read.table(file.path(path, "test", "subject_test.txt"), header = FALSE)
SubjectTrain <- read.table(file.path(path, "train", "subject_train.txt"), header = FALSE)

##feature variable
FeatureTest <- read.table(file.path(path, "test", "X_test.txt"), header = FALSE)
FeatureTrain <- read.table(file.path(path, "train", "X_train.txt"), header = FALSE)

##merge data into each variable
dataActivity <- rbind(ActivityTrain, ActivityTest)
dataSubject <- rbind(SubjectTrain, SubjectTest)
dataFeature <- rbind(FeatureTrain, FeatureTest)

##set names
names(dataActivity) <- c("Activity")
names(dataSubject) <- c("Subject")
dataFeatureNames <- read.table(file.path(path, "features.txt"), header = FALSE)
names(dataFeature) <- dataFeatureNames$V2

##merge all datasets
dataCombine <- cbind(dataActivity, dataSubject)
Dta <- cbind(dataFeature, dataCombine)


#Extracts only the measurements on the mean and standard deviation for each measurement
subdataFeatureNames <- dataFeatureNames$V2[grep("mean\\(\\)|std\\(\\)", dataFeatureNames$V2)]
selectNames <- c(as.character(subdataFeatureNames), "Subject", "Activity")
Data <- subset(Dta, select = selectNames)


#Uses descriptive activity names to name the activities in the data set
activityLabel <- read.table(file.path(path, "activity_labels.txt"), header = FALSE)
head(Data$Acticity, 30)

Data$Activity <- factor(Data$Activity)
Data$Activity <- factor(Data$Activity, labels = as.character(activityLabel$V2))
head(Data$Activity, 30)


#Appropriately labels the data set with descriptive variable names
names(Data)<-gsub("^t", "time", names(Data))
names(Data)<-gsub("^f", "frequency", names(Data))
names(Data)<-gsub("Acc", "Accelerometer", names(Data))
names(Data)<-gsub("Gyro", "Gyroscope", names(Data))
names(Data)<-gsub("Mag", "Magnitude", names(Data))
names(Data)<-gsub("BodyBody", "Body", names(Data))


#Create independent tidy data set with the average of each variable for each activity and each subject
library(plyr)
Data2 <- aggregate(.~Subject + Activity, Data, mean)
Data2 <- Data2[order(Data2$Subject, Data2$Activity), ]
write.table(Data2, file = "tidydata.txt", row.name = FALSE)












