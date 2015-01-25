#load plyr for ddply
library(plyr)
#assignment requires ggplot2
library(ggplot2)

#load the 2 datasets
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


# Question 4: 
#Across the United States, how have emissions from coal combustion-related sources 
#changed from 1999–2008

#find columns in the summary file with the word "coal", and extract them
sccID <- unique(SCC[grep("coal", SCC[,4], ignore.case=TRUE), 1])
NEI[NEI$SCC %in% sccID,] -> sub

#for each year and type sum all sources
ddply(sub, .(year), numcolwise(sum)) -> sums

#using ggplot2
png("plot4.png")
qplot(year, Emissions, data=sums, geom=c("point", "smooth"), method="lm", main="Emission From Coal Combustion Sources by Year")
dev.off()
