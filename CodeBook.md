# CodeBook

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc* and tGravityAcc*) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk* and tBodyGyroJerk*). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

Resulting Data Frame and its variables:
* activitySubjectAvgSet
  * ActivityName - Name of activity been observed:
    * WALKING
    * WALKING_UPSTAIRS
    * WALKING_DOWNSTAIRS
    * SITTING
    * STANDING
    * LAYING
  * SubjectId - ID of human been observed
  * tBodyAccMagMeanASMean - mean of observation variable tBodyAccMagMean by ActivityName and SubjectId (so with postfix ASMean)
  * tBodyAccMagStdASMean
  * tGravityAccMagMeanASMean
  * tGravityAccMagStdASMean
  * tBodyAccJerkMagMeanASMean
  * tBodyAccJerkMagStdASMean
  * tBodyGyroMagMeanASMean
  * tBodyGyroMagStdASMean
  * tBodyGyroJerkMagMeanASMean
  * tBodyGyroJerkMagStdASMean
  * fBodyAccMagMeanASMean
  * fBodyAccMagStdASMean
  * fBodyBodyAccJerkMagMeanASMean
  * fBodyBodyAccJerkMagStdASMean
  * fBodyBodyGyroMagMeanASMean
  * fBodyBodyGyroMagStdASMean
  * fBodyBodyGyroJerkMagMeanASMean
  * fBodyBodyGyroJerkMagStdASMean

This is full description of datasets involved in analysis:

* features
  * dataframe
  * contains a list of measurement name from file "features.txt"
  * 561 observations, 2 variables (one is ID of observaion and second is name)
* featuresToPrint
  * matrix
  * is a subset of features, containg only those measurement names, which ends on "mean()" or "std()"
  * 18 observations, 2 variables (one is ID of observaion and second is name)
* trainMeasurements
  * dataframe
  * contains a list of measurements from file "train\X_train.txt"
  * 7352 observations, 561 variables
* trainActivities
  * dataframe
  * contains a vector with Activity ID's from file "train\y_train.txt" corresponding to each observation of trainMeasurements
  * 7352 observations, 1 variable (Activity Id)
* trainSubjects
  * dataframe
  * contains a vector with Subject ID's from file "train\subject_train.txt" corresponding to each observation of trainMeasurements
  * 7352 observations, 1 variable (Subject Id)
* trainSet
  * dataframe
  * TrainMeasurement with two extra columns: Activity Id from trainActivity and Subject Id from trainSubject
  * 7352 observations, 563 variables
* testMeasurements
  * dataframe
  * contains a list of measurements from file "test\X_test.txt"
  * 2947 observations, 561 variables
* testActivities
  * dataframe
  * contains a vector with Activity ID's from file "test\y_test.txt" corresponding to each observation of testMeasurements
  * 2947 observations, 1 variable (Activity Id)
* trainSubjects
  * dataframe
  * contains a vector with Subject ID's from file "train\subject_train.txt" corresponding to each observation of testMeasurements
  * 2947 observations, 1 variable (Subject Id)
* testSet
  * dataframe
  * TestMeasurement with two extra columns: Activity Id from testActivity and Subject Id from testSubject
  * 2947 observations, 563 variables
* fullSet
  * dataframe
  * contains observations (rows) from testSet and trainSet
  * contains only variables from featuresToPrint dataframe
  * contains Activity Names instead of Activity Id's
  * 10299 observations, 20 variables
* activitySubjectAvgSet
  * dataframe
  * contains fullSet, grouped bu SubjectId and ActivityName and containing mean of others variables
  * 10299 observations, 20 variables
