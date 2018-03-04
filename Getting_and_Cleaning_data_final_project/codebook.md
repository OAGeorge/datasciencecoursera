---
title: "UCI Study Tidy data Codebook"
author: "Ophelia George"
date: "March 3, 2018"
output:
  pdf_document: default
  html_document:
    keep_md: yes
---

## Project Description
This project attempts to recognize human activity such as walking, sitting etc through the use of the Samsung Galaxy S II's integrated accelerometer and gyroscope. The experimented on a set of 30 volunteers aged 19-48 performing various activities while carrying the phone on their waist. 

##Study design and data processing

###Collection of the raw data
The data within the database come from the raw 3-axial signal of the phone's accelerometer and gyroscope which provides the raw linear acceleration and the angular velocity respectively. These time domain signals (denoted by the prefix 't' in the data headers) were collected at a constant rate for 50 Hz. The signals were then treated with low-pass Butterworth filter to remove the noise and then re-filtered with a second Butterworth filter with a corner frequency 0.3 Hz to separate the signal into a body and gravitational acceleration signals.

Subsequent derivation of the body linear acceleration and angular velocity produced the Jerk Signals (BodyACCJerk and bodyGyroJerk respectively).A Fast Fourier Transform of the some of the data was then conducted to produce the corresponding frequency domain signals (this is denoted by an 'f' prefix in the variable names).

The raw data comprises 2 separate sets of data - a training set which comprises of 70% of the experiment results and a test set which is made up of the remaining 30%. There are a total of 561 measured parameters in the dataset which include the mean and standard deviations of each measurement as well as a number of parameters such as the max, median, signal magnitude area, etc.

##Creating the tidy datafile

###Guide to create the tidy data file
To generate the tidy data file, the following steps were performed.
- The raw data was downloaded from the url https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip and unzipped using R. 
- The training and test data sets were then imported into R and combined into a single data frame. 
- Additionally, the activity description file and the files y_test.txt and y_train.txt where imported into R. The "y*" files provides a code for the activity performed by the volunteers which can be decoded using the description in the activity file.
- The data frame was then cleaned and an activity description variable appended to the final result

###Cleaning of the data
The cleaning of the data was conducted through the use of the Run_analysis.R script which downloads the data from the url and then unzips the files. The script then reads in the data files needed from the various sub-folders and creates a merged data frame that contains both the training and test data sets. Headers are added to the new data frame and it is then processed so that only columns corresponding to the mean and standard deviations of each measurements are kept. Finally, a column is added to the data frame which provides a description for the activity that each row corresponds to. This data set was saved to the file UCI_cleaned_data.txt

A second tidy data set was created from the tidy data set described above by grouping each variable based on the activity and the volunteer in the experiment. The mean for each variable was calculated for each group and the resulting output was saved to the file UCI_tidy_mean_data.txt

##Description of the variables in the UCI_cleaned_data.txt file
The file contains a total of 10299 rows and 81 variables. The data comprises of mean and standard deviations of the measured variables which have been normalized and are bound within [-1,1]. Variable names preceeded by 't' represent time domain signals while those preceeded by an 'f' represents frequency domain signals.

: Table of Variables within the data file
|Variable Name|Description|Unit|
|:------------|:---------|:--:|
|tBodyAcc-XYZ |Mean and std of body acceleration in XYZ directions|g|
|tGravityAcc-XYZ| Mean and std of gravitational acceleration in XYZ directions| g|
|tBodyAccJerk-XYZ| Mean and std of body acceleration Jerk in XYZ directions| g|
|tBodyGyro-XYZ| Mean and std of angular velocity in XYZ directions| radians/second|
|tBodyGyroJerk-XYZ| Mean and std of angular velocity Jerk in XYZ directions| radians/second|
|tBodyAccMag| Mean and std of body acceleration magnitude| g|
|tGravityAccMag| Mean and std of gravitational acceleration magnitude| g|
|tBodyAccJerkMag|Mean and std of body acceleration Jerk magnitude|g|
|tBodyGyroMag|Mean and std of angular velocity magnitude|radians/second|
|tBodyGyroJerkMag| Mean and std of angular velocity Jerk Magnitude| radians/second|
|fBodyAccJerk-XYZ| Frequency domain mean and std of body acceleration Jerk in XYZ directions| Hz|
|fBodyGyro-XYZ| Frequency domain mean and std of angular velocity in XYZ directions| Hz|
|fBodyAccMag|Mean and std of body acceleration magnitude in frequency domain| Hz|
fBodyAccJerkMag|Mean and std of body acceleration Jerk magnitude in frequency domain| Hz|
|fBodyGyroMag|Mean and std of angular velocity magnitude in frequency domain| Hz|
|fBodyGyroJerkMag|Mean and std of angular velocity Jerk magnitude in frequency domain| Hz|
|activity| Description the activity performed by each subject|NA|

##Sources
The data used for this codebook came from [1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012. 

The file was downloaded from the URL https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 