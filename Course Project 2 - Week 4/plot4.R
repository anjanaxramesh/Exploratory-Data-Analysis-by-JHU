# Plot 4

library(ggplot2)

path <- getwd()
unzip(zipfile = "exdata_data_NEI_data.zip", exdir = path)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?

# Merging the data by SCC to be able to access emissions for Coal
NEISCC <- merge(NEI, SCC, by = "SCC")

# Accessing values for coal
coal <- grepl("coal", NEISCC$Short.Name, ignore.case = TRUE)

# Aggregating totals for the coal data
aggregateTotalbyYear <- aggregate(Emissions ~ year, NEISCC[coal, ], sum)

# Plotting using ggplot2

png("plot4.png")
g <- ggplot(data = aggregateTotalbyYear, mapping = aes(factor(year), Emissions))
g <- g + geom_bar(stat = "identity") + xlab("Year") + ylab("Total Coal Combustion-Related Emissions") + 
  ggtitle("Total Coal Combustion-Related Emissions Across the USA from 1999 - 2008")
print(g)
dev.off()
