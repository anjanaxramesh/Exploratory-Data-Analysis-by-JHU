library(dplyr)
library(lubridate)
library(data.table)

path <- getwd()
unzip(zipfile = "exdata_data_household_power_consumption.zip", exdir = path)

householdData <- read.table(file = "household_power_consumption.txt", header = TRUE, sep = ";", stringsAsFactors = FALSE, dec = ".")

# Subsetting Data to the right dates
subSetData <- householdData[householdData$Date %in% c("1/2/2007","2/2/2007") ,]

# Changing time format
datetime <- strptime(paste(subSetData$Date, subSetData$Time, sep = " "), "%d/%m/%Y %H:%M:%S") 

# Transforming the column into numeric values
globalActivePower <- as.numeric(subSetData$Global_active_power)

# Plotting the graph
png("plot2.png", width = 480, height = 480)
plot(datetime, globalActivePower, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off() 