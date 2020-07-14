# Week 1

# Base Plot 
library(datasets)
data(cars)
with(cars, plot(speed, dist))

# Lattice Plot
library(lattice)
state <- data.frame(state.x77, region = state.region)
xyplot(Life.Exp ~ Income | region, data = state, layout = c(4,  1))

# ggplot2 Plot
library(ggplot2)
data(mpg)
qplot(displ, hwy, data = mpg)

# Base Plotting Systems
library(datasets)
data(airquality)
hist(airquality$Ozone)

with(airquality, plot(Wind, Ozone))

airquality <- transform(airquality, Month = factor(Month))
boxplot(Ozone ~ Month, airquality, xlab = "Month", ylab = "Ozone (ppb)")

with(airquality, plot(Wind, Ozone, main = "Ozone and Wind in NYC"))
with(subset(airquality, Month == 5), points(Wind, Ozone, col = "blue"))

with(airquality, plot(Wind, Ozone, main = "Ozone and Wind in NYC", type = "n"))
with(subset(airquality, Month == 5), points(Wind, Ozone, col = "blue"))
with(subset(airquality, Month != 5), points(Wind, Ozone, col = "red"))
legend("topright", pch = 1, col = c("red", "blue"), legend = c("May", "Other Months"))

with(airquality, plot(Wind, Ozone, main = "Ozone and Wind in NYC", pch = 20))
model <- lm(Ozone ~ Wind, airquality) # Regression Line
abline(model, lwd = 2)

# Multiple Base Plots
par(mfrow = c(1,2))
with(airquality, {
  plot(Wind, Ozone, main = "Ozone and Wind")
  plot(Solar.R, Ozone, main = "Ozone and Solar.R")
})

pdf(file = "OzoneNYC.pdf")
library(datasets)
data(airquality)
par(mfrow = c(1,3), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))
with(airquality, {
  plot(Wind, Ozone, main = "Ozone and Wind")
  plot(Solar.R, Ozone, main = "Ozone and Solar.R")
  plot(Temp, Ozone, main = "Ozone and Temp")
  mtext("Ozone and Weather in NYC", outer = TRUE)
})
dev.off()

library(datasets)
par(mfrow = c(1, 1))
with(faithful, plot(eruptions, waiting, col = c("red", "blue")))
title(main = "Old Faithful Geyser Data")
dev.copy(png, file = "geyser.plot.png")
dev.off()