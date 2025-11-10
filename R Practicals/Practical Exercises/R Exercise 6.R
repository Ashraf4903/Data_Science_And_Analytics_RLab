# 1. Create a histogram of mpg from mtcars
hist(mtcars$mpg, main="Histogram of mpg", col="lightblue")

# 2. Generate a scatterplot of hp vs wt from mtcars
plot(mtcars$hp, mtcars$wt, main="hp vs wt", xlab="Horsepower", ylab="Weight", col="blue", pch=19)

# 3. Draw a boxplot of Ozone values from airquality
boxplot(airquality$Ozone, main="Boxplot of Ozone", col="orange")

# 4. Find the correlation between Sepal.Length and Sepal.Width in iris
cor(iris$Sepal.Length, iris$Sepal.Width)

# 5. Create a pair plot of the first four columns of mtcars
pairs(mtcars[, 1:4], main="Pair Plot of mtcars")
