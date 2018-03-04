##This script downloads a data set generated from testing subject activity using a Samsung smartphone. It then combines the test and training data sets into a single data frame and returns a set of data corresponding only to the mean and the standard deviation of each of the variables measured. In the second portion of the script, a second data set is generated from the tidy dataset which contains the mean of each variable measured grouped by the activity and subject

#load dplyr library for use in the question 5

library(dplyr)

#Check for the existence of a data directory in the current folder and create one if it does not exist

if(!file.exists("./data")) {
  dir.create("./data")
}

#Change to the data directory

setwd("./data")

#Download the data from the online source and unzip the file

data_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

data_file_path <- "./Fprojectfiles_Fuci_Har_Dataset.zip"

download.file(data_url, data_file_path )

unzip(data_file_path)


#initialize a data frame for storing the activity description
all_activity <- data.frame(V1=integer(),V2=character(),stringsAsFactors = FALSE)


#read the test data files into R
test_data <- read.table("UCI HAR Dataset/test/X_test.txt", header = FALSE, sep = "")

test_data_labels <- read.table("UCI HAR Dataset/test/y_test.txt")

activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", sep="",colClasses = c("integer","character"))

features <- read.table("UCI HAR Dataset/features.txt",colClasses = c("integer","character"))

subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", header = FALSE, sep = "")

subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", header = FALSE, sep = "")

#read the training data set into R
train_data <- read.table("UCI HAR Dataset/train/X_train.txt", header = FALSE, sep = "")

train_data_labels <- read.table("UCI HAR Dataset/train/y_train.txt")

#combine the training and test datasets and their labels.
ALL_raw_data <- rbind(train_data,test_data)
all_labels <- rbind(train_data_labels, test_data_labels)
all_subjects <- rbind(subject_train, subject_test)

#create the descriptive labels for the training &test data sets activity
for (n in 1:nrow(all_labels)) {
  
  all_activity[n,] <- activity_labels[all_labels[n,],]
  
}


#Rename the variables correctly
names(ALL_raw_data) <-features$V2


#extract only the columns that contain the mean and the standard deviation of every measurement
clean_data <- ALL_raw_data[,grep(".*mean|.*std",names(ALL_raw_data))]
clean_data$activity <- all_activity$V2


##Section 2 of the code creates a tidy dataset for the average of each variable grouped by subject and activity

Tidy_data_temp <- clean_data
Tidy_data_temp$subject <- all_subjects$V1

Tidy_data_final <- Tidy_data_temp %>%
  group_by(activity, subject) %>%
  summarise_all(mean) 

#clean up the temp variables
rm("activity_labels", "features", "subject_train", "subject_test", "test_data", "train_data", "test_data_labels", "train_data_labels")


#Option to display the final data set in the R-viewer
#View(Tidy_data_final)

#output the tidy data sets in a csv format for sharing
write.table(clean_data, file="UCI_cleaned_data.txt", sep = " ")
write.table(Tidy_data_final, file="UCI_tidy_mean_data.txt", sep = " ")
