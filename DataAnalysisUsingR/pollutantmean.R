pollutantmean <- function(directory, pollutant, id= 1:332) {
        observations_vector <- numeric(0)
        for(i in id){
                
                file_path <- paste(directory,"/",formatC(i,width = 3, flag = "0"),".csv",sep ="")
                monitor_file <- read.csv(file_path)
                int_vector <- monitor_file[,pollutant]
                pollutant_vector <- int_vector[!is.na(int_vector)]
                
                observations_vector <- c(observations_vector,pollutant_vector)
        }
        
        mean_observations <- mean(observations_vector)
        mean_observations
        
}