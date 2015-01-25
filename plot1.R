#load plyr for ddply
library(plyr)

#load the 2 datasets
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


# Question 1: 
#Have total emissions from PM2.5 decreased in the United States
#from 1999 to 2008? Using the base plotting system, 
#make a plot showing the total PM2.5 emission 
#from all sources for each of the years 1999, 2002, 2005, and 2008.

#for each year sum all sources
ddply(NEI, .(year), numcolwise(sum)) -> sums

#using base plot system, plot yearly summary (also save to png file)
png("plot1.png")
plot(sums, ylab="Total Emissions (Tons)", main="Total Emissions by Year")
dev.off()
