#load plyr for ddply
library(plyr)

#load the 2 datasets
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


# Question 2: 
#Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") 
#from 1999 to 2008? Use the base plotting system to make a plot answering this question.

#just pull out fips ==24510 = baltimore
NEI[NEI$fips=="24510",] -> baltimore

#for each year sum all sources
ddply(baltimore, .(year), numcolwise(sum)) -> sums

#using base plot system, plot yearly summary (also save to png file)
png("plot2.png")
plot(sums, ylab="Total Emissions (Tons)", main="Baltimore City, Maryland")
dev.off()
