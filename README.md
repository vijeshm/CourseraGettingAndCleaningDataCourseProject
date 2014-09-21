Coursera - Course Project for Getting And Cleaning Data
=======================================================

Instructions to run the code:
* Extract the UCI HAR dataset from 'getdata_projectfiles_UCI HAR Dataset.zip'
* Set the current working directory in R to the UCI HAR dataset directory
* Source the 'run_analysis.R'
* The tidy dataset is written onto a text file called 'tidyData.txt'

Detailed working of run_analysis.R (Reference: https://class.coursera.org/getdata-007/forum/thread?thread_id=28#comment-245)
===============================
1. The training data and the test data needs to be merged into complete dataset.
	a. Create a list-mapping between index and activities measured in the dataset. This information is present in the file activity_labels.txt. To make the merging approach generic, read all the lines from the file and create a list-mapping called 'activityLabels'.
	b. Create a list-mapping between index and features measured in the dataset. There are 561 features being measued and the mapping information is captured in the file features.txt. To make the merging approach generic, read all the lines from the file and create a list-mapping called 'featureLabels'.
	c. Read the X, Y and Subject information in the training the dataset. 
		* 'train/X_train.txt' consists of the feature observations. Save it as a character vector in a variable 'trainingFeatureVectorsFile'. This character vector will be converted to a numeric at a later point of time.
		* 'train/Y_train.txt' consists of the activity information. Save it as a number in a variable 'trainingActivities'. This number will be mapped to an activity at a later point in time.
		* 'train/subject_train.txt' consists of the subject ID on which the tests are being performed. Save it in a variable 'trainingSubjects'. This number will not be mapped to any subjects since we do not have data about the subjects.
	d. Perform a similar action on the test dataset.
	e. Create a master data set by appending the rows of activities, features and subjects for training and testing data. A new data frame is created with columns being the appended activities, features and subjects. This serves as the master Data Frame. Note that the features are still in a character format.

2. Extracts only the measurements on the mean and standard deviation for each measurement
	a. grep the names of the feature vectors containing the words "mean()" or "std()" to find out the index at which they occur.
	b. DO NOT ALTER the master data frame. Create a new data frame with the same activities and subjects columns. 
	c. We've to create columns in this new data frame corresponding to the means and standard deviation measurements. To do this, create a temporary feature matrix to store the numeric-converted feature observations. Split each feature of the master data in the character-form into a character vector, and store their numeric forms in the temporary matrix. Subset the matrix depending on the index of mean and standard deviation columns and update the new data frame.

3. Uses descriptive activity names to name the activities in the data set
	Using the activity index - activity label mapping, activityLabels, replace the activities column by the corresponding substituted activity names.

4. Appropriately labels the data set with descriptive variable names - This task was accomplished as a part of step 2

5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
	a. Split the data frame by activity and subjects column
	b. For each element in the split data, average out all the mean and standard deviation variables. This can be achieved by an lappply function on the split data, filtering out the activity and subject columns and applying colMeans on the remaining columns. The results are stored in a variable called 'summarizedData'
	c. summarizedData will be in the list format. Create a new data frame (tidyData), set the names and rbind the values in the list to this data frame.
6. Finally, write the tidyData onto a file using write.table().