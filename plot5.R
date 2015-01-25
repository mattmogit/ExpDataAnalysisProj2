#load plyr for ddply
library(plyr)
#assignment requires ggplot2
library(ggplot2)

#load the 2 datasets
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


# Question 5: 
#How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?


#find columns in the summary file with the word "coal"
sccID <- unique(SCC[grep("vehicle", SCC[,4], ignore.case=TRUE) , 1])
#extract rows with "vehicle" sccIDs and for Baltimore (fips = 24510) 
NEI[NEI$SCC %in% sccID & NEI$fips=="24510",] -> sub

#for each year and type sum all sources
ddply(sub, .(year), numcolwise(sum)) -> sums

#using ggplot2
png("plot5.png")
qplot(year, Emissions, data=sums, geom=c("point", "smooth"), method="lm", main="Emissions from Motor Vehicles by Year in Baltimore")
dev.off()

