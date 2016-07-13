# By Zach Eisenstein for Coursera: Getting and Cleaning Data (Assignment) 2016 July


# Download the data and put it in a folder called data

if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/Dataset.zip")

# Unzip the files

unzip(zipfile="./data/Dataset.zip",exdir="./data")

# Unzipped files are in a folder called "UCI HAR Dataset"
# Take a look at the complete list of files

path_rf <- file.path("./data" , "UCI HAR Dataset")
files<-list.files(path_rf, recursive=TRUE)
files

# For the purposes of this assignment, the inertial signals files will not be used

# load test data
subject_test <- read.table(file.path(path_rf, "test", "subject_test.txt"))
x_test <- read.table(file.path(path_rf, "test", "x_test.txt"))
y_test <- read.table(file.path(path_rf, "test", "y_test.txt"))

# load training data
subject_train <- read.table(file.path(path_rf, "train", "subject_train.txt"))
x_train <- read.table(file.path(path_rf, "train", "x_train.txt"))
y_train <- read.table(file.path(path_rf, "train", "y_train.txt"))

# load supporting metadata
features_labels <- read.table(file.path(path_rf, "features.txt"), col.names = c("featureId", "featureLabel"))
activity_labels <- read.table(file.path(path_rf, "activity_labels.txt"), col.names = c("activityId", "activityLabel"))

# merge the training and test sets
subject <- rbind(subject_train, subject_test)
features <- rbind(x_train, x_test)
activity <- rbind(y_train, y_test)

# place column headings from features.txt file
colnames(features) <- t(features_labels[2])

# add column headings and merge all three tables
colnames(subject) <- "Subject"
colnames(activity) <- "Activity"
data_full <- cbind(subject, activity, features)

# grab only those columns with mean or standard deviation metrics
included_features <- grep(".*Mean.*|.*Std.*", names(data_full), ignore.case=TRUE)

req_col <- c(1, 2, included_features)

data_extract <- data_full[,req_col]


# The activity field is originally numeric
# Change its type to character so that it can accept activity names
# The activity names are taken from metadata activity_labels

data_extract$Activity <- as.character(data_extract$Activity)
for (i in 1:6){
        data_extract$Activity[data_extract$Activity == i] <- as.character(activity_labels[i,2])
}


# Set both Subject and Activity as factor variables
data_extract$Activity <- as.factor(data_extract$Activity)
data_extract$Subject <- as.factor(data_extract$Subject)

# Rename feature variables so that they are more readable
names(data_extract)<-gsub("Acc", "Accelerometer", names(data_extract))
names(data_extract)<-gsub("Gyro", "Gyroscope", names(data_extract))
names(data_extract)<-gsub("BodyBody", "Body", names(data_extract))
names(data_extract)<-gsub("Mag", "Magnitude", names(data_extract))
names(data_extract)<-gsub("^t", "Time", names(data_extract))
names(data_extract)<-gsub("^f", "Frequency", names(data_extract))
names(data_extract)<-gsub("tBody", "TimeBody", names(data_extract))
names(data_extract)<-gsub("-mean()", "Mean", names(data_extract), ignore.case = TRUE)
names(data_extract)<-gsub("-std()", "STD", names(data_extract), ignore.case = TRUE)
names(data_extract)<-gsub("-freq()", "Frequency", names(data_extract), ignore.case = TRUE)
names(data_extract)<-gsub("angle", "Angle", names(data_extract))
names(data_extract)<-gsub("gravity", "Gravity", names(data_extract))


#Export tidy data set
data_extract <- data.table(data_extract)

tidy <- aggregate(. ~Subject + Activity, data_extract, mean)
tidy <- tidy[order(tidy$Subject,tidy$Activity),]
write.table(tidy, file = "Tidy.txt", row.names = FALSE)
