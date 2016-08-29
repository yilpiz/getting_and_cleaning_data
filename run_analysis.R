run_analysis<-function()
{
     #load dplyr library
     library(dplyr)
    
     #STEP 0 Download and load source data
     #download zip file  to working directory
     url<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
     destination<-paste(getwd(),"/","UCIHARDataset.zip",sep = "")
     download.file(url, dest=destination) 
     #unzip files
     extractpath<-paste(getwd(),"/",sep = "")
     unzip (destination, exdir = extractpath)
    
     # read source files and load test and train data
     # load activity file
     activityfile<-"./UCI HAR Dataset/activity_labels.txt"
     activityLabels<-read.table(activityfile)
     #set column names for activity data
     colnames(activityLabels)<-c("ActivityID","ActivityName")
     
     # load features data -- this will be re-used by both test and train data sets
     featuresfile<-"./UCI HAR Dataset/features.txt"
     columnsVariables<-read.table(featuresfile)
     
     #load test subject data
     testsubjectfile<-"./UCI HAR Dataset/test/subject_test.txt"
     testsubject<-read.table(testsubjectfile)
     # set column name for subject
     colnames(testsubject)<-"Subject"
     
     
     #load X_test data
     testfile_x<-"./UCI HAR Dataset/test/X_test.txt"
     test_x<-read.table(testfile_x)
     # set columns for test_x data
     colnames(test_x)<-columnsVariables$V2
     
     #load activities for tests
     testfile_y<-"./UCI HAR Dataset/test/y_test.txt"
     test_y<-read.table(testfile_y)
     #set column name for test_y
     colnames(test_y)<-"Activity"
     
     #create test data set by combining subjects, activities and test measurements
     #testdata <- data.frame()
     # combine subject, activity and test_x
     testdata<-cbind(testsubject,test_y,test_x)
     
     
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
     
     #STEP 1 Merge train and test data set
     merged_data<-rbind(testdata,traindata)
     
     #STEP 2 Extract only columns that has mean and std
     
     merged_subset <- cbind(Subject=merged_data$Subject,Activity=merged_data$Activity, 
                            merged_data[,grep("-std|mean\\(", names(merged_data))])
     
     #STEP 3 Replace Activity IDs with descriptive activity names
     merged_subset$Activity<-sapply(merged_subset$Activity,function(x) activityLabels$ActivityName[x])
     
     #STEP 4 Change variable names to be descriptive
     columns<-colnames(merged_subset)
     #replace t with Time
     columns<-gsub("^t","Time", columns)
     #replace f with Frequency
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
     
     #STEP 5 Create Tidy Dateset
     #Create second independent tidy data set with the average of each
     #variable for each activity and each subject
     #group by activity and subject
     by_activity_subject<-group_by(merged_subset,Subject,Activity)
     #summarize data
     tidy<-summarize_all(by_activity_subject,mean)
     #write tidy data set to a file
     write.table(tidy,"./UCI HAR Dataset/TidyDataset.txt", row.names = FALSE)
}