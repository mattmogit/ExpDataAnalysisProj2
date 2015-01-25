#load plyr for ddply
library(plyr)
#assignment requires ggplot2
library(ggplot2)

#load the 2 datasets
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


# Question 6 : 
#Compare emissions from motor vehicle sources in Baltimore City 
#with emissions from motor vehicle sources in Los Angeles County, California (fips == "06037"). 
#Which city has seen greater changes over time in motor vehicle emissions?

#find columns in the summary file with the word "coal"
sccID <- unique(SCC[grep("vehicle", SCC[,4], ignore.case=TRUE) , 1])
#extract rows with "vehicle" sccIDs and fips for LA and Baltimore 
NEI[NEI$SCC %in% sccID & NEI$fips %in% c("24510", "06037"),] -> sub



#for each year and type sum all sources
ddply(sub, .(year, fips), numcolwise(sum)) -> sums

#need 1999 emission value to normalize future years
baseLA <- sums[sums$year == 1999 & sums$fips == "06037", 3]
baseBal <- sums[sums$year == 1999 & sums$fips == "24510", 3]

# extract data for each city
sums[sums$fips == "06037", ] -> LA 
sums[sums$fips == "24510", ] -> Bal

#calculate and add a column for each city's normalized emission numbers
cbind(LA, LA[3] / baseLA) -> LA
LA$fips <- "Los Angeles"
cbind(Bal, Bal[3] / baseBal) -> Bal
Bal$fips <- "Baltimore"

#bind back to one dataset adn assign column names
rbind(LA, Bal) -> sums
colnames(sums) <- c(colnames(sums)[1], "City", colnames(sums)[3], "Normalized_Emissions")


#using ggplot2
png("plot6.png")
qplot(year, Normalized_Emissions, data=sums, color = City, geom=c("point", "smooth"), method="lm", main="Emissions Normalized vs 1999 by Year and City")
dev.off()

