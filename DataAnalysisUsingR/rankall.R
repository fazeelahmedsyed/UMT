rankall <- function (outcome, num = "best") {

# reading selected columns from the table

factor_vector <- c("NULL",NA ,rep("NULL",4),NA ,rep("NULL",3),NA ,rep("NULL",5),NA ,rep("NULL",5),NA ,rep("NULL",23))
best_table1 <- read.csv("outcome-of-care-measures.csv", colClasses = factor_vector)
names(best_table1) <- c("Hospital.Name","State","HEART ATTACK","HEART FAILURE","PNEUMONIA")

# validating inputs

if (!((toupper(outcome)) %in% c("HEART ATTACK", "HEART FAILURE", "PNEUMONIA")))
{stop("invalid outcome")}

# Cleaning Data

else {  vector1 <- c("Hospital.Name", "State", toupper(outcome))
Subset_outcome <- subset(best_table1, select = vector1) 
names(Subset_outcome) <- c("Hospital.Name", "State", "Outcome")
trans_df1 <- transform(Subset_outcome, Outcome = as.character(Outcome), Hospital.Name = as.character(Hospital.Name), State = as.character(State))
trans_df2 <- transform(trans_df1, Outcome = as.numeric(Outcome))
Clean_outcome <- trans_df2[complete.cases(trans_df2),]

#splitting data into a list state-wise (dataframes)

state_list <- split(Clean_outcome, Clean_outcome$State)

#Applying formula to each dataframe        
ans <- lapply(state_list, function(x,num) {
        
        x = x[order(x$Outcome,x$Hospital.Name),]
        
        if(num %in% c("best","BEST", "Best")) { x$Hospital.Name[1] }
        else if (num %in% c("worst", "Worst", "WORST",nrow(x))) {x$Hospital.Name[nrow(x)]}
        else {x$Hospital.Name[num]}
},num) }


# Conjoining data frame
return(data.frame(Hospital = unlist(ans), State = names(ans) ))

}
