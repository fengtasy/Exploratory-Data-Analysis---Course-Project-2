
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


#### 4 #### 
# Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?

library(ggplot2)

# Use grepl to subset all the "Coal" matching observations
SCC.Coal <- SCC[grepl("Coal", SCC$Short.Name),]

NEI.Coal <- subset(NEI, SCC %in% SCC.Coal$SCC)

TotEmiType.Coal <- with(NEI.Coal, aggregate(Emissions, by = list(SourceType = type, EmiYear = year), sum))

png(filename = "plot4.png", width = 480, height = 480, units="px")

# Use stat="identity" and map a value to the y aesthetic for the heights of the bars to represent values in the data.
qplot(x = EmiYear, y = x, data = TotEmiType.Coal, fill = SourceType) + geom_bar(stat = "identity", width = 0.5) + ggtitle("US Total PM2.5 Emissions from Coal Combustion") + xlab("Year") + ylab("Total pm2.5 Emissions")

dev.off()
