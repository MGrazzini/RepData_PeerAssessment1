## Loading libraries
library(plyr)

## Reading files for activities and features
activity_labels <- read.table("~/UCI HAR Dataset/activity_labels.txt")
features <- read.table("~/UCI HAR Dataset/features.txt")

## Reading files in test folder
test_subject <- read.table("~/UCI HAR Dataset/test/subject_test.txt")
test_activity <- read.table("~/UCI HAR Dataset/test/y_test.txt")
test_measurements <- read.table("~/UCI HAR Dataset/test/X_test.txt", colClasses = "numeric")

## Reading files in training folder
training_subject <- read.table("~/UCI HAR Dataset/train/subject_train.txt")
training_activity <- read.table("~/UCI HAR Dataset/train/y_train.txt")
training_measurements <- read.table("~/UCI HAR Dataset/train/X_train.txt", colClasses = "numeric")

## Adding descriptive column names
test_global_dataset <- cbind(test_subject, test_activity, test_measurements)
names(test_global_dataset) <- c("Subject", "Activity", as.character(features$V2))

training_global_dataset <- cbind(training_subject, training_activity, training_measurements)
names(training_global_dataset) <- c("Subject", "Activity", as.character(features$V2))

## Merging datasets (1)
merged_raw_dataset <- rbind(test_global_dataset, training_global_dataset)

## Extracting only columns concerning mean or std. dev. of variables (2)
j <- c(1,2,grep("mean|std", names(merged_raw_dataset)))
merged_selected_dataset <- merged_raw_dataset[,j]

## Changing values in activity column to descriptive (3)
merged_selected_dataset$Activity <- activity_labels[merged_selected_dataset$Activity, 2]

## Improving readibility and manageability of column names (4)
for (i in 3:81) {
  if (strtrim(names(merged_selected_dataset)[i], 1) == "t") {
    names(merged_selected_dataset)[i] <- sub("t", "Time.", names(merged_selected_dataset)[i])
  }
  else {  
    names(merged_selected_dataset)[i] <- sub("f", "Freq.", names(merged_selected_dataset)[i]) 
  }
  names(merged_selected_dataset)[i] <- gsub("-mean\\(\\)-", ".Mean.", names(merged_selected_dataset)[i])
  names(merged_selected_dataset)[i] <- gsub("-std\\(\\)-", ".Std.", names(merged_selected_dataset)[i])
  names(merged_selected_dataset)[i] <- gsub("-meanFreq\\(\\)-", ".MeanFreq.", names(merged_selected_dataset)[i])
  names(merged_selected_dataset)[i] <- gsub("-mean\\(\\)", ".Mean", names(merged_selected_dataset)[i])
  names(merged_selected_dataset)[i] <- gsub("-std\\(\\)", ".Std", names(merged_selected_dataset)[i])
  names(merged_selected_dataset)[i] <- gsub("-meanFreq\\(\\)", ".MeanFreq", names(merged_selected_dataset)[i])
  }

## Tidying dataset (5)
tidy_data <- ddply(merged_selected_dataset, .(Subject, Activity), function(x) {colMeans(x[,3:81])})

## Writing output file
write.table(tidy_data, file = "tidy_dataset.txt", row.names=FALSE)