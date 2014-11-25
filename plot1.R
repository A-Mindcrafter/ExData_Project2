## Question: 
## Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?
##
## Approach:
## Using the base plotting system, make a plot showing the total PM2.5 emission from 
## all sources over the years from 1999 to 2008.
##
## Result:
## From plot1.png, we can see that the total PM2.5 emissions have decreased over the years

## setwd("~/coursera/exdata-008/ExData_Project2/")
## source("getFiles.R")

## Read the rds data in
NEI <- readRDS("./summarySCC_PM25.rds")
SCC <- readRDS("./Source_Classification_Code.rds")

## Calculate the aggregate emissions by individual year
aggData <- aggregate(Emissions ~ year, 
                     data = NEI, 
                     FUN = sum, 
                     na.rm = TRUE)

## Call the graphic device, and save the plot as plot1.png with 480x480 pixels
png(filename = "./plot1.png", 
    width = 480, 
    height = 480, 
    units = "px")

## Plot the aggregated data of total PM2.5 emissions over the years
plot(aggData, 
     type = "l", 
     col = "blue",
     xlab = "Year",
     ylab = "PM2.5 emissions from all sources (tons / year)",
     main = "Total PM2.5 emissions accross the U.S. from 1999-2008")

dev.off()