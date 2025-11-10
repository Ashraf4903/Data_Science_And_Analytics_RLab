# 1. Regression model predicting Petal.Length from Sepal.Length in iris
model1 <- lm(Petal.Length ~ Sepal.Length, data = iris)
summary(model1)

# 2. Multiple regression model predicting mpg using wt, hp, and drat in mtcars
model2 <- lm(mpg ~ wt + hp + drat, data = mtcars)
summary(model2)

# 3. Check R² and Adjusted R² of model2
summary(model2)$r.squared
summary(model2)$adj.r.squared

# 4. Plot residuals of model1
plot(model1$residuals, main = "Residuals of Model 1", ylab = "Residuals", col = "blue")

# 5. Regression model predicting Ozone using Temp from airquality
model3 <- lm(Ozone ~ Temp, data = airquality)
summary(model3)
