##First, download and unzip project files into working directory.
nei<-readRDS("summarySCC_PM25.rds")
scc<-readRDS("Source_Classification_Code.rds")

##Load dplyr & ggplot2 packages
library(dplyr)
library(ggplot2)

##Subset scc file for motor vehicle sources
mv<-grep("Mobile - On-Road", scc$EI.Sector, ignore.case=FALSE, value=TRUE)
mvsubset<-subset(scc, EI.Sector %in% mv)

##Subset nei file for Baltimore City, MD (fips="24510")
bmd<-subset(nei, fips=="24510")

##Merge the two subsetted files
comb<-merge(bmd, mvsubset, by="SCC", all=FALSE)

##Group combined scc/nei motor vehicle file by year and sum emissions totals per year
yrs5<-group_by(comb, year)
tbl5<-summarize(yrs5, emissions=sum(Emissions))

##Plot motor vehicle emissions in Baltimore by year 
plot(tbl5$year, tbl5$emissions, type="l", lwd=2, col="blue", xlab="Year", ylab="Emissions, in Tons",
     main="Total PM2.5 Emissions from Motor Vehicle\n Sources in Baltimore, MD")

##Copy plot to PNG file
dev.copy(png, file = "Plot5.png")
dev.off()

##Answer:  PM2.5 emissions from motor vehicle sources in Baltimore City, MD, greatly decreased from 1999
## to 2002, then have steadily decreased further through 2008.