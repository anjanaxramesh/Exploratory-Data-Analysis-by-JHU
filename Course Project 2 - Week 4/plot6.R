# Plot 6

library(ggplot2)

path <- getwd()
unzip(zipfile = "exdata_data_NEI_data.zip", exdir = path)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources 
# in Los Angeles County, California (fips == "06037"). Which city has seen greater changes over time in 
# motor vehicle emissions?

# Subsetting data from Baltimore fips = 24510, LA fips = 06037 for motor vehicles of type = ON-ROAD
BaltimoreandLAData <- NEI[NEI$fips == "24510" | NEI$fips == "06037" & NEI$type == "ON-ROAD", ]

# Aggregating Data for Baltimore and LA
aggregateTotalbyYearandfips <- aggregate(Emissions ~ year + fips, BaltimoreandLAData, sum)

# Labelling the two graphs 
aggregateTotalbyYearandfips$fips[aggregateTotalbyYearandfips$fips == "24510"] <- "Baltimore, MD"
aggregateTotalbyYearandfips$fips[aggregateTotalbyYearandfips$fips == "06037"] <- "Los Angeles, CA"

# Plotting using ggplot2
png("plot6.png", width = 1040, height = 480)
g <- ggplot(data = aggregateTotalbyYearandfips, mapping = aes(factor(year), Emissions, color = fips))
g <- g + facet_grid(.~fips)
g <- g + geom_bar(stat = "identity") + xlab("Year") + ylab("Total PM2.5 Emissions of Motor Vehicles") + 
  ggtitle("Total PM2.5 Emissions from Motor Vehicle (ON-ROAD) Sources from 1999 - 2008 in Baltimore and Los Angeles")
print(g)
dev.off()
