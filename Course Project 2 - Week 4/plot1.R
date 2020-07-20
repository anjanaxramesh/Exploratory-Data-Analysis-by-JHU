# Plot 1

path <- getwd()
unzip(zipfile = "exdata_data_NEI_data.zip", exdir = path)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
# Using the base plotting system, make a plot showing the total PM2.5 emission from all sources 
# for each of the years 1999, 2002, 2005, and 2008.

aggregateTotalEmissions <- aggregate(Emissions ~ year, NEI, sum)

png("plot1.png")
barplot(height = aggregateTotalEmissions$Emissions, names.arg = aggregateTotalEmissions$year, width = 1,
        xlab = "Year", ylab = "Total PM2.5 Emission", main = "Total PM2.5 Emissions Over Various Years")
dev.off()