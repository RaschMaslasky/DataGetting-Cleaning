# ===================================================
# Getting and Cleaning Data Course Project
# ---------------------------------------------------
# Download and unzip the dataset which obtained from 
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
# 
# by Mirzarashid Abbasov
# --------------------------------------------------

# set working directory
setwd("/Users/mirzarashid.abbasov/repos/cleanind_data/week4/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset")

# clean up workspance
rm(list = ls())

# ==================================================
# 1. Merges the training and the test sets 
#     
# ==================================================

# read common data from files
features     = read.table('./features.txt',header=FALSE); 
activityType = read.table('./activity_labels.txt',header=FALSE);
colnames(activityType) = c('activityId','activityType');

# read train data from files
subjectTrain = read.table('./train/subject_train.txt',header=FALSE);
xTrain       = read.table('./train/x_train.txt',header=FALSE);
yTrain = read.table('./train/y_train.txt',header=FALSE);

# assigin column names
colnames(subjectTrain)  = "subjectId";
colnames(xTrain)        = features[,2]; 
colnames(yTrain) = "activityId";

# Create the final training data set
trainingData = cbind(yTrain,subjectTrain,xTrain);


# read test data from files
subjectTest = read.table('./test/subject_test.txt',header=FALSE);
xTest       = read.table('./test/x_test.txt',header=FALSE);
yTest = read.table('./test/y_test.txt',header=FALSE);

# assigin column names
colnames(subjectTest) = "subjectId";
colnames(xTest)       = features[,2]; 
colnames(yTest) = "activityId";

# Create the final test data set
testData = cbind(yTest,subjectTest,xTest);

# Combine training and test data sets 
finalData = rbind(trainingData,testData);

# Create a vector for the column names 
colNames = colnames(finalData); 


# ==================================================
# 2. Extract only the measurements on the mean and 
#    standard deviation for each measurement. 
# ==================================================

# Create a logicalVector that contains TRUE values for the ID, mean() & stddev() columns and FALSE for others
logicalVector = (grepl("activity..",colNames) | 
                 grepl("subject..",colNames) | 
                 grepl("-mean..",colNames) & !grepl("-meanFreq..",colNames) & !grepl("mean..-",colNames) | 
                 grepl("-std..",colNames) & !grepl("-std()..-",colNames));

# Subset finalData table based on the logical vector
finalData = finalData[logicalVector==TRUE];


# ==================================================
# 3. Use descriptive activity names to name the 
#    activities in the data set
# ==================================================

# Merge the finalData set with the acitivityType table to include descriptive activity names
finalData = merge(finalData,activityType,by='activityId',all.x=TRUE);

# Updating the colNames vector to include the new column names after merge
colNames  = colnames(finalData); 


# ==================================================
# 4. Appropriately label the data set with descriptive 
#    activity names. 
# ==================================================

# Cleaning up the variable names
for (i in 1:length(colNames)) 
{
  colNames[i] = gsub("JerkMag","JerkMagnitude",colNames[i])
  colNames[i] = gsub("^(f)","freq",colNames[i])  
  colNames[i] = gsub("GyroMag","GyroMagnitude",colNames[i])
  colNames[i] = gsub("[Gg]yro","Gyro",colNames[i])
  colNames[i] = gsub("AccMag","AccMagnitude",colNames[i])
  colNames[i] = gsub("\\()","",colNames[i])
  colNames[i] = gsub("-std$","StdDev",colNames[i])
  colNames[i] = gsub("-mean","Mean",colNames[i])
  colNames[i] = gsub("^(t)","time",colNames[i])
  colNames[i] = gsub("([Gg]ravity)","Gravity",colNames[i])
  colNames[i] = gsub("([Bb]ody[Bb]ody|[Bb]ody)","Body",colNames[i])
  colNames[i] = gsub("([Bb]odyaccjerkmag)","BodyAccJerkMagnitude",colNames[i])
};

# Reassigning the new descriptive column names to the finalData set
colnames(finalData) = colNames;


# ==================================================
# 5. Create a second, independent tidy data set with 
# the average of each variable for each activity and 
# each subject. 
# ==================================================

# Create a new table, finalDataNoActivityType
finalDataNoActivityType  = finalData[,names(finalData) != 'activityType'];

# Summarizing the finalDataNoActivityType table
tidyData    = aggregate(finalDataNoActivityType[,names(finalDataNoActivityType) != c('activityId','subjectId')],
                        by=list(activityId=finalDataNoActivityType$activityId,
                        subjectId = finalDataNoActivityType$subjectId),
                        mean);

# Merging the tidyData
tidyData    = merge(tidyData,activityType,by='activityId',all.x=TRUE);

# Export the tidyData set 
write.table(tidyData, './tidyData.txt',row.names=TRUE,sep='\t');



