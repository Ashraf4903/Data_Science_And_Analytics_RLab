#//Part A: Descriptive Statistics & Visual Summaries

#Dataset: mtcars (built-in R dataset)
#1. Calculate mean, median, mode, variance, standard deviation, and range of the mpg column.
#2. Create a frequency table of the number of cylinders (cyl).
#3. Generate a histogram of mpg and overlay a density curve.
#4. Create a boxplot of mpg by cyl and interpret the spread.
#5. Use summary() to produce a descriptive statistics report of the dataset
 
#######Answers#######

#1
data(mtcars)

# Mean, Median, Mode
mean_mpg <- mean(mtcars$mpg)
median_mpg <- median(mtcars$mpg)

# Mode function (since R has no built-in mode for numeric)
mode_mpg <- as.numeric(names(sort(table(mtcars$mpg), decreasing = TRUE)[1]))

# Variance, Standard Deviation, Range
var_mpg <- var(mtcars$mpg)
sd_mpg <- sd(mtcars$mpg)
range_mpg <- range(mtcars$mpg)

mean_mpg; median_mpg; mode_mpg; var_mpg; sd_mpg; range_mpg


#2 frequency table 
cyl_table <- table(mtcars$cyl)
print("Frequency Table for Cylinders (cyl):")
print(cyl_table)


# 3. Histogram of mpg and overlay a density curve
library(ggplot2)

ggplot(mtcars, aes(x = mpg)) +
  geom_histogram(aes(y = after_stat(density)), bins = 8, fill = "lightblue", color = "black") +
  geom_density(color = "red", linewidth = 1) +
  labs(title = "Histogram of MPG with Overlayed Density Curve",
       x = "Miles Per Gallon (MPG)",
       y = "Density")

#4 boxplot of mpg by cylinders
mtcars$cyl_f <- as.factor(mtcars$cyl)

ggplot(mtcars, aes(x = cyl_f, y = mpg, fill = cyl_f)) +
  geom_boxplot() +
  labs(title = "Boxplot of MPG by Cylinders",
       x = "Number of Cylinders",
       y = "Miles Per Gallon (MPG)") 

#5 Summmary of dataser
summary(mtcars)


