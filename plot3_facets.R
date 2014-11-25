## Questions:
## Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
## which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? 
## Which have seen increases in emissions from 1999–2008? 
##
## Approach:
## Use the ggplot2 plotting system to make a plot answer this question.
## I also use facets (panels) to plot the data in different types (point, nonpoint, onroad, nonroad).
## 
## Result:
## From plot3.png, we can see that the PM2.5 emissions from sources in Baltimore City, 
## nonpoint, onroad, nonroad have decreased from 1999-2008.
## Only the PM2.5 emissions from "point" has increased from 1999-2005.

## setwd("~/coursera/exdata-008/ExData_Project2/")
## source("getFiles.R")

## Include "ggplot2" package
library(ggplot2)
library(grid)

## Read the rds data in
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Subet the data only from Baltimore City, Maryland (fips == "24150")
BALData <- NEI[NEI$fips == "24510",]

## Aggregate the data over the years and emission types
aggBALData <- aggregate(Emissions ~ type + year, 
                        data = BALData, 
                        FUN = sum, 
                        na.rm = TRUE)

## Call the graphics device, and save the plot as plot3.png with 480x480 pixels
png(filename = "./plot3_facets.png", 
    width = 480, 
    height = 480, 
    units = "px")

## Quickplot the aggregated data of PM2.5 emissions by different sources (types)
## in Baltimore City over the years
## Use "colors" and "facets" to annotate the emission types
p <- qplot(year, Emissions, 
          data = aggBALData,
          geom = "point",
          color = type, 
          facets = .~ type,
          xlab = "Year",
          ylab = "PM2.5 Emissions (tons / year)",
          main = "PM2.5 emissions by types in Baltimore City (1999-2008) \n") + 
          geom_smooth(method = "lm", se=FALSE) + 
          theme(panel.margin = unit(1, "lines")) + 
          theme(axis.text.x = element_text(size = 8)) +
          scale_x_continuous(breaks = c(1999, 2002, 2005, 2008)) +
          theme(legend.position = "none")
print(p)
dev.off()