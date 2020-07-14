# Week 2

# Lattice Plotting System
library(lattice)
library(datasets)
xyplot(Ozone ~ Wind, data = airquality)

# Convert Month to a factor variable
airquality <- transform(airquality, Month = factor(Month))
xyplot(Ozone ~ Wind | Month, data = airquality, layout = c(5, 1))

# Lattice Panel Functions
set.seed(10)
x <- rnorm(100)
f <- rep(0:1, each = 50)
y <- x + f - f * x + rnorm(100, sd = 0.5)
f <- factor(f, labels = c("Group 1", "Group 2"))
xyplot(y ~ x | f, layout = c(2, 1)) # Plotting two panels

# Custom Panel Function
xyplot(y ~ x | f, panel = function(x, y, ...){
  panel.xyplot(x, y, ...) # Calling the default panel function for xyplot
  panel.abline(h = median(y), lty = 2) # Adding a horizontal line at the median
})

xyplot(y ~ x | f, panel = function(x, mynay, ...){
  panel.xyplot(x, y, ...) # Calling the default panel function for xyplot
  panel.lmline(x, y, col = 2) # Overlay a simple linear regression line
})

# ggplot2
library(ggplot2)
qplot(displ, hwy, data = mpg)
qplot(displ, hwy, data = mpg, color = drv)
qplot(displ, hwy, data = mpg, geom = c("point", "smooth"))
# histogram
qplot(hwy, data = mpg, fill = drv)
# facets
qplot(displ, hwy, data = mpg, facets = .~drv)
qplot(hwy, data = mpg, facets = drv~., binwidth = 2)

