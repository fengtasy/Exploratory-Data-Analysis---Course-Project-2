
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


#### 2 #### 
# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (𝚏𝚒𝚙𝚜 == "𝟸𝟺𝟻𝟷𝟶") from 1999 to 2008? 
# Use the base plotting system to make a plot answering this question.

NEIBaltimore <- subset(NEI, fips == '24510')

# sum Baltimore City, Maryland pm2.5 Emissions by year
BaltimoreTotEmi <- with(NEIBaltimore, aggregate(Emissions, by = list(year), sum))

png(filename = "plot2.png", width = 480, height = 480, units="px")

plot(BaltimoreTotEmi, pch = 19, xlab = 'Year', ylab = 'Total pm2.5 Emissions', main = 'Baltimore City Total PM2.5 Emissions', lty = 4, type = 'o')

dev.off()
