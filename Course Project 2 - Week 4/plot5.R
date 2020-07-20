# Plot 5

library(ggplot2)

path <- getwd()
unzip(zipfile = "exdata_data_NEI_data.zip", exdir = path)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

# Accessing values for motor vehicle emissions in Baltimore - vehicle emissions are of type ON-ROAD
motorVehicleEmissions <- NEI[NEI$fips == "24510" & NEI$type == "ON-ROAD", ]

aggregateBaltimoreEmissions <- aggregate(Emissions ~ year, motorVehicleEmissions, sum)

# Plotting using ggplot2
png("plot5.png")
g <- ggplot(data = aggregateBaltimoreEmissions, mapping = aes(factor(year), Emissions))
g <- g + geom_bar(stat = "identity") + xlab("Year") + ylab("Total Emissions by Motor Vehicles in Baltimore") +
  ggtitle("Total Emissions by Motor Vehicles in Baltimore, MD from 1999-2008")
print(g)
dev.off()
