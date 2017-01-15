
## Download and Unzip Data Set ####
setwd("./Week4")
getwd()
if(!file.exists("./data")){
        dir.create("./data")
}

zip_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(zip_url, "./data/exdata%2Fdata%2FNEI_data.zip")
unzip("./data/exdata%2Fdata%2FNEI_data.zip", exdir = "./data")

# reading in each file
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")


#### 5 #### 
# How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

library(ggplot2)

NEIBaltimore.Motor <- subset(NEI, fips == '24510' & type == 'ON-ROAD')

TotEmiType.Motor <- with(NEIBaltimore.Motor, aggregate(Emissions, by = list(EmiYear = year), sum))

png(filename = "plot5.png", width = 480, height = 480, units="px")

qplot(x = EmiYear, y = x, data = TotEmiType.Motor, geom = "line") + ggtitle("Baltimore City Total PM2.5 Emissions from Motor Vehicles") + xlab("Year") + ylab("PM2.5 Emissions")

dev.off()
