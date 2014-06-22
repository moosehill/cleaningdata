#
# This script creates a final, tidy dataset by performing the following steps:
#
#      1. Merge the training and testing datasets from the UCI HAR project to create a single, combined dataset
#      2. Extract just the feature measurements related to mean and standard deviation for each observation
#      3. Replace numeric activity codes with descriptive names
#      4. Labels the columns of the dataset with descriptive variable names
#      5. Creates a new tidy data set that contains the mean of each variable for each activity and each subject
#
# The script must be run from the top-level UCI HAR Dataset directory and the final dataset (project_dataset.csv)
# will be created in that directory as well.
#

library(reshape2)

if ( ! file.exists("../UCI HAR Dataset") )
  stop("The script must be run from the top-level UCI HAR Dataset directory")

#
# Concatenate the 561-feature data from the training and test data sets.
#
training_feature = read.table("train/X_train.txt",sep="",header=FALSE)
testing_feature = read.table("test/X_test.txt",sep="",header=FALSE)
combined_feature = rbind(training_feature, testing_feature)

#
# Label the columns with their UCI-documented variable names
#
labels = read.table("features.txt",header=FALSE)
names(combined_feature) = labels$V2

#
# Select only the data columns that have the strings "mean()" or "std()" in their names
#
mean_or_std = combined_feature[grep("mean\\(\\)|std\\(\\)",names(combined_feature),value=TRUE)]

#
# Get the training and testing activity data
#
training_activity = read.table("train/y_train.txt",sep="",header=FALSE)
testing_activity = read.table("test/y_test.txt",sep="",header=FALSE)
combined_activity = rbind(training_activity,testing_activity)
names(combined_activity) = "Activity"

#
# Convert the activity codes to UCI-documented descriptive names
#
combined_activity$Activity = factor(combined_activity$Activity,ordered=TRUE,labels=c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING"))

#
# Get the training and testing activity data
#
training_subject = read.table("train/subject_train.txt",sep="",header=FALSE)
testing_subject = read.table("test/subject_test.txt",sep="",header=FALSE)
combined_subject = rbind(training_subject,testing_subject)
names(combined_subject) = "Subject"

#
# Combine feature, activity, and subject data into one data frame
#
combined = cbind(combined_feature,combined_activity,combined_subject)

#
# Create a new table where each row contains the mean of all feature variables for each subject and activity combination from
# the combined table just created
#
combined_melted = melt(combined,id=c("Subject","Activity"))
project_dataset = dcast(combined_melted, Subject + Activity ~ variable,mean)

#
# Need to update the column names since they now represent averages. Hackily fix the Activity and Subject columns after
# messing them up with paste()
#
names(project_dataset) = paste("Average-",names(project_dataset),sep="")
names(project_dataset)[colnames(project_dataset) == "Average-Subject"] = "Subject"
names(project_dataset)[colnames(project_dataset) == "Average-Activity"] = "Activity"

#
# Save the final dataset in the current directory
#
write.csv(project_dataset,"project-dataset.csv",row.names=FALSE)
