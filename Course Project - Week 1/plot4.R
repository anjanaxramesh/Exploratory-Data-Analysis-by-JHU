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

# Transforming columns into numeric values
globalActivePower <- as.numeric(subSetData$Global_active_power)
globalReactivePower <- as.numeric(subSetData$Global_reactive_power)
voltage <- as.numeric(subSetData$Voltage)
subm1 <- as.numeric(subSetData$Sub_metering_1)
subm2 <- as.numeric(subSetData$Sub_metering_2)
subm3 <- as.numeric(subSetData$Sub_metering_3)

# Plotting
png("plot4.png")
par(mfrow = c(2, 2))
plot(datetime, globalActivePower, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
plot(datetime, voltage, type = "l", xlab = "datetime", ylab = "Voltage")
plot(datetime, subm1, type = "l", xlab = " ", ylab = "Energy sub metering")
lines(datetime, subm2, type = "l", col = "red")
lines(datetime, subm3, type = "l", col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1, lwd = 2.5, col = c("black", "red", "blue"))
plot(datetime, globalReactivePower, type = "l", xlab = "datetime", ylab = "Global_reactive_power")
dev.off()
