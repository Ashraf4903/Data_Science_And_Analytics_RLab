library(ggplot2)
library(caTools)
library(class)
library(rpart)
library(rpart.plot)
library(dplyr)

# Set a random seed for reproducible results
set.seed(123)

print("--- Packages loaded. Starting data setup... ---")

# --- 1. Data Preparation ---

# Load data
data_reg <- mtcars
data_class <- iris

# Prep mtcars: Convert 'am' to a factor for classification
data_reg$am_factor <- as.factor(data_reg$am)

# --- LinReg/LogReg Split (mtcars) ---
split_reg <- sample.split(data_reg$mpg, SplitRatio = 0.7)
train_reg <- subset(data_reg, split_reg == TRUE)
test_reg <- subset(data_reg, split_reg == FALSE)

# --- kNN/DTree/kMeans Split (iris) ---
split_class <- sample.split(data_class$Species, SplitRatio = 0.7)
train_class <- subset(data_class, split_class == TRUE)
test_class <- subset(data_class, split_class == FALSE)

# Min-max scaling function (as mentioned in report)
normalize <- function(x) {
  return ((x - min(x)) / (max(x) - min(x)))
}

# Scale data for kNN and k-Means
train_class_scaled <- as.data.frame(lapply(train_class[,1:4], normalize))
test_class_scaled <- as.data.frame(lapply(test_class[,1:4], normalize))

# Store labels
train_class_labels <- train_class$Species
test_class_labels <- test_class$Species

print("--- Data setup complete. Generating plots... ---")

# --- 2. Linear Regression Plot ---
model_lib <- lm(mpg ~ wt + hp, data = train_reg)
pred_lib <- predict(model_lib, newdata = test_reg)

plot_data_linreg <- data.frame(Actual = test_reg$mpg, Predicted = pred_lib)

p1 <- ggplot(plot_data_linreg, aes(x = Actual, y = Predicted)) +
  geom_point(alpha = 0.7, color = "blue") +
  geom_abline(color = "red", linetype = "dashed", linewidth = 1) +
  labs(title = "Linear Regression: Predicted vs. Actual MPG",
       x = "Actual MPG", y = "Predicted MPG") +
  theme_minimal()

ggsave("linreg_plot.png", plot = p1, width = 6, height = 4)
print("Saved linreg_plot.png")

# --- 3. Logistic Regression Plot (Convergence) ---
# Manual Gradient Descent to get cost history
X <- as.matrix(cbind(1, train_reg$hp, train_reg$wt))
y <- as.numeric(train_reg$am_factor) - 1 # Convert factor to 0/1

sigmoid <- function(z) { 1 / (1 + exp(-z)) }

beta <- matrix(0, ncol = 1, nrow = ncol(X))
learning_rate <- 0.0001 # Tuned for unscaled hp/wt
iterations <- 25000
cost_history <- numeric(iterations)

for (i in 1:iterations) {
  z <- X %*% beta
  p <- sigmoid(z)
  
  # Avoid log(0) or log(1) issues
  p <- pmax(pmin(p, 1 - 1e-9), 1e-9) 
  
  gradient <- (t(X) %*% (p - y)) / nrow(X)
  beta <- beta - (learning_rate * gradient)
  
  # Calculate log loss
  cost <- -mean(y * log(p) + (1 - y) * log(1 - p))
  cost_history[i] <- cost
}

plot_data_logreg <- data.frame(Iteration = 1:iterations, LogLoss = cost_history)

p2 <- ggplot(plot_data_logreg, aes(x = Iteration, y = LogLoss)) +
  geom_line(color = "blue") +
  labs(title = "Logistic Regression: Convergence of Log Loss",
       x = "Iteration", y = "Log Loss (Cost)") +
  theme_minimal()

ggsave("logreg_plot.png", plot = p2, width = 6, height = 4)
print("Saved logreg_plot.png")

# --- 4. k-Nearest Neighbors (kNN) Plot (Accuracy vs. k) ---
k_values <- 1:15
accuracies <- numeric(length(k_values))

for (i in seq_along(k_values)) {
  k <- k_values[i]
  pred_knn <- knn(train = train_class_scaled,
                  test = test_class_scaled,
                  cl = train_class_labels,
                  k = k)
  
  accuracies[i] <- mean(pred_knn == test_class_labels)
}

plot_data_knn <- data.frame(K = k_values, Accuracy = accuracies)

p3 <- ggplot(plot_data_knn, aes(x = K, y = Accuracy)) +
  geom_line(color = "green", linewidth = 1) +
  geom_point(color = "darkgreen", size = 3) +
  labs(title = "kNN Performance by Number of Neighbors (k)",
       x = "Value of k", y = "Test Set Accuracy") +
  scale_x_continuous(breaks = k_values) +
  theme_minimal()

ggsave("knn_plot.png", plot = p3, width = 6, height = 4)
print("Saved knn_plot.png")

# --- 5. Decision Tree Plot ---
model_dt <- rpart(Species ~ ., data = train_class, method = "class")

# Use the png() device to save the rpart.plot
png("dtree_plot.png", width = 800, height = 600, res = 100)
rpart.plot(model_dt, 
           main = "Decision Tree for Iris Species", 
           box.palette = "auto", 
           shadow.col = "gray", 
           roundint = FALSE,
           yesno = 2)
dev.off() # Close the png device

print("Saved dtree_plot.png")

# --- 6. k-Means Clustering Plot ---
# As in the report, use scaled training data
model_km <- kmeans(train_class_scaled, centers = 3, nstart = 25)

# Add cluster results and true species to the scaled data
plot_data_kmeans <- train_class_scaled %>%
  mutate(Cluster = as.factor(model_km$cluster),
         Species = train_class_labels) # Use the true labels

p5 <- ggplot(plot_data_kmeans, aes(x = Petal.Length, y = Petal.Width, color = Cluster, shape = Species)) +
  geom_point(size = 3, alpha = 0.8) +
  labs(title = "k-Means Clusters (Color) vs. True Species (Shape)",
       subtitle = "Using Petal Length vs. Petal Width",
       x = "Normalized Petal Length", y = "Normalized Petal Width") +
  theme_minimal()

ggsave("kmeans_plot.png", plot = p5, width = 7, height = 5)
print("Saved kmeans_plot.png")

# --- 7. Session Info File ---
writeLines(capture.output(sessionInfo()), "session_info.txt")
print("Saved session_info.txt")

print("--- All files generated successfully! ---")