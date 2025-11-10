# 1. Display the first 15 rows of the mtcars dataset
print("First 15 rows of mtcars dataset:")
head(mtcars, 15)

# 2. Find the maximum and minimum value of Sepal.Length from iris
print("Maximum and Minimum values of Sepal.Length from iris dataset:")
max_value <- max(iris$Sepal.Length)
min_value <- min(iris$Sepal.Length)
cat("Maximum Sepal.Length =", max_value, "\n")
cat("Minimum Sepal.Length =", min_value, "\n")

# 3. Calculate the mean of the variable mpg in mtcars
print("Mean of mpg variable in mtcars dataset:")
mean_mpg <- mean(mtcars$mpg)
cat("Mean of mpg =", mean_mpg, "\n")

# 4. Display the structure of the airquality dataset
print("Structure of airquality dataset:")
str(airquality)

# 5. Check whether the number 100 is greater than 50
print("Check whether 100 is greater than 50:")
result <- 100 > 50
cat("Is 100 greater than 50? ->", result, "\n")
