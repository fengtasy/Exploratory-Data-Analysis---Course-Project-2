
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


#### 6 #### 
# Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (𝚏𝚒𝚙𝚜 == "𝟶𝟼𝟶𝟹𝟽"). Which city has seen greater changes over time in motor vehicle emissions?

library(ggplot2)

NEI.BTM.Minstall.packages("memisc")
library(memisc)

NEI.BTM.Motor <- subset(NEI, fips == '24510' & type == 'ON-ROAD')
NEI.LA.Motor <- subset(NEI, fips == '06037' & type == 'ON-ROAD')

BTM.TotEmiType.Motor <- with(NEI.BTM.Motor, aggregate(Emissions, by = list(EmiYear = year, Fips = fips), sum))

LA.TotEmiType.Motor <- with(NEI.LA.Motor, aggregate(Emissions, by = list(EmiYear = year, Fips = fips), sum))

Comb.TotEmiType.Motor <- rbind(BTM.TotEmiType.Motor, LA.TotEmiType.Motor)
is and 'cases' function to get Counties
County=cases(
        "Baltimore City" = Comb.TotEmiType.Motor$Fips == '24510',
        "Los Angeles" = Comb.TotEmiType.Motor$Fips == '06037'
)

Comb.TotEmiType.Motor <- cbind(Comb.TotEmiType.Motor, County)

png(filename = "plot6.png", width = 480, height = 480, units="px")

qplot(x = EmiYear, y = x, data = Comb.TotEmiType.Motor) + geom_line(aes(color = County), size = 1) + ggtitle("Motor Vehicle PM2.5 Emissions in Baltimore City vs. in Los Angeles") + xlab("Year") + ylab("PM2.5 Emissions")

dev.off()
