Codebook for Getting and Cleaning the Data - September, 2014 
============================================================

(Reference: https://class.coursera.org/getdata-007/forum/thread?thread_id=28#comment-245)

The file activity_labels.txt contains a mapping between the activity number and the type of activity.
The file features.txt lists all the accelerometer and gyroscope 3-axial raw signals captured by the Samsung device.
The training dataset and test data set each contain 3 files, subject, X and Y. All have equal number of rows and the corresponding rows in each files form the part of the same observation.
	Subject - each line contains a numerical ID of the person the observation is made on.
	X - each line is a space-separated vector of features, as recorded by the samsung device. The order of the features is obtained from features.txt.
	Y - each line corresponds the activity ID of the observation. The mapping of activity ID is obtained through activity_labels.txt.

* The mapping between activity IDs and activity labels is constructed.
* The mapping between feature IDs and feature labels is constructed.
* The subject, X and Y columns are individually read for both training and test datasets. Note that each observation in X is a long space-separated string of features. These features will be filtered at a later stage.
* From the training set and test set, merge the rows for subjects, X and Y respectively.
* Next, put the subjects, X and Y side-by-side as columns to create a set of observations. This is the master set for observations.
* Next, create a subset of the master observation by filtering out the features in X which do not represent mean or standard deviation.
	Here is an exhaustive list of those features: activities, subjects, tBodyAcc-mean()-X, tBodyAcc-mean()-Y, tBodyAcc-mean()-Z, tBodyAcc-std()-X, tBodyAcc-std()-Y, tBodyAcc-std()-Z, tGravityAcc-mean()-X, tGravityAcc-mean()-Y, tGravityAcc-mean()-Z, tGravityAcc-std()-X, tGravityAcc-std()-Y, tGravityAcc-std()-Z, tBodyAccJerk-mean()-X, tBodyAccJerk-mean()-Y, tBodyAccJerk-mean()-Z, tBodyAccJerk-std()-X, tBodyAccJerk-std()-Y, tBodyAccJerk-std()-Z, tBodyGyro-mean()-X, tBodyGyro-mean()-Y, tBodyGyro-mean()-Z, tBodyGyro-std()-X, tBodyGyro-std()-Y, tBodyGyro-std()-Z, tBodyGyroJerk-mean()-X, tBodyGyroJerk-mean()-Y, tBodyGyroJerk-mean()-Z, tBodyGyroJerk-std()-X, tBodyGyroJerk-std()-Y, tBodyGyroJerk-std()-Z, tBodyAccMag-mean(), tBodyAccMag-std(), tGravityAccMag-mean(), tGravityAccMag-std(), tBodyAccJerkMag-mean(), tBodyAccJerkMag-std(), tBodyGyroMag-mean(), tBodyGyroMag-std(), tBodyGyroJerkMag-mean(), tBodyGyroJerkMag-std(), fBodyAcc-mean()-X, fBodyAcc-mean()-Y, fBodyAcc-mean()-Z, fBodyAcc-std()-X, fBodyAcc-std()-Y, fBodyAcc-std()-Z, fBodyAcc-meanFreq()-X, fBodyAcc-meanFreq()-Y, fBodyAcc-meanFreq()-Z, fBodyAccJerk-mean()-X, fBodyAccJerk-mean()-Y, fBodyAccJerk-mean()-Z, fBodyAccJerk-std()-X, fBodyAccJerk-std()-Y, fBodyAccJerk-std()-Z, fBodyAccJerk-meanFreq()-X, fBodyAccJerk-meanFreq()-Y, fBodyAccJerk-meanFreq()-Z, fBodyGyro-mean()-X, fBodyGyro-mean()-Y, fBodyGyro-mean()-Z, fBodyGyro-std()-X, fBodyGyro-std()-Y, fBodyGyro-std()-Z, fBodyGyro-meanFreq()-X, fBodyGyro-meanFreq()-Y, fBodyGyro-meanFreq()-Z, fBodyAccMag-mean(), fBodyAccMag-std(), fBodyAccMag-meanFreq(), fBodyBodyAccJerkMag-mean(), fBodyBodyAccJerkMag-std(), fBodyBodyAccJerkMag-meanFreq(), fBodyBodyGyroMag-mean(), fBodyBodyGyroMag-std(), fBodyBodyGyroMag-meanFreq(), fBodyBodyGyroJerkMag-mean(), fBodyBodyGyroJerkMag-std(), fBodyBodyGyroJerkMag-meanFreq()
* Replace the Activiy IDs by their descriptive names, using the ID-activity_label mapping.
* Replace the Feature IDs by their desctiptive names, using the ID-faeture_label mapping.
* Split the dataset into subsets based on the activities and subjects columns.
* For each individual split group, average out each of the features.
* The pair activity-subject combination forms the primary key. Combine the averaged out features into activity-subject-features records.
* Write out the aggregated dataset onto a file.