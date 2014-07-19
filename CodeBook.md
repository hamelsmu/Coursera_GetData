# Codebook: Getting & Cleaning Data

##This repository contains an R script called run_analysis.R that does the following:

1. Reads In Files From The UCI HAR Dataset
2. Attaches Column Headers To The Dataset
3. Subsets & Merges Data As Appropriate
4. Produces A separate tidy dataset that is a summary of the original dataset

##This is an explanation of all the variables in run_analysis.R
###For further explanation of the data see Coursera_GetData / UCI HAR Dataset / README.txt


####These variables contain the data used for this exercise:

*X_test: these are the independent variables (561 of them), and is a test set
*X_train: the same as X_test with 561 variables, but is the training set
*y_test: this is dependent variable, which has a number that corresponds to each activity, this relates to X_trin
*y_train: same as y_test, except relates to X_train
*subject_train: this is the subject associated with the training set
*subject_test: this is the subject associated with the test set
*labels: these "decode" the numeric variables contained in y_test and y_train into descriptions
*features: these are the column headers for the X_train and X_test dataset

*TEST_X: this contains a subset of X_test that relate to mean and standard deviation
*TRAIN_X: this contains a subset of X_train that relate to mean and standard deviation


#### The following are additional variables:
*merged_test: combine X_test, y_test, subject_test, and add two logical vectors to flag these rows as test or train
*merged_train: combine X_train, y_train, subject_train, and two logicial vectors to flag these rows as test or train
*merged_temp: combines merged_test and merged_train together
*merged_final: adds labels onto merged_temp so that we have descriptions

*tidy_...(test, train, temp): these variables are temporary variables that merge the test and training set together
*tidy_merged: this data contains all 561 features with both training, test, labels and subjects combined into one dataset
*tidy_summary: this summarizes the columns in tidy_merged by subject and activity.  The aggregate computed is mean.

