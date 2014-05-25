#Coursera - Getting and Cleaning Data Course Project
####Coursera - Getting and Cleaning Data Course Project Submission <br />
####File Name: CodeBook.md <br />
Name: Adi J <br />
Link: <https://github.com/ajammala/CourseProject003> <br />

##About
This markdown file describes the variables, the data, and any transformations or work performed to clean up the data.<br />

##Notes
* **Variable Names** - Variable names are in Camel Case to improve readability.
* **Input Data** - The input data is in the **'UCI HAR Dataset'** folder inside the working directory.
* **Output Data** - The script creates a **'results'** folder inside the * **'UCI HAR Dataset'**.
* **Excluded Folders** - The data in the **'Inertial Signals'** folders both under the *UCI HAR Dataset/test* and the *UCI HAR Dataset/train* folders is ignored.


##Data Transformation
The 'run_analysis.R' script is used for performing the data cleanup and the analysis. The script is broken into 5 steps. <br />

**Step 1** - Read the input data from the training and testing folders into seperate data frames. Combine the data frames horizontally based on type of data. At the end of step 1, the script creates 3 seperate data frames (X variables, Y variables and subject data).<br />

	subjectMergedData <- rbind(read.table(trainingDataFiles[1]), read.table(testDataFiles[1]))
	xMergedData <- rbind(read.table(trainingDataFiles[2]), read.table(testDataFiles[2]))
	yMergedData <- rbind(read.table(trainingDataFiles[3]), read.table(testDataFiles[3]))
	allMergedData <- cbind(subjectMergedData, yMergedData, xMergedData)

**Step 2** - Extract a subset of the input data. The extracted data is the measurements on the mean and standard deviation for each measurement. For this purpose only the fields containing the words *mean()* and *std()* were filtered.<br />

	subsetFields <- c("subjectID", "activityID", as.vector(allFieldNames[grep("mean\\(\\)|std\\(\\)", allFieldNames)]))

**Step 3** - Merge the subset with the activity labels data set to add a column that provides a meaningful description of the activity being performed. 

	subsetData <- merge(subsetData, activityData, by = "activityID")

**Step 4** - Rename the field names in the extracted subset. <br />
* The field names were named with Camel Case to improve readability.<br /> 
* The letters X, Y and Z were replaced with more meaningful phrases 'Xaxis', 'Yaxis' and 'Zaxis'.<br />
* The end of the field name indicates whether a field is a mean or a standard deviation measurement. <br />

	temp = unlist(strsplit(subsetFields[i], "-"))
	subsetFields[i] = paste0(temp[1], temp[3], "axis", temp[2])
	subsetFields[i] = sub("mean\\(\\)", "Mean", subsetFields[i])
	subsetFields[i] = sub("std\\(\\)", "Stdev", subsetFields[i])

**Step 5** - Create a second, independent tidy data set with the average of each variable for each activity and each subject. Save the resultant data as a text file.
	
	finalDataSet <- aggregate(subsetData[, 4:69], list(subsetData$subjectID, subsetData$activityID, subsetData$activityName), mean) 
	finalDataSet <- finalDataSet[ order(finalDataSet[,1], finalDataSet[,2]), ]
	names(finalDataSet)[1] <- "subjectID"
	names(finalDataSet)[2] <- "activityID"
	names(finalDataSet)[3] <- "activityName"


##Variables
The following section describes the variables in the tidy data set. 

