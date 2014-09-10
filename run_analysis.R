# Descrption: This script is used to clean the Samsung Galaxy S smartphone dataset on Human Activities like walking, sitting, standing, laying etc.
# Author: mv.vijesh@gmail.com
# Dated: 10th September, 2014

# Before running this script, make sure that your working directory is the root of Samsung dataset.

#Step 1 - Merges the training and the test sets to create one data set.
# Read all the required Data
#Activity Index to Label Mapping
con <- file("activity_labels.txt")
activityLabelLines = readLines(con)
close.connection(con)
activityLabels <- list()
activityLabels <- lapply(activityLabelLines, function (e) { t <- strsplit(e, " "); activityLabels[[ t[[1]][1] ]] <- t[[1]][2] })

#Feature Index to Label Mapping
con <- file("features.txt")
featureLines = readLines(con)
close.connection(con)
featureLabels <- list()
featureLabels <- lapply(featureLines, function (e) { t <- strsplit(e, " "); featureLabels[[ t[[1]][1] ]] <- t[[1]][2] })

#Read and store training dataset
con <- file("train/Y_train.txt")
trainingActivities = readLines(con)
close.connection(con)

con <- file("train/X_train.txt")
trainingFeatureVectorsFile = readLines(con)
close.connection(con)

con <- file("train/subject_train.txt")
trainingSubjects = readLines(con)
close.connection(con)

#Read and store test dataset
con <- file("test/Y_test.txt")
testActivities = readLines(con)
close.connection(con)

con <- file("test/X_test.txt")
testFeatureVectorsFile = readLines(con)
close.connection(con)

con <- file("test/subject_test.txt")
testSubjects = readLines(con)
close.connection(con)

#Create a Master Data Set
masterActivities = append(trainingActivities, testActivities)
masterFeatureVectors = append(trainingFeatureVectorsFile, testFeatureVectorsFile)
masterSubjects = append(trainingSubjects, testSubjects)

masterDataFrame = data.frame(activities = masterActivities,
                             featureVectors = masterFeatureVectors,
                             subjects = masterSubjects)

#Step 2 - Extracts only the measurements on the mean and standard deviation for each measurement
featureVectorNames <- as.character(featureLabels)
meanStdIndices <- which(grepl("mean()", featureVectorNames) | grepl("std()", featureVectorNames))

#Do not alter the master data frame
meanStdDataFrame = data.frame(activities = masterDataFrame$activities,
                              subjects = masterDataFrame$subjects)

charFeatureVectors <- as.character(masterDataFrame$featureVectors)
#create an empty temporary data frame to store the feature vector values
featureMatrix <- matrix(data = numeric(), nrow = nrow(meanStdDataFrame), ncol = length(meanStdIndices))

#rbind the parsed vector values onto featureDataFrame
for(i in 1:length(charFeatureVectors)) {
        charFeatureVector <- charFeatureVectors[i]
        t <- strsplit(charFeatureVector, " +")[[1]]
        t <- t[meanStdIndices + 1] #offset by 1 because the strsplit will have an empty string at the beginning
        featureMatrix[i, ] <- as.numeric(t)
}
meanStdFeatureVectorNames <- featureVectorNames[meanStdIndices]

#create columns onto meanStdDataFrame
for(i in 1:length(meanStdFeatureVectorNames)) {
        #Note that this will also accomplish step 4 - Appropriately labels the data set with descriptive variable names.
        meanStdDataFrame[meanStdFeatureVectorNames[i]] <- featureMatrix[, i]
}

#Step 3 - Uses descriptive activity names to name the activities in the data set
#In this step, we rename the descriptive activities that the users are performing
meanStdDataFrame$activities <- as.character(sapply(meanStdDataFrame$activities, function(activityCode) { activityLabels[activityCode] }))

#Step 4 - Appropriately labels the data set with descriptive variable names - included as a part of step 2

#Step 5 - From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
activitySubjectSplit <- split(meanStdDataFrame, list(meanStdDataFrame$activities, meanStdDataFrame$subjects))
summarizedData <- lapply(activitySubjectSplit, function(activitySubjectData) {
        numericDataFrame <- activitySubjectData[, c(-1, -2)]
        activitySubjectDataFrame <- data.frame(
                activities = activitySubjectData$activities[[1]],
                subjects = activitySubjectData$subjects[[1]])
        meanDataFrame <- data.frame()
        meanDataFrame <- rbind(meanDataFrame, as.numeric(colMeans(numericDataFrame)))
        names(meanDataFrame) <- names(numericDataFrame)
        cbind(activitySubjectDataFrame, meanDataFrame)
})

tidyData <- data.frame()
names(tidyData) = names(meanStdDataFrame)
for(activitySubjectMeans in summarizedData) {
        tidyData <- rbind(tidyData, activitySubjectMeans[1, ])
}