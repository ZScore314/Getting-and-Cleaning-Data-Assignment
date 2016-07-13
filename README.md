# Getting-and-Cleaning-Data-Assignment

## This is the repository for the peer graded assignment of the Getting and Cleaning Data Coursera course. 

Companies like FitBit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked are collected from the accelerometers from the Samsung Galaxy S smartphone.

A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The data is available at:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The aim of the project is to clean and extract usable data from the above zip file. 

In this project, you find:

* run_analysis.R : the R-code run on the data set

* Tidy.txt : the clean data extracted from the original data using run_analysis.R

* CodeBook.md : the CodeBook reference to the variables in Tidy.txt

* README.md : the analysis of the code in run_analysis.R


The R script, run_analysis.R, does the following:

* Downloads and unzips the data
* Loads and merges the training and test datasets
* Loads the activity and feature info
* Appropriately labels the dataset with descriptive variable names
* Creates a separate tidy dataset that consists of the mean and standard deviation of each variable for each subject and activity
* The final dataset is exported to a new file called tidy.txt

## Please see R script file for additional details on the analysis 

