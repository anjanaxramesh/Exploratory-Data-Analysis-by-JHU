library(data.table)
library(lubridate)

path <- getwd()
unzip(zipfile = "exdata_data_household_power_consumption.zip", exdir = path)

householdData <- fread(file = "household_power_consumption.txt")

# Changing date format
householdData$Date = as.Date(householdData$Date, format = "%d/%m/%Y")

# Subsetting Data to the right dates
subsetData <- subset(householdData, Date >= "2007-02-01" & Date <= "2007-02-02")

# Transforming the column Global Active Power into numeric values
globalActivePower <- as.numeric(subsetData$Global_active_power)

# Plotting Histogram
png("plot1.png")
hist(globalActivePower, main = "Global Active Power", col = "red", 
     xlab = "Global Active Power (kilowatts)", ylab = "Frequency")
dev.off()