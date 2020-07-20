# Plot 3

library(ggplot2)

path <- getwd()
unzip(zipfile = "exdata_data_NEI_data.zip", exdir = path)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
# which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? 
# Which have seen increases in emissions from 1999–2008? 
# Use the ggplot2 plotting system to make a plot answer this question.

# Subsetting data from Baltimore (fips = 24510)
aggregateTotalbyYearandType <- aggregate(Emissions ~ year + type, NEI[NEI$fips == "24510", ], sum)

png("plot3.png", width = 720)
g <- ggplot(data = aggregateTotalbyYearandType, mapping = aes(year, Emissions, color = type))
g <- g + geom_line() + xlab("Year") + ylab("Total PM2.5 Emissions") + 
  ggtitle("Total PM2.5 Emissions Over Various Years in Baltimore, MD from 1999 - 2008")
print(g)
dev.off()
