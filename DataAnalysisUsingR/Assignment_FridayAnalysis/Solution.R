#This script is for Accumulating Daily views of Wikipedia's Friday page from 2008 to 2012.

#Loading Dependencies
library(RCurl)
library(RJSONIO)

#Creating a Loop to extract all data:
finalData <- data.frame(Date = numeric(0), Views = integer(0))
for (i in 2008:2012){
        for (j in 1:12){
                link <- paste("http://stats.grok.se/json/en/",i, formatC(j, width = 2, flag = 0),"/Friday", sep = "")
                rawData <- getURL(link)
                parsedData <- fromJSON(rawData)
                viewsData <- data.frame(Date = names(parsedData$daily_views), Views = parsedData$daily_views, row.names = NULL)
                finalData <- rbind(finalData, viewsData)
        }
}

#Performing Cleaning operations to compiled Data
fd_raw <- finalData #Keeping a copy
finalData$Date <- as.Date(finalData$Date)
finalData <- finalData[order(finalData$Date),]
finalData <- finalData[complete.cases(finalData),]

#Let's Look at graphs to find trends
plot(finalData$Date, finalData$Views, col = "dark grey")

#Let's isolate the interesting part
fd_2011 <- finalData[format.Date(finalData$Date, "%Y") == 2011,]
plot(fd_2011$Date, fd_2011$Views, col = "dark grey")

fd_mar11 <- fd_2011[format.Date(fd_2011$Date, "%m") == "03",]
plot(fd_mar11$Date, fd_mar11$Views, col = 'red', type = 'l', lwd = 3)

#What happened on March 14, 2011? 
#...
#"Friday, Friday, Gotta Get down on Friday." Lol. Release Date: 14th March 2011, marked the end of pop music as we know it.