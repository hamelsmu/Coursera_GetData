#Notes#
"""
The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. 
The goal is to prepare tidy data that can be used for later analysis. 
You will be graded by your peers on a series of yes/no questions related to the project. 
You will be required to submit: 
1) a tidy data set as described below, 
2) a link to a Github repository with your script for performing the analysis, and 
3) a code book that describes the variables, the data, and any transformations or work 
that you performed to clean up the data called CodeBook.md. 

You should also include a README.md in the repo with your scripts. 
This repo explains how all of the scripts work and how they are connected.  

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . 
Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. 
The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S 
smartphone. A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 


You should create one R script called run_analysis.R that does the following. 
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
"""

####Setup Environment#####

#cleanup
rm(list=ls(all=TRUE))

#setup working directory
setwd('/Users/hhusain/Git_Repositories/Coursera_GetData/UCI HAR Dataset')

#read in files
X_test = read.table('./test/X_test.txt')
y_test = read.table('./test/y_test.txt')
subject_test = read.table('./test/subject_test.txt')
X_train = read.table('./train/X_train.txt')
y_train = read.table('./train/y_train.txt')
subject_train = read.table('./train/subject_train.txt')
labels = read.table('activity_labels.txt')
features = read.table('features.txt')

#set variable names 
names(X_test) = features$V2
names(X_train) = features$V2
names(y_test) = c('y_activity_label')
names(y_train) = c('y_activity_label')
names(labels) = c('y_activity_label', 'y_Activity_Desc')
names(subject_test) = c('subject')
names(subject_train) = c('subject')


#get variable names that only have mean and standard deviation
features_to_keep_index = grep('mean()|std()', features$V2)

#subset only mean and std deviation columns out
TEST_X = X_test[, features_to_keep_index]
TRAIN_X = X_train[, features_to_keep_index]

#Merge datasets Together

        #merge x and y using cbind
        #Added Two Columns To mark which rows are train and which ones are test
        merged_test = cbind(test = 1, train = 0, TEST_X, y_test, subject_test)
        merged_train = cbind(test = 0, train = 1, TRAIN_X, y_train, subject_train)
      
        #merge train and test sets together
        merged_temp = rbind(merged_test, merged_train)

#Label The Activities (y) with appropriate description
#Replace the Numbers 1-6 With Description
merged_final = merge(merged_temp, labels)

########################################
##Create second, independent tidy data set 
##with the average of each variable for each activity 
##and each subject. 
######################################

#Merge Original Dataset together with all columns/rows
tidy_test = cbind(X_test, y_test, subject_test)
tidy_train = cbind(X_train, y_train, subject_train)
tidy_temp = rbind(tidy_test, tidy_train)

#Join on Activity Labels
tidy_merged = merge(tidy_temp, labels)

#Summarize Data To Compute Mean for each column
tidy_summary = aggregate(.~subject+y_Activity_Desc, tidy_merged[, 2:564], mean)

#Write Out To File
write.csv(tidy_summary, 'tidy_dataset.csv')