* subjectID<br /> - *Subject ID Number*
* activityID<br /> - *Activity ID Number*
* activityName<br /> - *Activity Name*
* tBodyAccXaxisMean<br />	- *Time Domain - Body Acceleration X-axis Signal Mean Value*
* tBodyAccYaxisMean<br />	- *Time Domain - Body Acceleration Y-axis Signal Mean Value*
* tBodyAccZaxisMean<br />	- *Time Domain - Body Acceleration Z-axis Signal Mean Value*
* tBodyAccXaxisStdev<br />	- *Time Domain - Body Acceleration X-axis Signal Standard Deviation Value*
* tBodyAccYaxisStdev<br />	- *Time Domain - Body Acceleration Y-axis Signal Standard Deviation Value*
* tBodyAccZaxisStdev<br />	- *Time Domain - Body Acceleration Z-axis Signal Standard Deviation Value*
* tGravityAccXaxisMean<br />	- *Time Domain - Gravity Acceleration X-axis Signal Mean Value*
* tGravityAccYaxisMean<br />	- *Time Domain - Gravity Acceleration Y-axis Signal Mean Value*
* tGravityAccZaxisMean<br />	- *Time Domain - Gravity Acceleration Z-axis Signal Mean Value*
* tGravityAccXaxisStdev<br />	- *Time Domain - Gravity Acceleration X-axis Signal Standard Deviation Value*
* tGravityAccYaxisStdev<br />	- *Time Domain - Gravity Acceleration Y-axis Signal Standard Deviation Value*
* tGravityAccZaxisStdev<br />	- *Time Domain - Gravity Acceleration Z-axis Signal Standard Deviation Value*
* tBodyAccJerkXaxisMean<br />	- *Time Domain - Body Acceleration Jerk X-axis Signal Mean Value*
* tBodyAccJerkYaxisMean<br />	- *Time Domain - Body Acceleration Jerk Y-axis Signal Mean Value*
* tBodyAccJerkZaxisMean<br />	- *Time Domain - Body Acceleration Jerk Z-axis Signal Mean Value*
* tBodyAccJerkXaxisStdev<br />	- *Time Domain - Body Acceleration Jerk X-axis Signal Standard Deviation Value*
* tBodyAccJerkYaxisStdev<br />	- *Time Domain - Body Acceleration Jerk Y-axis Signal Standard Deviation Value*
* tBodyAccJerkZaxisStdev<br />	- *Time Domain - Body Acceleration Jerk Z-axis Signal Standard Deviation Value*
* tBodyGyroXaxisMean<br />	- *Time Domain - Body Gyroscope X-axis Signal Mean Value*
* tBodyGyroYaxisMean<br />	- *Time Domain - Body Gyroscope Y-axis Signal Mean Value*
* tBodyGyroZaxisMean<br />	- *Time Domain - Body Gyroscope Z-axis Signal Mean Value*
* tBodyGyroXaxisStdev<br />	- *Time Domain - Body Gyroscope X-axis Signal Standard Deviation Value*
* tBodyGyroYaxisStdev<br />	- *Time Domain - Body Gyroscope Y-axis Signal Standard Deviation Value*
* tBodyGyroZaxisStdev<br />	- *Time Domain - Body Gyroscope Z-axis Signal Standard Deviation Value*
* tBodyGyroJerkXaxisMean<br />	- *Time Domain - Body Gyroscope Jerk X-axis Signal Mean Value*
* tBodyGyroJerkYaxisMean<br />	- *Time Domain - Body Gyroscope Jerk Y-axis Signal Mean Value*
* tBodyGyroJerkZaxisMean<br />	- *Time Domain - Body Gyroscope Jerk Z-axis Signal Mean Value*
* tBodyGyroJerkXaxisStdev<br />	- *Time Domain - Body Gyroscope Jerk X-axis Signal Standard Deviation Value*
* tBodyGyroJerkYaxisStdev<br />	- *Time Domain - Body Gyroscope Jerk Y-axis Signal Standard Deviation Value*
* tBodyGyroJerkZaxisStdev<br />	- *Time Domain - Body Gyroscope Jerk Z-axis Signal Standard Deviation Value*
* tBodyAccMagMean<br />	- *Time Domain - Body Acceleration Magnitude Signal Mean Value*
* tBodyAccMagStdev<br />	- *Time Domain - Body Acceleration Magnitude Signal Standard Deviation Value*
* tGravityAccMagMean<br />	- *Time Domain - Gravity Acceleration Magnitude Signal Mean Value*
* tGravityAccMagStdev<br />	- *Time Domain - Gravity Acceleration Magnitude Signal Standard Deviation Value*
* tBodyAccJerkMagMean<br />	- *Time Domain - Body Acceleration Jerk Magnitude Signal Mean Value*
* tBodyAccJerkMagStdev<br />	- *Time Domain - Body Acceleration Jerk Magnitude Signal Standard Deviation Value*
* tBodyGyroMagMean<br />	- *Time Domain - Body Gyroscope Magnitude Signal Mean Value*
* tBodyGyroMagStdev<br />	- *Time Domain - Body Gyroscope Magnitude Signal Standard Deviation Value*
* tBodyGyroJerkMagMean<br />	- *Time Domain - Body Gyroscope Jerk Magnitude Signal Mean Value*
* tBodyGyroJerkMagStdev<br />	- *Time Domain - Body Gyroscope Jerk Magnitude Signal Standard Deviation Value*
* fBodyAccXaxisMean<br />	- *Frequency Domain - Body Acceleration X-axis Signal Mean Value*
* fBodyAccYaxisMean<br />	- *Frequency Domain - Body Acceleration Y-axis Signal Mean Value*
* fBodyAccZaxisMean<br />	- *Frequency Domain - Body Acceleration Z-axis Signal Mean Value*
* fBodyAccXaxisStdev<br />	- *Frequency Domain - Body Acceleration X-axis Signal Standard Deviation Value*
* fBodyAccYaxisStdev<br />	- *Frequency Domain - Body Acceleration Y-axis Signal Standard Deviation Value*
* fBodyAccZaxisStdev<br />	- *Frequency Domain - Body Acceleration Z-axis Signal Standard Deviation Value*
* fBodyAccJerkXaxisMean<br />	- *Frequency Domain - Body Acceleration Jerk X-axis Signal Mean Value*
* fBodyAccJerkYaxisMean<br />	- *Frequency Domain - Body Acceleration Jerk Y-axis Signal Mean Value*
* fBodyAccJerkZaxisMean<br />	- *Frequency Domain - Body Acceleration Jerk Z-axis Signal Mean Value*
* fBodyAccJerkXaxisStdev<br />	- *Frequency Domain - Body Acceleration Jerk X-axis Signal Standard Deviation Value*
* fBodyAccJerkYaxisStdev<br />	- *Frequency Domain - Body Acceleration Jerk Y-axis Signal Standard Deviation Value*
* fBodyAccJerkZaxisStdev<br />	- *Frequency Domain - Body Acceleration Jerk Z-axis Signal Standard Deviation Value*
* fBodyGyroXaxisMean<br />	- *Frequency Domain - Body Gyroscope X-axis Signal Mean Value*
* fBodyGyroYaxisMean<br />	- *Frequency Domain - Body Gyroscope Y-axis Signal Mean Value*
* fBodyGyroZaxisMean<br />	- *Frequency Domain - Body Gyroscope Z-axis Signal Mean Value*
* fBodyGyroXaxisStdev<br />	- *Frequency Domain - Body Gyroscope X-axis Signal Standard Deviation Value*
* fBodyGyroYaxisStdev<br />	- *Frequency Domain - Body Gyroscope Y-axis Signal Standard Deviation Value*
* fBodyGyroZaxisStdev<br />	- *Frequency Domain - Body Gyroscope Z-axis Signal Standard Deviation Value*
* fBodyAccMagMean<br />	- *Frequency Domain - Body Acceleration Magnitude Signal Mean Value*
* fBodyAccMagStdev<br />	- *Frequency Domain - Body Acceleration Magnitude Signal Standard Deviation Value*
* fBodyBodyAccJerkMagMean<br />	- *Frequency Domain - Body Body Acceleration Jerk Magnitude Signal Mean Value*
* fBodyBodyAccJerkMagStdev<br />	- *Frequency Domain - Body Body Acceleration Jerk Magnitude Signal Standard Deviation Value*
* fBodyBodyGyroMagMean<br />	- *Frequency Domain - Body Body Gyroscope Magnitude Signal Mean Value*
* fBodyBodyGyroMagStdev<br />	- *Frequency Domain - Body Body Gyroscope Magnitude Signal Standard Deviation Value*
* fBodyBodyGyroJerkMagMean<br />	- *Frequency Domain - Body Body Gyroscope Jerk Magnitude Signal Mean Value*
* fBodyBodyGyroJerkMagStdev<br />	- *Frequency Domain - Body Body Gyroscope Jerk Magnitude Signal Standard Deviation Value*

Note: For more information on the variables used in the data set please refer to the ***'features_info.txt'*** in the original data set. The data set is available [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).