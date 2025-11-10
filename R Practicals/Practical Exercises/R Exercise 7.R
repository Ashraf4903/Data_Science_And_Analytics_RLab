# 1. One-sample t-test for mean mpg differing from 20
t.test(mtcars$mpg, mu = 20)

# 2. Compare Petal.Width across species in iris using ANOVA
aov_result <- aov(Petal.Width ~ Species, data = iris)
summary(aov_result)

# 3. Find the correlation between mpg and hp in mtcars
cor(mtcars$mpg, mtcars$hp)

# 4. Paired t-test on Sepal.Length and Sepal.Width in iris
t.test(iris$Sepal.Length, iris$Sepal.Width, paired = TRUE)

# 5. Check if Ozone and Temp in airquality are significantly correlated
cor.test(airquality$Ozone, airquality$Temp, use = "complete.obs")
