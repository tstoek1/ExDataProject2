##First, download and unzip project files into working directory.
nei<-readRDS("summarySCC_PM25.rds")
scc<-readRDS("Source_Classification_Code.rds")

##Load dplyr & ggplot2 packages
library(dplyr)
library(ggplot2)

##Subset scc file for motor vehicle sources
mv<-grep("Mobile - On-Road", scc$EI.Sector, ignore.case=FALSE, value=TRUE)
mvsubset<-subset(scc, EI.Sector %in% mv)

##Subset nei file for Baltimore City, MD (fips="24510") and Los Angeles County, CA (fips="06037")
bmd<-subset(nei, fips=="24510")
lac<-subset(nei, fips=="06037")

##Merge the subsetted nei and scc files, creating two distinct files, one per location
combbmd<-merge(bmd, mvsubset, by="SCC", all=FALSE)
comblac<-merge(lac, mvsubset, by="SCC", all=FALSE)

##Group both merged location files by year and sum emissions totals per year
yrs6b<-group_by(combbmd, year)
yrs6l<-group_by(comblac, year)
tbl6b<-summarize(yrs6b, emissions=sum(Emissions))
tbl6l<-summarize(yrs6l, emissions=sum(Emissions))

##Plot motor vehicle emissions in Baltimore by year 
plot(tbl6l$year, tbl6l$emissions, type="l", lwd=2, col="blue", xlab="Year", ylab="Emissions, in Tons",
     main="Total PM2.5 Emissions from Motor Vehicle\n Sources, Baltimore vs Los Angeles", ylim=c(0,4650))

##Do not write over above plot
par(new=T)

##Plot motor vehicle emissions in Los Angeles by year on same graph
plot(tbl6b$year, tbl6b$emissions, type="l", lwd=2, col="red", xlab="", ylab="", axes=FALSE, ylim=c(0,4650))

##Copy plot to PNG file
dev.copy(png, file = "Plot6.png")
dev.off()

##Answer:  Los Angeles County, CA, has seen more drastic changes in motor vehicle emissions than Baltimore City, MD.
