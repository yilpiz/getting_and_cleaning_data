# Tidy Dataset

This document explains steps taken to generate TidyDataset.txt.
There were discussion regarding whether code should be written as function or not. 
In my opinion it does not really matter and function style is more
user friendly for debugging purpose thus I used function style.

To generate the tidy dataset, at R command prompt type following
>source('~/run_analysis.R')

>run_analysis()

## Source Data
Source data is from "Human Activity Recognition Using Smartphones Dataset" which can be downloaded from [https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip]

## Downloading Source Data
First download source data from url to a local working directory then unzip
   
     # load dplyr library
     library(dplyr)
     
     #download zip file 
     url<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
     destination<-paste(getwd(),"/","UCIHARDataset.zip",sep = "")
     download.file(url, dest=destination) 
     #unzip files
     extractpath<-paste(getwd(),"/",sep = "")
     unzip (destination, exdir = extractpath)
     
## Loading Common Data into R
There is a file called activity_labels.txt that has ID and Name of the activities
and features.txt file that contains variables. These files are common to both 
test and train data set but has no column header. 

Load activitiy_labels.txt file and set ActivityID and ActivityName column variables

     # load activity file
     activityfile<-"./UCI HAR Dataset/activity_labels.txt"
     activityLabels<-read.table(activityfile)
     #set column names for activity data
     colnames(activityLabels)<-c("ActivityID","ActivityName")

Load features.txt file and get column variables that will be used for test 
and train datasets

     # load features data -- this will be re-used by both test and train data sets
     featuresfile<-"./UCI HAR Dataset/features.txt"
     columnsVariables<-read.table(featuresfile)
     
## Loading Test Data into R
First, load subject id's used in test data set and set variable name to Subject
     
     #load test subject data
     testsubjectfile<-"./UCI HAR Dataset/test/subject_test.txt"
     testsubject<-read.table(testsubjectfile)
     #set column name for subject
     colnames(testsubject)<-"Subject"

Load test measures and set column names to variable names from features.txt

     #load X_test data
     testfile_x<-"./UCI HAR Dataset/test/X_test.txt"
     test_x<-read.table(testfile_x)
     # set columns for test_x data
     colnames(test_x)<-columnsVariables$V2

Load activity id's for test data set and set variable name to Activity 

     #load activities for tests
     testfile_y<-"./UCI HAR Dataset/test/y_test.txt"
     test_y<-read.table(testfile_y)
     #set column name for test_y
     colnames(test_y)<-"Activity"
     
Now combine subject id, activity id and test measures into single test data set
     
     #create test data set by combining subjects, activities and test measurements
     #testdata <- data.frame()
     # combine subject, activity and test_x
     testdata<-cbind(testsubject,test_y,test_x)

## Smilarly Load Train Data into R   
     
     #load train data
     trainsubjectfile<-"./UCI HAR Dataset/train/subject_train.txt"
     trainsubject<-read.table(trainsubjectfile)
     # set column name for subject
     colnames(trainsubject)<-"Subject"
     
     trainfile_x<-"./UCI HAR Dataset/train/X_train.txt"
     trainfile_y<-"./UCI HAR Dataset/train/y_train.txt"
     
     train_x<-read.table(trainfile_x)
     # set columns for train_x data
     colnames(train_x)<-columnsVariables$V2
     #load train activities 
     train_y<-read.table(trainfile_y)
     #set column name for test_y
     colnames(train_y)<-"Activity"
     
     #create train data set by combining subjects, activities and train measurements
     #testdata <- data.frame()
     # combine subject, activity and train_x
     traindata<-cbind(trainsubject,train_y,train_x)
     
## STEP 1 Merge Test and Train Datasets into single dataset

     merged_data<-rbind(testdata,traindata)
     
## STEP 2 Extract only mean() and std() measures

As described in Readme.md file, there were two schools of thought regarding wich columns
should be extracted and I agree with the group that believes columns like mensFreq() should 
not be included.

     #extract only columns that has mean() and std()
     merged_subset <- cbind(Subject=merged_data$Subject,Activity=merged_data$Activity, 
                            merged_data[,grep("-std|mean\\(", names(merged_data))])
     
## STEP 3 Replace Activity IDs with Descriptive Activity Names
Using activityLabels, we can replace ids with names

     merged_subset$Activity<-sapply(merged_subset$Activity,function(x) activityLabels$ActivityName[x])
     
## STEP 4 Change Variable Names to be Descriptive
In this step we programmatically replace some strings with descriptive words

     #get all column names
     columns<-colnames(merged_subset)
     #replace beginning t with Time
     columns<-gsub("^t","Time", columns)
     #replace beginning f with Frequency
     columns<-gsub("^f","Frequency", columns)
     #replace Acc with Acceleration
     columns<-gsub("Acc","Acceleration", columns)
     #replace Gyro with AngularVelocity
     columns<-gsub("Gyro","AngularVelocity", columns)
     #replace Mag with Magnitude
     columns<-gsub("Mag","Magnitude", columns)
     #replace -std with StandardDeviation
     columns<-gsub("-std","StandardDeviation", columns)
     #replace -mean with Mean
     columns<-gsub("-mean","Mean", columns)
     #replace BodyBody with Body
     columns<-gsub("BodyBody", "Body", columns)
     #remove special characters like ()- etc
     columns<-gsub("[[:punct:]]", "", columns)
     
     #replace old variable names with new
     colnames(merged_subset)<-columns
     
## STEP 5 Create a Second Independent Tidy Dataset with average of each measures

     #group data set by activity and subject
     by_activity_subject<-group_by(merged_subset,Subject,Activity)
     
     #summarize data
     tidy<-summarize_all(by_activity_subject,mean)
     #write tidy data set to a file
     write.table(tidy,"./UCI HAR Dataset/TidyDataset.txt", row.names = FALSE)
