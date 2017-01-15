
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


#### 3 #### 
# Of the four types of sources indicated by the 𝚝𝚢𝚙𝚎 (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make a plot answer this question.

library(ggplot2)

NEIBaltimore <- subset(NEI, fips == '24510')

BTMTotEmiType <- with(NEIBaltimore, aggregate(Emissions, by = list(SourceType = type, EmiYear = year), sum))

png(filename = "plot3.png", width = 480, height = 480, units="px")

qplot(x = EmiYear, y = x, data = BTMTotEmiType) + geom_line(aes(color = SourceType), size = 1) + ggtitle("Baltimore City Total PM2.5 Emissions by Source Type") + xlab("Year") + ylab("Total pm2.5 Emissions")

dev.off()
