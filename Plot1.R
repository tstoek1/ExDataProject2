##First, download and unzip project files into working directory.
nei<-readRDS("summarySCC_PM25.rds")
scc<-readRDS("Source_Classification_Code.rds")

##Load dplyr package
library(dplyr)

##Group nei file by year and get Emissions column totals by year
yrs<-group_by(nei, year)
tbl1<-summarize(yrs, emissions=sum(Emissions))

##Plot Emissions by year using base package
plot(tbl1$year, tbl1$emissions, type="l", lwd=2, col="blue", xlab="Year", ylab="Emissions, in Tons",
     main="Total PM2.5 Emissions in US, by Year")

##Copy plot to PNG file
dev.copy(png, file = "Plot1.png")
dev.off()

##Answer:  Yes, total PM2.5 emissions have decreased in the US from 1999-2008.
