getURL("http://stats.grok.se/json/en/201410/Friday")
rawData <- getURL("http://stats.grok.se/json/en/201410/Friday")
rawData
install.packages("RJSONIO")  # Install the JSON parser
library(RJSONIO)  # Load the JSON parser
parsedData <- fromJSON(rawData)
parsedData$daily_views
names(parsedData$daily_views)
data.frame(Date=names(parsedData$daily_views),  # get the names
           Views=parsedData$daily_views)  # get the data points
data.frame(Date=names(parsedData$daily_views),  # get the names
           Views=parsedData$daily_views,  # get the data points
           row.names=NULL)  # tell R to stop using the dates as names
viewsData <- data.frame(Date=names(parsedData$daily_views),  # get the names
                        Views=parsedData$daily_views,  # get the data points
                        row.names=NULL)   # stop using the dates as names
str(viewsData)
viewsData$Date <- as.Date(viewsData$Date)
viewsData[order(viewsData$Date),]
viewsData <- viewsData[order(viewsData$Date),]
install.packages("ggplot2")
library(ggplot2)
ggplot(data=viewsData,  # Make a plot using our views data
       aes(x=Date,  # with Date on the x-axis
           y=Views,  # and Views on the y-axis
           group=1)) +  # Use all the data as one data series
        geom_line()  # and draw a line of this data
