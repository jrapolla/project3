---
title: "Code Book"
author: "Elena Chernousova"
date: "Sunday, May 24, 2015"
output: html_document
---

## Overview

Script downloads and cleans up raw data collected as output of experiments with   Samsung Galaxy S smartphone. 

## Source dataset

Following file https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip contains files:

* 'README.txt'
* 'features_info.txt': Shows information about the variables used on the feature vector.
* 'features.txt': List of all features.
* 'activity_labels.txt': Links the class labels with their activity name.
* 'train/X_train.txt': Training set.
* 'train/y_train.txt': Training labels.
* 'test/X_test.txt': Test set.
* 'test/y_test.txt': Test labels.

The data includes train and test data. Their descriptions are equivalent. 

* 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
* 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 
* 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 
* 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

## Cleaning and getting data  

Script 'run_analysis.R':

0. Downloads file and set folder structure.   
1. Merges files from "train"" and "test" to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

See README.md for steps and details.

## Result

All files related would be stored and unpacked in 'project3'. Final result is stored in  file 'result.txt', directory 'result'.

Result dataset contains following columns:

Column Number | Description | Data Type
--------------| ----------- | ---------
1 | Activity perfomed by subject | String
2 | Subject ID (Identifier of person who perfomed activity) | Number
3:68 | Mean for each variable (feature) of source data per subject/activity filtred by type (only standard deviations and means left) | Number 
