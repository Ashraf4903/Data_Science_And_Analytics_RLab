# 1. Perform binning on Sepal.Length from iris
iris$Sepal_Length_Group <- cut(iris$Sepal.Length, breaks = 3, labels = c("Short", "Medium", "Long"))

# 2. Convert Species column into dummy variables (One-Hot Encoding)
dummy <- model.matrix(~Species - 1, data = iris)

# 3. Normalize the mpg column in mtcars
mtcars$mpg_norm <- (mtcars$mpg - min(mtcars$mpg)) / (max(mtcars$mpg) - min(mtcars$mpg))

# 4. Standardize the Sepal.Width column in iris
iris$Sepal_Width_Std <- scale(iris$Sepal.Width)

# 5. Create a new feature in mtcars: efficiency = mpg / hp
mtcars$efficiency <- mtcars$mpg / mtcars$hp
