complete <- function (directory, id) {
        
        nobs <- numeric()
        for(i in id) {
                
                file_path <- paste(directory,"/",formatC(i,width = 3, flag = "0"),".csv",sep ="")        
                monitor_file <- read.csv(file_path)
                c_cases_sul <- complete.cases(monitor_file[,"sulfate"])
                c_cases_nit <- complete.cases(monitor_file[,"nitrate"])
                c_cases_chk <- c_cases_sul & c_cases_nit
                c_cases <- sum(c_cases_chk)
                nobs <- c(nobs,c_cases)
                
        }
        
        table1 <- data.frame(id,nobs)
        table1
}

corr <- function (directory, threshold = 0){

        nobs_table <- complete(directory, id = 1:332)
        id_vector <- nobs_table[nobs_table["nobs"] > threshold,]$id
        cor_vector <- numeric()
        
                for (j in id_vector){
                file_path <- paste(directory,"/",formatC(j,width = 3, flag = "0"),".csv",sep ="")
                monitor_file <- read.csv(file_path)
                c_cases <- complete.cases(monitor_file)
                table2 <- monitor_file[c_cases,]
                cor_vector <- c(cor_vector,cor(table2$sulfate, table2$nitrate))
                }
        cor_vector
}

        