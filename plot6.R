## Question:
## Compare emissions from motor vehicle sources in Baltimore City with emissions 
## from motor vehicle sources in Los Angeles County, California (fips == "06037"). 
## Which city has seen greater changes over time in motor vehicle emissions?
##
## Approach:
## 1. Subset emissions that satisfy the criteria, mortor vehicle realted emissions (type == "ON-ROAD"),
##    from Baltimore City (fips == "24510) and from Los Angeles County (fips == "06370")
## 2. Use quick plot to show the emissions in these two cities during 1999-2008.
## 3. Add another plot on the same page to show the changes of emissions during three periods of time,
##    1999-2002, 2002-2005, and 2005-2008
## 4. Also look at the overall changes (the differences between 2008 and 1999)
##
## Result:
## 1. On the right side of plot6.png, showed that the changes in Los Angeles during 
##    the periods of time, from 1999 to 2002, from 2002 to 2005, and from 2005 to 2008 
##    have seen greater than the changes in Baltimore City.
## 2. But if we only look at the differences between year 2008 and year 1999 in these 
##    two cities, the overall change in Baltimore is greater that the overall change in 
##    Los Angeles.

## setwd("~/coursera/exdata-008/ExData_Project2/")
## source("getFiles.R")

## Include the packages
library(plyr)
library(ggplot2)
library(grid) # for multiple plot in ggplot2
library(gridExtra) # for multiple plot in ggplot2 

## Read the rds data in
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Subset NEI data that satisfies the criteria,
## 1. from motor vehicle sources, (type == "ON-ROAD")
## 2. from Baltimore City, (fips == "24510") or Los Angeles County, (fips == "06037")
subdata <- NEI[NEI$type == "ON-ROAD" & NEI$fips %in% c("24510", "06037"),]

## Replace the zipcodes with city names for better annotations
subdata[subdata$fips == "24510", ] <- mutate(subdata[subdata$fips == "24510", ], 
                                             fips = "BaltimoreCity")
subdata[subdata$fips == "06037", ] <- mutate(subdata[subdata$fips == "06037", ], 
                                             fips = "LosAngelesCounty")
## Change coloumn name to "city" for better legend labels
names(subdata)[1] <- "city"

## Aggregate the data over the years
aggsubdata <- aggregate(Emissions ~ year + city,
                        data = subdata,
                        FUN = sum,
                        na.rm = TRUE)

## Make a table for comparing the changes of PM2.5 emissions from Baltimore City and
## Los Angeles County
diffDF <- ddply(aggsubdata, .(city), summarize, EmissionsChanges = diff(Emissions))
diffDF$Time <- rep(c("1999-2002", "2002-2005", "2005-2008"), 2)
print(diffDF)

## For better understanding the overall changes from 1999-2008
overallChange <- ddply(diffDF, .(city), summarize, OverallChanges = sum(EmissionsChanges))
print(overallChange)

## Call the graphics device, and save the plot as plot6.png with 480x480 pixels
png(filename = "./plot6.png",
    width = 480,
    height = 480,
    units = "px")

## Plot the aggregated data
p <- qplot(year, Emissions,
          data = aggsubdata,
          color = city,
          xlab = "Year",
          ylab = "PM2.5 emissions from motor vehicle sources (tons / year)") + 
          labs(title = "Motor vehicle related PM2.5 emissions \n in Baltimore and Los Angeles") +
          theme(plot.title = element_text(size = 12)) +
          geom_line() + theme(legend.position = "bottom")

## Add another plot to show the changes of PM2.5 emissions in Baltimore City and in 
## Los Angeles County during the periods of time, 1999-2002, 2002-2005, 2005-2008
q <-  qplot(Time, EmissionsChanges, 
            data = diffDF, 
            color = city, 
            facets = city ~.,
            ylab = "Changes of PM2.5 emissions") + 
            labs(title = "PM2.5 emissions changes during \n 1999-2002, 2002-2005, 2005-2008") +
            theme(plot.title = element_text(size = 12)) +
            geom_bar(stat = "identity", fill = "white") + 
            coord_cartesian(ylim = c(-510:510)) + 
            theme(legend.position = "bottom")

## Two plots in one page
suppressWarnings(grid.arrange(p, q, ncol = 2))

dev.off()