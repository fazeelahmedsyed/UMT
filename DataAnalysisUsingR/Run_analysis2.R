#Downloading and unzipping file

if (!file.exists("./HARdata")){
        dir.create("./HARdata") 
if (!file.exists("./HARdata/HAR.zip")){
        fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        download.file(fileurl, "./HARdata/HAR.zip", mode = wb)
if (!file.exists("./HARdata/UCI HAR Dataset")){
        unzip("./HARdata/HAR.zip", exdir = "./HARdata")}}}

#Reading files & Creating Data frames for Testing and Training sets

feat_csv <- read.csv("./HARdata/UCI HAR Dataset/features.txt", sep = "", header = FALSE)
features <- feat_csv[,2]
features <- as.character(features)

a <- read.csv("./HARdata/UCI HAR Dataset/test/y_test.txt", sep = "", header = FALSE)
b <- read.csv("./HARdata/UCI HAR Dataset/test/subject_test.txt", sep = "", header = FALSE)
c <- read.csv("./HARdata/UCI HAR Dataset/test/x_test.txt", sep = "", header = FALSE)
test <- cbind(a,b,c)
rm(a,b,c)
colnames(test) <- c("Activity", "Subject", 1:561)

l <- read.csv("./HARdata/UCI HAR Dataset/train/y_train.txt", sep = "", header = FALSE)
m <- read.csv("./HARdata/UCI HAR Dataset/train/subject_train.txt", sep = "", header = FALSE)
n <- read.csv("./HARdata/UCI HAR Dataset/train/x_train.txt", sep = "", header = FALSE)
train <- cbind(l,m,n)
rm(l,m,n)
colnames(train) <- c("Activity", "Subject", 1:561)

#Combining Data

allData <- rbind(train, test)
colnames(allData) <- c("Activity", "Subject", features)

#Extracting Mean and Standard Deviation
features2 <- c(1,2,features)
a <- grep("-mean[^Freq]", features2)
b <- grep("-std()", features2)
c <- c(1,2,a,b)

meanStd <- allData[c]
rm(a,b,c)

#Replacing activity labels

activitylabels <- read.csv("./HARdata/UCI HAR Dataset/activity_labels.txt", sep = "", header = FALSE)

k = 1
for (i in activitylabels$V2) {
        meanStd$Activity <- gsub(k, i, meanStd$Activity)
        k = k + 1
}

#Creating Tidy Data set 

meanStd$Activity <- as.factor(meanStd$Activity)
meanStd$Subject <- as.factor(meanStd$Subject)

tidy_data <- aggregate(meanStd, by = list(Activity = meanStd$Activity, Subject = meanStd$Subject), mean)
tidy_data <- tidy_data[,c(1,2,5:70)]

write.table(tidy_data, "tidy.txt", row.names = F, quote = F)