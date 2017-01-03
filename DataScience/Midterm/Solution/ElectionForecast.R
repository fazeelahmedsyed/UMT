#Election Forecasting

#Reading Imputed Dataset
Polls <- read.csv("PollingData_Imputed.csv")

#Checking structure of Polls
dim(Polls)
str(Polls)

#Forming a table for description of variables
Polls_desc <- data.frame(colnames(Polls), c("Name of State","Election Year", "%age of people who polled Republcan - % age of people who polled Democrat", "%age of people who polled Republcan - % age of people who polled Democrat", "Number of Polls for Republican - Number of Polls for Democrat", "Number of Polls for Republicans/Total number of Polls", "1 if Republicans won state, 0 if Democrats won state"))

#Splitting Data on the basis of year
Polls$State <- as.character(levels(Polls$State)[Polls$State])
Polls$Year <- as.factor(Polls$Year)
Polls_split <- split(Polls, Polls$Year)
Polls_2004 <- Polls_split[[1]] 
Polls_2008 <- Polls_split[[2]]
Polls_2012 <- Polls_split[[3]]

#Checking our new data
dim(Polls_2004)
dim(Polls_2008)
dim(Polls_2012)

#Checking and removing missing values
summary(Polls_2004$State == Polls_2008$State) #All match :)
States_vector <- (Polls_2008$State %in% Polls_2012$State)
Polls_2004 <- Polls_2004[States_vector,]
Polls_2008 <- Polls_2008[States_vector,]

#Renaming Column names
colnames(Polls_2004)[3:7] <- paste("200",(colnames(Polls_2004)[3:7]), sep = "4")
colnames(Polls_2008)[3:7] <- paste("200",(colnames(Polls_2008)[3:7]), sep = "8")
colnames(Polls_2012)[3:7] <- paste("201",(colnames(Polls_2012)[3:7]), sep = "2")

#Merging Data frames
Polls_all <- cbind((Polls_2004[,c(1,3:7)]), (Polls_2008[3:7]),(Polls_2012[3:7]))
dim(Polls_all)
head(Polls_all,10)

#Splitting our data into a test and a train set
set.seed(1)
train <- sample(c(T,F), size = nrow(Polls_all), replace = T, prob = c(0.75,0.25))
test <- (!(train)) 

#Creating a Logistic Regression Model
colnames(Polls_all)[16] <- "Republican"
Polls_all$Republican <- as.factor(Polls_all$Republican)
Polls_all[,6] <- as.factor(Polls_all[,6])
Polls_all[,11] <- as.factor(Polls_all[,11])

glm_fit <- glm(Republican ~ ., data = Polls_all[,2:16], subset = train, family = binomial)
summary(glm_fit)
contrasts(Polls_all$Republican)

#Coefficients of the Logit 
coef(glm_fit)

#Making Predictions on test set
glm_probs <- predict(glm_fit, newdata = (Polls_all[,2:16])[test,], type = "response")
glm_preds <- rep("0", length(glm_probs))
glm_preds[glm_probs >= 0.5] = "1"
glm_preds <- as.factor(glm_preds)

#Making a confusion matrix
Prediction <- glm_preds
Actual <- Polls_all$Republican[test]
conf <- addmargins(table(Prediction, Actual))
conf

#Calculating error rates
error <- (conf[2,1]+conf[1,2])/conf[3,3]
TPR <- conf[2,2]/conf[3,2]
FPR <- conf[2,1]/conf[3,1]

#Comparing if the model added any value
sum(Polls_all$Republican == 1)/length(Polls_all$Republican)
sum(conf[1,1]+conf[2,2])/conf[3,3]
