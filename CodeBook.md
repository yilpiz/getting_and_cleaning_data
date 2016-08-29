## Tidy Dataset

The dataset, TidyDataset.txt, is derived from "Human Activity Recognition Using Smartphones Dataset"" which can be downloaded from [https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip] by running R code run_analysis.R

Zip folder downloaded from above link contains README.txt, activity_labels.txt, features_info.txt,features.txt and test, train folders that contains data.

Please refer to above files to understand more about the original data set and refer to README.md on how this tidy dataset is generated from original dataset.

This document explains what is included in the TidyDataset.txt file and how it satisfies the Tidy Data Principles.


Subject is the id's of original subjects that performed the test and train with values from 1 to 30. 

Activity is the descriptive name of the activities those subjects performed and have these 6 values: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING AND LAYING.

Other 66 variables are extracted from orginial source per requirement. There were different opinions in course forum regarding the requirement "extract only the measurements on the mean and standard deviation for each measurement". Some argued the variables like fBodyAcc-meanFreq()-X should be included. I agree with other group that they should not be included since those variables did not have corresponding standard deviation. Values of the these 66 variables are the average of original observations obtained by summarise function with mean parameter for each variable grouped by each subject and activity as describe in CodeBook.md 

Variable names are cleaned up to make them more descriptive. For example, original variable tBodyAcc-mean()-X is renamed to TimeBodyAccelerationMeanX. CodeBook.md and run_analysis.R has full documentation on variable name replacements logic. 

Since there are 30 distinct subjects and 6 distinct activites, data set contains 30*6=180 rows and average of 66 measures for each distinct combination of subject and activity.

### TidyDataset satisfy fowllowing tidy datset principles.

Dataset has headers so that reader knows which column is which.

Each columns represents different variable.

Each row reprsents different observations.

No duplicate columns.

Tidy dataset contains 68 variables as listed below. CamelCasing is used for variable names and varaible names are pretty self explanatory. 

1  Subject

2  Activity

3  TimeBodyAccelerationMeanX

4  TimeBodyAccelerationMeanY

5  TimeBodyAccelerationMeanZ

6  TimeBodyAccelerationStandardDeviationX

7  TimeBodyAccelerationStandardDeviationY

8  TimeBodyAccelerationStandardDeviationZ

9  TimeGravityAccelerationMeanX

10 TimeGravityAccelerationMeanY

11 TimeGravityAccelerationMeanZ

12 TimeGravityAccelerationStandardDeviationX

13 TimeGravityAccelerationStandardDeviationY

14 TimeGravityAccelerationStandardDeviationZ

15 TimeBodyAccelerationJerkMeanX

16 TimeBodyAccelerationJerkMeanY

17 TimeBodyAccelerationJerkMeanZ

18 TimeBodyAccelerationJerkStandardDeviationX

19 TimeBodyAccelerationJerkStandardDeviationY

20 TimeBodyAccelerationJerkStandardDeviationZ

21 TimeBodyAngularVelocityMeanX

22 TimeBodyAngularVelocityMeanY

23 TimeBodyAngularVelocityMeanZ

24 TimeBodyAngularVelocityStandardDeviationX

25 TimeBodyAngularVelocityStandardDeviationY

26 TimeBodyAngularVelocityStandardDeviationZ

27 TimeBodyAngularVelocityJerkMeanX

28 TimeBodyAngularVelocityJerkMeanY

29 TimeBodyAngularVelocityJerkMeanZ

30 TimeBodyAngularVelocityJerkStandardDeviationX

31 TimeBodyAngularVelocityJerkStandardDeviationY

32 TimeBodyAngularVelocityJerkStandardDeviationZ

33 TimeBodyAccelerationMagnitudeMean

34 TimeBodyAccelerationMagnitudeStandardDeviation

35 TimeGravityAccelerationMagnitudeMean

36 TimeGravityAccelerationMagnitudeStandardDeviation

37 TimeBodyAccelerationJerkMagnitudeMean

38 TimeBodyAccelerationJerkMagnitudeStandardDeviation

39 TimeBodyAngularVelocityMagnitudeMean

40 TimeBodyAngularVelocityMagnitudeStandardDeviation

41 TimeBodyAngularVelocityJerkMagnitudeMean

42 TimeBodyAngularVelocityJerkMagnitudeStandardDeviation

43 FrequencyBodyAccelerationMeanX

44 FrequencyBodyAccelerationMeanY

45 FrequencyBodyAccelerationMeanZ

46 FrequencyBodyAccelerationStandardDeviationX

47 FrequencyBodyAccelerationStandardDeviationY

48 FrequencyBodyAccelerationStandardDeviationZ

49 FrequencyBodyAccelerationJerkMeanX

50 FrequencyBodyAccelerationJerkMeanY

51 FrequencyBodyAccelerationJerkMeanZ

52 FrequencyBodyAccelerationJerkStandardDeviationX

53 FrequencyBodyAccelerationJerkStandardDeviationY

54 FrequencyBodyAccelerationJerkStandardDeviationZ

55 FrequencyBodyAngularVelocityMeanX

56 FrequencyBodyAngularVelocityMeanY

57 FrequencyBodyAngularVelocityMeanZ

58 FrequencyBodyAngularVelocityStandardDeviationX

59 FrequencyBodyAngularVelocityStandardDeviationY

60 FrequencyBodyAngularVelocityStandardDeviationZ

61 FrequencyBodyAccelerationMagnitudeMean

62 FrequencyBodyAccelerationMagnitudeStandardDeviation

63 FrequencyBodyAccelerationJerkMagnitudeMean

64 FrequencyBodyAccelerationJerkMagnitudeStandardDeviation

65 FrequencyBodyAngularVelocityMagnitudeMean

66 FrequencyBodyAngularVelocityMagnitudeStandardDeviation

67 FrequencyBodyAngularVelocityJerkMagnitudeMean

68 FrequencyBodyAngularVelocityJerkMagnitudeStandardDeviation

