# Q1. Build a logistic regression model predicting am (automatic/manual) in mtcars using hp and wt
model_logit <- glm(am ~ hp + wt, data = mtcars, family = binomial)
summary(model_logit)

# Q2. Construct a decision tree to classify Species in the full iris dataset
library(rpart)
tree_model <- rpart(Species ~ ., data = iris, method = "class")
print(tree_model)
plot(tree_model)
text(tree_model, use.n = TRUE)

# Q3. Calculate confusion matrix and accuracy for Q2
library(caret)
pred_tree <- predict(tree_model, iris, type = "class")
conf_matrix <- confusionMatrix(pred_tree, iris$Species)
conf_matrix

# Q4. Plot the ROC curve for the logistic regression model in Q1
library(pROC)
prob <- predict(model_logit, mtcars, type = "response")
roc_curve <- roc(mtcars$am, prob)
plot(roc_curve, main = "ROC Curve for Logistic Regression")

# Q5. Compare logistic regression and decision tree performance on the iris dataset
# Logistic regression model on iris (binary example: setosa vs non-setosa)
iris_bin <- iris
iris_bin$Species <- ifelse(iris$Species == "setosa", 1, 0)
model_logit_iris <- glm(Species ~ ., data = iris_bin, family = binomial)
summary(model_logit_iris)

# Predict and calculate accuracy for logistic regression on iris
prob_iris <- predict(model_logit_iris, iris_bin, type = "response")
pred_iris <- ifelse(prob_iris > 0.5, 1, 0)
acc_logit <- mean(pred_iris == iris_bin$Species)

# Decision Tree accuracy on iris
acc_tree <- conf_matrix$overall["Accuracy"]

# Compare both
acc_logit
acc_tree
