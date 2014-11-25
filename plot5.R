## Question:
## How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
##
## Approach:
## 1. Subet the emission data from motor vehicles in Baltimore City.
## 2. Use the base plot system make a plot showing the total emissions from motor vehicle sources in
##    Baltimore City during 1999-2008.
##
## Result:
## From plot5.png, we can see that the PM2.5 emissions from motor vehicle sources in Baltimore City 
## have kept decreasing during 1999 to 2008.

## setwd("~/coursera/exdata-008/ExData_Project2/")
## source("getFiles.R")

## Read the rds data in
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Subset NEI data that satisfies the criteria,
## 1. in Baltimore City, (fips == "24510")
## 2. from motor vehicle sources, (type == "ON-ROAD")
BALOnRoadData <- NEI[NEI$fips == "24510" & NEI$type == "ON-ROAD", ]

## Aggregate the subset data over the years
## 1. use function, aggregate or 2. use ddply(data, .(year), summarize, Emissions = sum(Emissions))
aggBALOnRoad <- aggregate(Emissions ~ year, 
                            data = BALOnRoadData,
                            FUN = sum,
                            na.rm = TRUE)

## Call the graphics device, and save the plot as plot4.png with 480x480 pixels.
png(filename = "./plot5.png",
    width = 480,
    height = 480,
    units = "px")

## Plot the aggregated data
plot(aggBALOnRoad,
     type = "l",
     col = "blue",
     main = "Motor vehicle related PM2.5 emissions in Baltimore (1999-2008)",
     xlab = "Year",
     ylab = "PM2.5 emissions from motor vehicle sources (tons / year)")

dev.off()