complete <- function (directory, id= 1:332) {
        
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