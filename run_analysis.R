
library("reshape2")
library("data.table")


if(!file.exists("UCIdata.zip")){
        download.file("http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip","UCI HAR Dataset", mode = "wb") 
}

if(!file.exists("UCI HAR Dataset")){
	unzip("UCIdata.zip", files = NULL, exdir=".")
}


## Read Data
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))

x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")



subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")



# 1. Merge
X <- rbind(x_train, x_test)
Y <- rbind(y_train, y_test)
Subject <- rbind(subject_train, subject_test)
Result_Data <- cbind(Subject, Y, X)



# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
Analysis_Data <- Result_Data %>% select(subject, code, contains("mean"), contains("std"))



# 3. Uses descriptive activity names to name the activities in the data set
Analysis_Data$code <- activities[Analysis_Data$code, 2]


# 4. Appropriately labels the data set with descriptive activity names.
names(Analysis_Data)[2] = "activity"
names(Analysis_Data)<-gsub("Acc", "Accelerometer", names(Analysis_Data))
names(Analysis_Data)<-gsub("Gyro", "Gyroscope", names(Analysis_Data))
names(Analysis_Data)<-gsub("BodyBody", "Body", names(Analysis_Data))
names(Analysis_Data)<-gsub("Mag", "Magnitude", names(Analysis_Data))
names(Analysis_Data)<-gsub("^t", "Time", names(Analysis_Data))
names(Analysis_Data)<-gsub("^f", "Frequency", names(Analysis_Data))
names(Analysis_Data)<-gsub("tBody", "TimeBody", names(Analysis_Data))
names(Analysis_Data)<-gsub("-mean()", "Mean", names(Analysis_Data), ignore.case = TRUE)
names(Analysis_Data)<-gsub("-std()", "STD", names(Analysis_Data), ignore.case = TRUE)
names(Analysis_Data)<-gsub("-freq()", "Frequency", names(Analysis_Data), ignore.case = TRUE)
names(Analysis_Data)<-gsub("angle", "Angle", names(Analysis_Data))
names(Analysis_Data)<-gsub("gravity", "Gravity", names(Analysis_Data))




# 5. From the data set in step 4, creates a second, 
FinalData <- Analysis_Data %>%
  group_by(subject, activity) %>%
  summarise_all(funs(mean))
write.table(FinalData, "data.txt", row.name=FALSE)

