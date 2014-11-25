## Question:
## Have total emissions from PM2.5 decreased 
## in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008?
##
## Approach:
## Use the base plotting system to make a plot answering this question.
##
## Result:
## From Plot2.png, we can see that the total PM2.5 emissions in Baltimore City overall has decreased 
## from 1999 to 2008

## setwd("~/coursera/exdata-008/ExData_Project2/")
## source("getFiles.R")

## Read the rds data in
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Subet the emission data only from Baltimore City, Maryland (fips == "24150")
BALData <- NEI[NEI$fips == "24510",]

## Aggregate the data over the years
aggBALData <- aggregate(Emissions ~ year,
                        data = BALData, 
                        FUN = sum, 
                        na.rm = TRUE)

## Call the graphics device, and save the plot as plot2.png with 480x480 pixels
png(filename = "./plot2.png", 
    width = 480, 
    height = 480, 
    units  = "px")

## Plot the aggregated data of PM2.5 emissions in Baltimore City over the years
plot(aggBALData,
     type = "l",
     col = "red",
     xlab = "Year",
     ylab = "PM2.5 emissions from all sources (tons / year)",
     main = "Total PM2.5 emissions in Baltimore City from 1999-2008")
dev.off()