#load plyr for ddply
library(plyr)
#assignment requires ggplot2
library(ggplot2)

#load the 2 datasets
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


# Question 2: 
#Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
#which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? 
#Which have seen increases in emissions from 1999–2008? 
#Use the ggplot2 plotting system to make a plot answer this question.

#just pull out fips ==24510 = baltimore
NEI[NEI$fips=="24510",] -> baltimore

#for each year and type sum all sources
ddply(baltimore, .(year, type), numcolwise(sum)) -> sums

#using ggplot2
png("plot3.png", width = 800, height = 480)
qplot(year, Emissions, data=sums, facets = .~type, geom=c("point", "smooth"), method="lm", main="Emissions by Type and Year for Baltimore")
dev.off()
