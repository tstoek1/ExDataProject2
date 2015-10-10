##First, download and unzip project files into working directory.
nei<-readRDS("summarySCC_PM25.rds")
scc<-readRDS("Source_Classification_Code.rds")

##Load dplyr & ggplot2 packages
library(dplyr)
library(ggplot2)

##Subset scc file for coal combustion sources
coal<-grep("Coal$", scc$EI.Sector, ignore.case=TRUE, value=TRUE)
coalsubset<-subset(scc, EI.Sector %in% coal)

##Merge coal combustion SCC data into nei file
comb<-merge(nei, coalsubset, by="SCC", all=FALSE)

##Group combined scc/nei coal file by year and get coal emissions totals per year
yrs4<-group_by(comb, year)
tbl4<-summarize(yrs4, emissions=sum(Emissions))

##Plot coal emissions by year 
plot(tbl4$year, tbl4$emissions, type="l", lwd=2, col="blue", xlab="Year", ylab="Emissions, in Tons",
     main="Total PM2.5 Emissions from\n Coal Combustion Sources")

##Copy plot to PNG file
dev.copy(png, file = "Plot4.png")
dev.off()

##Answer:  In the US, PM2.5 emissions from coal combustion sources did not change significantly from 1999-2005,
## but then dropped considerably in 2008.