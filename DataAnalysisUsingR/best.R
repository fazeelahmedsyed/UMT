best <- function (state, outcome) {
        
        # reading selected columns from the table
        
        factor_vector <- c("NULL",NA ,rep("NULL",4),NA ,rep("NULL",3),NA ,rep("NULL",5),NA ,rep("NULL",5),NA ,rep("NULL",23))
        best_table1 <- read.csv("outcome-of-care-measures.csv", colClasses = factor_vector)
        names(best_table1) <- c("Hospital.Name","State","HEART ATTACK","HEART FAILURE","PNEUMONIA")
        
        # validating inputs
        
        if (!(state %in% best_table1$State))
                {stop("invalid state")}
        
        else if (!((toupper(outcome)) %in% c("HEART ATTACK", "HEART FAILURE", "PNEUMONIA")))
                                  {stop("invalid outcome")}
        
        # Subsetting and sorting table
        
        else {  Subset_state <- subset(best_table1, State == state)
                
                vector1 <- c("Hospital.Name", "State", toupper(outcome))
                Subset_outcome <- subset(Subset_state, select = vector1) 
                names(Subset_outcome) <- c("Hospital.Name", "State", "Outcome")
                trans_df1 <- transform(Subset_outcome, Outcome = as.character(Outcome), Hospital.Name = as.character(Hospital.Name), State = as.character(State))
                trans_df2 <- transform(trans_df1, Outcome = as.numeric(Outcome))
                Clean_outcome <- trans_df2[complete.cases(trans_df2),]
                Sorted_outcome <- Clean_outcome[order(Clean_outcome[,3], Clean_outcome[,1]),]
                Sorted_outcome[1,1]
        }
}