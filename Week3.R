# week 3

# Hierarchical Clustering

# Cluster Dendrogram

set.seed(1234)
par(mar = c(0, 0, 0, 0))
x <- rnorm(12, mean = rep(1:3, each = 4), sd = 0.2)
y <- rnorm(12, mean = rep(c(1, 2, 1), each = 4), sd = 0.2)
plot(x, y, col = "blue", pch = 19, cex = 2)
text(x + 0.05, y + 0.05, labels = as.character(1:12))
dataFrame <- data.frame(x = x, y = y)
distxy <- dist(dataFrame)
hCluster <- hclust(distxy)
plot(hCluster)
# Refer RGraphGallery

# heatingmap() - table and matrix data

x <- rnorm(12, mean = rep(1:3, each = 4), sd = 0.2)
y <- rnorm(12, mean = rep(c(1, 2, 1), each = 4), sd = 0.2)
dataFrame <- data.frame(x = x, y = y)
set.seed(143)
dataMatrix <- as.matrix(dataFrame)[sample(1:12), ]
heatmap(dataMatrix)

# K-means Clustering

set.seed(1234)
par(mar = c(0, 0, 0, 0))
x <- rnorm(12, mean = rep(1:3, each = 4), sd = 0.2)
y <- rnorm(12, mean = rep(c(1, 2, 1), each = 4), sd = 0.2)
plot(x, y, col = "blue", pch = 19, cex = 2)
text(x + 0.05, y + 0.05, labels = as.character(1:12))

dataFrame <- data.frame(x, y)
kmeansObj <- kmeans(dataFrame, centers = 3)
names(kmeansObj)
kmeansObj$cluster

par(mar = rep(0.2, 4))
plot(x, y, col = kmeansObj$cluster, pch = 19, cex = 2)
points(kmeansObj$centers, col = 1:3, pch = 3, cex = 3, lwd = 3)


# heatmap k-means
set.seed(1234)
dataMatrix <- as.matrix(dataFrame)[sample(1:12), ]
kmeansObj2 <- kmeans(dataMatrix, centers = 3)
par(mfrow = c(1, 2), mar = c(2, 4, 0.1, 0.1))
image(t(dataMatrix)[, nrow(dataMatrix):1], yaxt = "n")
image(t(dataMatrix)[, order(kmeansObj2$cluster)], yaxt = "n")

# Dimension Reduction
set.seed(12345)
par(mar = rep(0.2, 4))
dataMatrix <- matrix(rnorm(400), nrow = 40)
image(1:10, 1:40, t(dataMatrix)[, nrow(dataMatrix):1])
heatmap(dataMatrix)

# Adding a pattern
set.seed(678910)
for (i in 1:40) {
  # flipping a coin
  coinFlip <- rbinom(1, size = 1, prob = 0.5)
  #  if coin is heads, add a pattern to that row
  if (coinFlip){
    dataMatrix[i, ] <- dataMatrix[i, ] + rep(c(0, 3), each = 5)
  }
}
par(mar = rep(0.2, 4))
image(1:10, 1:40, t(dataMatrix)[, nrow(dataMatrix):1])
heatmap(dataMatrix)

hh <- hclust(dist(dataMatrix))
dataMatrixOrdered <- dataMatrix[hh$order, ]
par(mfrow = c(1, 3))
image(1:10, 1:40, t(dataMatrix)[, nrow(dataMatrix):1])
plot(rowMeans(dataMatrixOrdered), 40:1, xlab = "Row Mean", ylab = "Row", pch = 19)
plot(colMeans(dataMatrixOrdered), xlab = "Column", ylab = "Column Mean", pch = 19)

# Components of the SVD - u and v
svd1 <- svd(scale(dataMatrixOrdered))
par(mfrow = c(1, 3))
image(1:10, 1:40, t(dataMatrix)[, nrow(dataMatrix):1])
plot(svd1$u[, 1], 40:1, xlab = "Row", ylab = "First Left Singular Vector", pch = 19)
plot(svd1$v[, 1], xlab = "Column", ylab = "First right singular vector", pch = 19)

# Variance explained
par(mfrow = c(1, 3))
plot(svd1$d, xlab = "Column", ylab = "Singular Value", pch = 19)
plot(svd1$d^2/sum(svd1$d^2), xlab = "Column", ylab = "Prop. of Variance explained", pch = 19)

# Relationship to Principal Components
svd1 <- svd(scale(dataMatrixOrdered))
pca1 <- prcomp(dataMatrixOrdered, scale = TRUE)
plot(pca1$rotation[, 1], svd1$v[, 1], pch = 19, xlab = "Principle Component 1", 
     ylab = "Right Singular Vector 1")
abline(c(0, 1))

constantMatrix <- dataMatrixOrdered*0
for (i in 1:dim(dataMatrixOrdered)[1]) {
  constantMatrix[i, ] <- rep(c(0, 1), each = 5)
}
svd1 <- svd(constantMatrix)
image(t(constantMatrix)[, nrow(constantMatrix):1])
par(mfrow = c(1, 3))
plot(svd1$d, xlab = "Column", ylab = "Singular Value", pch = 19)
plot(svd1$d^2/sum(svd1$d^2), xlab = "Column", ylab = "Prop. of Variance explained", pch = 19)

# Adding a pattern
set.seed(678910)
for (i in 1:40) {
  # flipping a coin
  coinFlip1 <- rbinom(1, size = 1, prob = 0.5)
  coinFlip2 <- rbinom(1, size = 1, prob = 0.5)
  #  if coin is heads, add a pattern to that row
  if (coinFlip1){
    dataMatrix[i, ] <- dataMatrix[i, ] + rep(c(0, 5), each = 5)
  }
  if (coinFlip2){
    dataMatrix[i, ] <- dataMatrix[i, ] + rep(c(0, 5), each = 5)
  }
}

hh <- hclust(dist(dataMatrix))
dataMatrixOrdered <- dataMatrix[hh$order, ]

svd2 <- svd(dataMatrixOrdered)
image(t(dataMatrixOrdered)[, nrow(dataMatrixOrdered):1])
par(mfrow = c(1, 3))
plot(rep(c(0, 1), each = 5), xlab = "Column", ylab = "Pattern 1", pch = 19)
plot(rep(c(0, 1), each = 5), xlab = "Column", ylab = "Pattern 2", pch = 19)

# Working with Color
pal <- colorRamp(c("red", "blue")) # values between 0 and 1
pal(seq(0, 1 , len = 10))
pal <- colorRampPalette(c("red", "yellow")) # hexadecimal integer values

library(RColorBrewer)
cols <- brewer.pal(3, "BuGn")
pal <- colorRampPalette(cols)
image(volcano, col = pal(20))

x <- rnorm(10000)
y <- rnorm(10000)
smoothScatter(x, y)

library(colorspace)
plot(x, y, rgb(0, 0, 0, 0.2), pch = 19)
