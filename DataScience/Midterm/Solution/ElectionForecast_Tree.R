#Election Forecasting (Tree)

#Reading Imputed Dataset
Polls <- read.csv("PollingData_Imputed.csv")

#Forming a table for description of variables
Polls_desc <- cbind(colnames(Polls), c("Name of State","Election Year", "%age of people who polled Republcan - % age of people who polled Democrat", "%age of people who polled Republcan - % age of people who polled Democrat", "Number of Polls for Republican - Number of Polls for Democrat", "Number of Polls for Republicans/Total number of Polls", "1 if Republicans won state, 0 if Democrats won state"))

#Checking structure of Polls
dim(Polls)
str(Polls)

#Converting to factors & Taking Subset
Polls$Year <- as.factor(Polls$Year)
Polls$Republican <- as.factor(Polls$Republican)
Polls2 <- Polls[2:7]
#summary(Polls$State)

#For understanding the shady behavior
set.seed(1)
train <- sample(1:nrow(Polls2), size = (0.8*(nrow(Polls2))))

#Modelling using Tree
library(tree)

#Tree1 <- tree(Republican ~. ,  data = Polls2, subset = train)
Tree1 <- tree(Republican ~. ,  data = Polls2)
plot(Tree1)
text(Tree1, cex = 0.6)

#Tree1_preds <- predict(Tree1, newdata = Polls2[-train,], type = 'class')
#error <- mean(Tree1_preds != Polls2$Republican[-train])

Tree1_preds <- predict(Tree1, newdata = Polls2, type = 'class')
error <- mean(Tree1_preds != Polls2$Republican)

error

#Choosing optimum size

CV_Tree1 <- cv.tree(Tree1, FUN = prune.misclass)
cbind(size = CV_Tree1$size, par =  CV_Tree1$k, err = CV_Tree1$dev)

#Pruning Tree
Tree2 <- prune.misclass(Tree1, best = 4)
plot(Tree2)
text(Tree2)

#After assessing shady behaviour
Tree1 <- tree(Republican ~., data = Polls2)
Tree2 <- prune.misclass(Tree1, best = 2)
plot(Tree2)
text(Tree2)

#rpart is the bomb.
library(rpart)

Tree3 <- rpart(Republican ~. ,  data = Polls2)
plot(Tree3)
text(Tree3, cex = 0.8)
