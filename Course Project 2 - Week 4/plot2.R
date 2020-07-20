# Plot 2

path <- getwd()
unzip(zipfile = "exdata_data_NEI_data.zip", exdir = path)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") 
# from 1999 to 2008? Use the base plotting system to make a plot answering this question.

aggregateBaltimoreEmissions <- aggregate(Emissions ~ year, NEI[NEI$fips == "24510", ], sum)

png("plot2.png")
barplot(height = aggregateBaltimoreEmissions$Emissions, names.arg = aggregateBaltimoreEmissions$year, width = 1,
        xlab = "Year", ylab = "Total PM2.5 Emissions in Baltimore", 
        main = "Total PM2.5 Emissions From 1999 - 2008 in Baltimore, MD")
dev.off()
