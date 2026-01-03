# Real Estate Price Prediction using Linear Regression
# Author: Ashraf Pathan

# Load required library
library(ggplot2)

# Create sample housing data
set.seed(123)
n <- 100

house_data <- data.frame(
  House_ID = 1:n,
  Square_Feet = round(rnorm(n, 1500, 500)),
  Bedrooms = sample(2:5, n, replace = TRUE),
  Age_Years = sample(1:30, n, replace = TRUE)
)

# Generate house prices
house_data$Price <- (house_data$Square_Feet * 150) +
  (house_data$Bedrooms * 20000) -
  (house_data$Age_Years * 1000) +
  rnorm(n, 0, 15000)

# Quick data check
summary(house_data)

# Plot: Square Feet vs Price
p <- ggplot(house_data, aes(Square_Feet, Price)) +
  geom_point(color = "blue", alpha = 0.6) +
  geom_smooth(method = "lm", color = "red", se = FALSE) +
  labs(
    title = "House Price vs Square Footage",
    x = "Square Feet",
    y = "Price ($)"
  ) +
  theme_minimal()


print(p)


ggsave("housing_plot.png", plot = p, width = 6, height = 4)

# Build linear regression model
model <- lm(Price ~ Square_Feet + Bedrooms + Age_Years, data = house_data)

# Model output
coef(model)
summary(model)

# Predict price for a new house
new_house <- data.frame(
  Square_Feet = 2000,
  Bedrooms = 3,
  Age_Years = 5
)

predicted_price <- predict(model, new_house)

cat(sprintf(
  "\nPredicted price for a 2000 sqft, 3 BHK, 5-year-old house: $%.2f\n",
  predicted_price
))
