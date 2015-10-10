##First, download and unzip project files into working directory.
nei<-readRDS("summarySCC_PM25.rds")
scc<-readRDS("Source_Classification_Code.rds")

##Load dplyr package
library(dplyr)

##Subset for Baltimore City, MD (fips="24510")
bmd<-subset(nei, fips=="24510")

##Group Baltimore file by year and get Emissions column totals per year
yrs2<-group_by(bmd, year)
tbl2<-summarize(yrs2, emissions=sum(Emissions))

##Plot Emissions by year using base package
plot(tbl2$year, tbl2$emissions, type="l", lwd=2, col="blue", xlab="Year", ylab="Emissions, in Tons",
     main="Total PM2.5 Emissions in Baltimore, MD, by Year")

##Copy plot to PNG file
dev.copy(png, file = "Plot2.png")
dev.off()

##Answer:  After an increase in the year 2005 (still down from the high point in 1999), 
## PM2.5 emissions substantially decreased in 2008.  Overall trend = decrease
