library(plyr)
library(dplyr)
library(reshape2)

# Step 1
# Merge the training and test sets to create one data set
###############################################################################

x.train <- read.table("./data/train/X_train.txt")
y.train <- read.table("./data/train/y_train.txt")
subject.train <- read.table("./data/train/subject_train.txt")

x.test <- read.table("./data/test/X_test.txt")
y.test <- read.table("./data/test/y_test.txt")
subject.test <- read.table("./data/test/subject_test.txt")

# create merged X data set
X <- rbind(x.train, x.test)

# create merged Y.activ data set
Y.activ <- rbind(y.train, y.test)

# create 'subject' data set
subject<- rbind(subject.train, subject.test)

# Step 2
# Extract only the measurements on the mean and standard deviation for each measurement
#######################################################################################
sfeat <- read.table("./data/features.txt", stringsAsFactors=FALSE)[[2]]

# get only columns with mean() or std() in their names
index <- grep("-(mean|std)\\(\\)", sfeat)

# Extract corresponding variables from the X file
newX <- select(X, index)

# Process the feature Names to make them more readable

for (i in 1:length(sfeat))
{
  sfeat[i] = gsub("-std",".std",sfeat[i])
  sfeat[i] = gsub("-mean",".mean",sfeat[i])
  sfeat[i] = gsub("([Bb]ody[Bb]ody|[Bb]ody)","Body",sfeat[i])
  sfeat[i] = gsub("[Gg]yro","Gyro",sfeat[i])
  sfeat[i] = gsub("\\(|\\)", "",sfeat[i])
}

# Step 3
# Use descriptive activity names to name the activities in the data set
###############################################################################

activity <- read.table("./data/activity_labels.txt")

# update values with correct activity names
Y.activ[, 1] <- activity[Y.activ[, 1], 2]

# Step 4
# Appropriately label the data set with descriptive variable names
###############################################################################

# Add activity and subjct variable at the begining of the data
newX <- cbind(subject, Y.activ, newX)

# Add names and labels to X variables
names(newX) <- c("Subject", "Activity", sfeat[index])

# Reorder using the subject and activity
newX <- arrange(newX, Subject, Activity)

# Step 5
# Create a second, independent tidy data set with the average of each variable
# for each activity and each subject
###############################################################################

# Compute the average of each variable using the reshape2 package
meltX <- melt(newX, id.vars = c("Subject", "Activity"))
newX2 <- dcast(meltX, Subject+Activity ~ variable, mean)

# Write down the new data set to the file
write.table(newX2, "./data/tidyX2.txt", sep=" ", row.names = FALSE)







