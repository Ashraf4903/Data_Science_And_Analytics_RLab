# 1. Import the airquality dataset and check its structure using str()
print("Structure of airquality dataset:")
data("airquality")     # load built-in dataset
str(airquality)

# 2. Find the number of missing values in airquality
print("Number of missing values in airquality dataset:")
missing_values <- sum(is.na(airquality))
cat("Total Missing Values =", missing_values, "\n")

# 3. Use summary() on the mtcars dataset and interpret the output
print("Summary of mtcars dataset:")
summary(mtcars)

# 4. Find the mean horsepower (hp) in the mtcars dataset
print("Mean horsepower (hp) in mtcars dataset:")
mean_hp <- mean(mtcars$hp)
cat("Mean of horsepower =", mean_hp, "\n")

# 5. Group the iris dataset by Species and calculate the average Sepal.Width
print("Average Sepal.Width for each Species in iris dataset:")
aggregate(Sepal.Width ~ Species, data = iris, FUN = mean)
