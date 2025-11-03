#Part B: Probability & Distributions

#Dataset: iris (built-in R dataset)
#1. Plot a normal distribution curve with mean = mean of Sepal.Length and sd = sd of Sepal.Length.
#2. Perform a Shapiro–Wilk test to check if Sepal.Length follows a normal distribution.
#3. Simulate 1000 samples from a binomial distribution (n = 10, p = 0.5) and plot its histogram.
#4. Compare the sample mean and variance with theoretical values for the binomial distribution.



#####--------    Answers ----------  #####


library(ggplot2)


#1Normal Distribution Curve for Sepal.Length
data(iris)

# Mean and SD of Sepal.Length
mu <- mean(iris$Sepal.Length)
sigma <- sd(iris$Sepal.Length)

# Sequence of values
x <- seq(min(iris$Sepal.Length), max(iris$Sepal.Length), length = 100)

# Normal curve
y <- dnorm(x, mean = mu, sd = sigma)

plot(x, y, type = "l", col = "blue", lwd = 2,
     main = "Normal Distribution Curve of Sepal.Length",
     xlab = "Sepal.Length", ylab = "Density")


#2 Shapiro–Wilk Test for Normality
shapiro.test(iris$Sepal.Length)

#3
set.seed(123)
samples <- rbinom(1000, size = 10, prob = 0.5)

df_binom <- data.frame(samples)

ggplot(df_binom, aes(x = samples)) +
  geom_histogram(binwidth = 1, fill = "lightblue", color = "black") +
  labs(title = "Binomial Distribution (n=10, p=0.5)",
       x = "Number of Successes", y = "Frequency")

#4
# Sample stats
sample_mean <- mean(samples)
sample_var <- var(samples)

# Theoretical stats
theoretical_mean <- 10 * 0.5
theoretical_var <- 10 * 0.5 * (1 - 0.5)

sample_mean; sample_var
theoretical_mean; theoretical_var


