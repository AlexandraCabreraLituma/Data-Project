Code Book
==========


## 1. Read Data

features <- features.txt : 561 rows, 2 columns
activities <- activity_labels.txt : 6 rows, 2 columns

x_test <- test/X_test.txt : 2947 rows, 561 columns
y_test <- test/y_test.txt : 2947 rows, 1 columns
subject_test <- test/subject_test.txt : 2947 rows, 1 column


x_train <- test/X_train.txt : 7352 rows, 561 columns
y_train <- test/y_train.txt : 7352 rows, 1 columns
subject_train <- test/subject_train.txt : 7352 rows, 1 column


## Transformation details
Merges the training and the test sets to create one data set.

Extracts only the measurements on the mean and standard deviation for each measurement. 

Uses descriptive activity names to name the activities in the data set

Appropriately labels the data set with descriptive variable names. 

From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.



## Appropriately labels the data set with descriptive variable names


code column in TidyData renamed into activities
All Acc in column’s name replaced by Accelerometer
All Gyro in column’s name replaced by Gyroscope
All BodyBody in column’s name replaced by Body
All Mag in column’s name replaced by Magnitude
All start with character f in column’s name replaced by Frequency
All start with character t in column’s name replaced by Time

