#Purpose of this script is to read data from 
#https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
#and convert it into tidy dataset that can be used for processing.
#Assignment details: https://www.coursera.org/learn/data-cleaning/peer/FIZtT/getting-and-cleaning-data-course-project

#RUN_ANALYSIS

#Creating an If loop to ensure we are in the desired working directory
if (length(grep("UCI HAR Dataset$",getwd())) == 0) {
        print ("Change working directory to 'UCI HAR Dataset'")
        
        #Performing tidying operations now        
        } else {
                #Creating a data frame for activity labels
                act_labels <- read.csv("activity_labels.txt", sep ="", header = F)
                colnames(act_labels) <- c("Code","Activity")
                act_labels[,2] <- as.character(act_labels[,2]) #for use later
                 
                #Creating a vector for features
                features <- read.csv("features.txt", sep = "", header = F)
                features <- as.character(features[,2])
                
                #Reading the training set data
                sub <- read.csv("train/subject_train.txt", sep = "", header = F)
                act <- read.csv("train/y_train.txt", sep = "", header = F) 
                data <- read.csv("train/X_train.txt", sep = "", header = F) 
                
                #Combining training set data into one df
                train <- cbind(sub,act,data)
                colnames(train) <- c("Subject", "Activity", 1:561)
                
                #Cleaning environment to save memory
                rm(list = c("sub","act","data"))
                
                #Reading the test data
                sub <- read.csv("test/subject_test.txt", sep = "", header = F)
                act <- read.csv("test/y_test.txt", sep = "", header = F) 
                data <- read.csv("test/X_test.txt", sep = "", header = F)
                
                #Combining test set data into one df
                test <- cbind(sub,act,data)
                colnames(test) <- c("Subject", "Activity", 1:561)
                
                #Cleaning environment to save memory
                rm(list = c("sub","act","data"))
                
                #Combining Training and test data to form one entire Dataset
                HAR <- rbind(train,test)
                
                #Cleaning environment to save memory
                rm(list = c("train","test"))
                
                #Creating Selecting Criteria for only mean and standard deviation measurements
                grep_mean <- grep("-mean()",features, fixed = T) + 2
                grep_std <- grep("-std()", features, fixed = T) + 2
                feature_cols <- c(grep_mean,grep_std)
                
                #Cleaning Environment
                rm(list = c("grep_mean","grep_std"))
                
                #Selecting desired columns
                HAR <- HAR[,c(1,2,feature_cols)]
                
                #Writing column names
                feature_cols <- feature_cols - 2
                feature_cols <- features[feature_cols]
                colnames(HAR) <- c("Observer_ID", "Activity_Name", feature_cols)
                
                #Cleaning Environment
                rm(list = c("feature_cols","features"))
                
                #Replacing Activity Labels
                HAR[,2] <- as.character(HAR[,2])
                for(i in 1:6){
                        k <- as.character(i)
                        l <- act_labels[i,2]
                        HAR[,2] <- gsub(k,l,HAR[,2])
                        }
                
                #Appropriating proper classes to columns
                HAR[,1] <- as.factor(HAR[,1])
                HAR[,2] <- as.factor(HAR[,2])
                
                #Cleaning Environment
                rm(list = c("i","k","l", "act_labels"))
                
                #Creating tidy data
                HAR_split <- split(HAR, list(HAR$Activity_Name,HAR$Observer_ID))
                HAR_means <- lapply(HAR_split, function(df){colMeans(df[,3:68])})
                HAR_colMeans <- do.call(rbind, HAR_means)
                names_split <- strsplit(rownames(HAR_colMeans), split = ".", fixed = T)
                names_split <- do.call(rbind, names_split)
                Averages <- data.frame(names_split,HAR_colMeans)
                rownames(Averages) <- NULL
                colnames(Averages) <- c("Activity_Name","Observer_ID",(colnames(Averages)[3:68]))
                
                #Cleaning environment
                rm(list = c("names_split","HAR_split","HAR_means","HAR_colMeans"))
                
                #Writing the second data frame to a file
                write.table(Averages, "Averages.txt")
                
                }
