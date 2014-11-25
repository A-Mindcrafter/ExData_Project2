## Question:
## Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?
##
## Approach:
## 1. Idenfity the SCC by EI.Sector, "Fuel Comb - Electric Generation - Coal", and subset the NEI data
##    with the corresponding SCC. 
## 2. Use the base plot system make a plot showing the total emissions from coal combustion-related sources during
##    1999-2008.
##
## Result:
## From plot4.png, we can see that the overall trend is decreasing. 
## Only it was slightly increasing from 2002 to 2005.
## So we can conclude that the emissions from coal combustion-related sources overall decreased from 1999–2008.

## setwd("~/coursera/exdata-008/ExData_Project2/")
## source("getFiles.R")

## Read the rds data in
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Use regular expression, grep, to serach EI.Sector from the SCC table and 
## find all the sources with the keyword, "Coal"
## This will return the row indeces that satisfy the search criteria.
isCoal <- grep("Coal", SCC$EI.Sector)

## Use the row indeces that I just identified to get the corresponding SCC from SCC table, column 1 and
## subset NEI data by the corresponding SCC. 
coalData <- NEI[NEI$SCC %in% SCC[isCoal,1],]

## Aggregate the subset data over the years
aggCoalData <- aggregate(Emissions ~ year, 
                         data = coalData, 
                         FUN = sum, 
                         na.rm = TRUE)

## Call the graphics device, and save the plot as plot4.png with 480x480 pixels
png(filename = "./plot4.png",
    width = 480,
    height = 480,
    units = "px")

## Plot the aggregated data
plot(aggCoalData,
     type = "l",
     col = "green",
     main = "Coal related PM2.5 emissions accross the U.S. from 1999-2008",
     xlab = "Year",
     ylab = "Coal related PM2.5 emissions (tons / year)")

dev.off()