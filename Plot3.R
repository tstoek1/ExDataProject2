##First, download and unzip project files into working directory.
nei<-readRDS("summarySCC_PM25.rds")
scc<-readRDS("Source_Classification_Code.rds")

##Load dplyr & ggplot2 packages
library(dplyr)
library(ggplot2)

##Subset for Baltimore City, MD (fips="24510")
bmd<-subset(nei, fips=="24510")

#Group Baltimore file by both year and type; sum Emissions column
yrs3<-group_by(bmd, year, type)
tbl3<-summarize(yrs3, emissions=sum(Emissions))

##Plot Emissions by year and by type using ggplot2, adding loess smoother for clarity
qplot(year, emissions, data=tbl3, facets=.~type, xlab="Year", ylab="Emissions, in Tons", main="PM2.5 Emissions for 
       Baltimore, MD, by Type")+geom_smooth(method="loess")  
 

##Copy plot to PNG file
dev.copy(png, file = "Plot3.png")
dev.off()


##Answer:  Decreased emissions are seen in Non-Road, Nonpoint, and On-road types, while the "point" type
## showed a marked increase in emissions from 1999-2005, only decreasing in 2008.





