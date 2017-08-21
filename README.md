### Getting and Cleaning Data Course Project

Repo of the project for the Johns Hopkins university Getting and Cleaning Data course.

> by Mirzarashid Abbasov


#### Overview
This project provides the End users with a tidy data set that can be used for later analysis and all necessary information which made from source. 

#### Source Data
The analyzed data set is data collected from the accelerometers from a  mobile device, [a raw data can be found here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip). A description the used data can be found the [UCI Machine Learning Repository](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

#### Project deliverables
> run_analysis.R

R script that does following:

	1. Merges the training and the test sets to create one data set.
	
	2. Extracts only the measurements on the mean and standard deviation for each measurement. 
	
	3. Uses descriptive activity names to name the activities in the data set
	
	4. Appropriately labels the data set with descriptive variable names. 
	
	5. From the data set in step 4, creates a second, independent tidy data set with the average 
	of each variable for each activity and each subject.

> CodeBook.MD 

a code book that describes the variables, the data, and any transformations or work that performed to clean up the source data.

> tidyData.txt

the project deliverable which consiste a tidy data set.

