# Course Project
#1. Merges the training and the test sets to create one data set.
#2. Extracts only the measurements on the mean and standard deviation for each measurement. 
#3. Uses descriptive activity names to name the activities in the data set
#4. Appropriately labels the data set with descriptive activity names. 
#5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 


# ------------------------------------------------------------------------------------------
# Step 1 - Part 1
# Download data
# downloaded and unzipped file into current working directory
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
 

# Step 1 - Part 2
# Merge Data
trainingDataDir <- "./UCI HAR Dataset/train/"
testDataDir <- "./UCI HAR Dataset/test"

# Listing of text files in the training folder
trainingDataFiles <- list.files(path = trainingDataDir, pattern = ".txt", all.files = FALSE,
                                  full.names = TRUE, recursive = FALSE,
                                  ignore.case = FALSE, include.dirs = FALSE, no.. = FALSE)

# Listing of text files in the test folder
testDataFiles <- list.files(path = testDataDir, pattern = ".txt", all.files = FALSE,
                                  full.names = TRUE, recursive = FALSE,
                                  ignore.case = FALSE, include.dirs = FALSE, no.. = FALSE)

# Merge subject data
subjectMergedData <- rbind(read.table(trainingDataFiles[1]), read.table(testDataFiles[1]))
# Merge X_Train.txt and X_Test.txt data
xMergedData <- rbind(read.table(trainingDataFiles[2]), read.table(testDataFiles[2]))
# Merge Y_Train.txt and Y_Test.txt data
yMergedData <- rbind(read.table(trainingDataFiles[3]), read.table(testDataFiles[3]))

# Now combine all data sets
allMergedData <- cbind(subjectMergedData, yMergedData, xMergedData)

# ------------------------------------------------------------------------------------------

# Step 2
# Extract measurements that are mean or standard deviation of measurements
# Read field names from features.txt file
fieldNamesFile <- "./UCI HAR Dataset/features.txt"
allFieldNames <- read.table(fieldNamesFile)$V2

# Add header to the merged data set
names(allMergedData) <- c("subjectID", "activityID", as.vector(allFieldNames))

# Find which fields have 'mean()' or 'std()' in the column name and create a subset
subsetFields <- c("subjectID", "activityID", as.vector(allFieldNames[grep("mean\\(\\)|std\\(\\)", allFieldNames)]))
subsetData <- allMergedData[, subsetFields]

# ------------------------------------------------------------------------------------------

# Step 3
# Uses descriptive activity names to name the activities in the data set
# Read activity names from activity_labels.txt file
activityNamesFile <- "./UCI HAR Dataset/activity_labels.txt"
activityData <- read.table(activityNamesFile)
names(activityData) <- c("activityID", "activityName")

# Merge with subset data set to get descriptive activities in each row
subsetData <- merge(subsetData, activityData, by = "activityID")

# Reorder columns for better readability
subsetData <- subsetData[, c(2, 1, 69, 3:68)]
subsetFields <- names(subsetData)

# ------------------------------------------------------------------------------------------

# Step 4
# Rename the field names in the dataset to improve readability
for(i in 1:length(subsetFields))
{
        temp = unlist(strsplit(subsetFields[i], "-"))
        if(length(temp) == 2)
        {
                subsetFields[i] = paste0(temp[1], temp[2])
        }
        else if(length(temp) > 2)
        {
                subsetFields[i] = paste0(temp[1], temp[3], "axis", temp[2])
        }
        subsetFields[i] = sub("mean\\(\\)", "Mean", subsetFields[i])
        subsetFields[i] = sub("std\\(\\)", "Stdev", subsetFields[i])
}

names(subsetData) <- subsetFields

# ------------------------------------------------------------------------------------------

# Step 5 - Part 1
# Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

finalDataSet <- aggregate(subsetData[, 4:69], list(subsetData$subjectID, subsetData$activityID, subsetData$activityName), mean) 
finalDataSet <- finalDataSet[ order(finalDataSet[,1], finalDataSet[,2]), ]
names(finalDataSet)[1] <- "subjectID"
names(finalDataSet)[2] <- "activityID"
names(finalDataSet)[3] <- "activityName"


# Step 5 - Part 2
# Save the resultant data as a text file.

dir.create("./UCI HAR Dataset/results")
write.table(finalDataSet, file = "./UCI HAR Dataset/results/tidy_data_set.txt", append = FALSE, quote = TRUE, sep = " ",
            eol = "\n", na = "NA", dec = ".", row.names = FALSE,
            col.names = TRUE, qmethod = c("escape", "double"),
            fileEncoding = "")

# ------------------------------------------------------------------------------------------

