
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


#### 1 #### 
# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?
# Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008. 

# sum pm2.5 Emissions by year
TotalEmission <- with(NEI, aggregate(Emissions, by = list(year), sum))

png(filename = "plot1.png", width = 480, height = 480, units="px")

plot(TotalEmission, pch = 19, xlab = 'Year', ylab = 'Total pm2.5 Emissions', main = 'US Total PM2.5 Emissions', lty = 4, type = 'o')

dev.off()
