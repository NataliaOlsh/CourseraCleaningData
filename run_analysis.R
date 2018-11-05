#
# This s a script for Coursera Assignment 4 for "Getting and Cleaning Data"
# 
# We take several datasets, concatanate them, clean variable and row names,
# create resulting tidy data set with mean of all variables in groups of each Subject and Activity Name
#

library(dplyr)

# Reading features (measurements)
features<-read.table("features.txt", header = FALSE, sep = "", stringsAsFactors = FALSE)

# Subsetting features, which ends with "mean()" or "std()" 
# (values like mean-X we  suppose to be a raw data and are not going to output)
featuresToPrint<-cbind(
        features$V1[grepl("mean\\(\\)$", features$V2)
                    | grepl("std\\(\\)$", features$V2)],
        features$V2[grepl("mean\\(\\)$", features$V2)
                    | grepl("std\\(\\)$", features$V2)]
        )

# Cleaning Feature names: gettibg (for example) "tBodyGyroMagStd" instead of "tBodyGyroMag-std()"
featuresToPrint[,2]<-gsub("[[:punct:]]*std[[:punct:]]*", "Std", featuresToPrint[,2])
featuresToPrint[,2]<-gsub("[[:punct:]]*mean[[:punct:]]*", "Mean", featuresToPrint[,2])


# Reading train datasets
trainMeasurements<-read.table("train\\X_train.txt", header=FALSE, sep="")
trainActivities<-read.table("train\\y_train.txt", header=FALSE, sep="")
trainSubjects<-read.table("train\\subject_train.txt", header=FALSE, sep="")

# Concatanating train sets (as columns) together
trainSet<-cbind(trainSubjects, trainActivities, trainMeasurements)

# Reading test datasets
testMeasurements<-read.table("test\\X_test.txt", header=FALSE, sep="")
testActivities<-read.table("test\\y_test.txt", header=FALSE, sep="")
testSubjects<-read.table("test\\subject_test.txt", header=FALSE, sep="")

# Concatanating test sets (as columns) together
testSet<-cbind(testSubjects, testActivities, testMeasurements)

# Merging train and test sets together (as rows)
fullSet<-rbind(trainSet, testSet)

# Subsetting only columns from featuresToPrint (using id of columns)
fullSet<-fullSet[, c(1, 2, as.numeric(featuresToPrint[,1])+2)]

# Setting correct column names
names(fullSet)<-c("SubjectId", "ActivityId", featuresToPrint[,2])

#Reading Activity Labels
activityLabels<-read.table("activity_labels.txt", header=FALSE, sep="")

#Setting column names in Activity Labels Dataset
names(activityLabels)<-c("V1", "ActivityName")

# Getting Full Activity names in our DataSet
fullSet<-merge(fullSet, activityLabels, by.x = "ActivityId", by.y="V1", all=TRUE) %>%
                select(c("ActivityName","SubjectId", featuresToPrint[, 2]))


# Creating Result Tidy Dataset with mean of all variables for each Subject and Activity Name
activitySubjectAvgSet<- ddply(fullSet, .(ActivityName,SubjectId), summarize,
                               tBodyAccMagMeanASMean=mean(tBodyAccMagMean),
                               tBodyAccMagStdASMean=mean(tBodyAccMagStd),
                               tGravityAccMagMeanASMean=mean(tGravityAccMagMean),
                               tGravityAccMagStdASMean=mean(tGravityAccMagStd),
                               tBodyAccJerkMagMeanASMean=mean(tBodyAccJerkMagMean),
                               tBodyAccJerkMagStdASMean=mean(tBodyAccJerkMagStd),
                               tBodyGyroMagMeanASMean=mean(tBodyGyroMagMean),
                               tBodyGyroMagStdASMean=mean(tBodyGyroMagStd),
                               tBodyGyroJerkMagMeanASMean=mean(tBodyGyroJerkMagMean),
                               tBodyGyroJerkMagStdASMean=mean(tBodyGyroJerkMagStd),
                               fBodyAccMagMeanASMean = mean(fBodyAccMagMean),
                               fBodyAccMagStdASMean=mean(fBodyAccMagStd),
                               fBodyBodyAccJerkMagMeanASMean=mean(fBodyBodyAccJerkMagMean),
                               fBodyBodyAccJerkMagStdASMean=mean(fBodyBodyAccJerkMagStd),
                               fBodyBodyGyroMagMeanASMean=mean(fBodyBodyGyroMagMean),
                               fBodyBodyGyroMagStdASMean=mean(fBodyBodyGyroMagStd),
                               fBodyBodyGyroJerkMagMeanASMean=mean(fBodyBodyGyroJerkMagMean),
                               fBodyBodyGyroJerkMagStdASMean=mean(fBodyBodyGyroJerkMagStd)
                                                              )

# Wirite Result Dataset to file
write.table(activitySubjectAvgSet, "ActivitySubjectAvg.txt", row.name=FALSE)
        
