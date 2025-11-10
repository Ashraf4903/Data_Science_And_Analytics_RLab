# 1. Mean, Median, Mode, SD of Petal.Width from iris
mean(iris$Petal.Width)
median(iris$Petal.Width)
names(sort(-table(iris$Petal.Width)))[1]
sd(iris$Petal.Width)

# 2. Histogram of mpg from mtcars
hist(mtcars$mpg, main="Histogram of mpg", col="lightblue")

# 3. Scatterplot of hp vs mpg from mtcars
plot(mtcars$hp, mtcars$mpg, main="hp vs mpg", xlab="Horsepower", ylab="Miles per Gallon", col="blue", pch=19)

# 4. Boxplot for Ozone in airquality
boxplot(airquality$Ozone, main="Boxplot of Ozone", col="orange")

# 5. Variance of Sepal.Width in iris
var(iris$Sepal.Width)
