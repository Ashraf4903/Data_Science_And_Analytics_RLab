# Q1. Perform K-means clustering with K = 4 on iris dataset and compare with species labels
data(iris)
set.seed(123)
iris_data <- iris[, -5]  # remove Species column
km_iris <- kmeans(iris_data, centers = 4, nstart = 20)
table(km_iris$cluster, iris$Species)
km_iris

# Q2. Apply clustering on mtcars using mpg, hp, and wt. Interpret clusters
mtcars_data <- mtcars[, c("mpg", "hp", "wt")]
set.seed(123)
km_mtcars <- kmeans(scale(mtcars_data), centers = 3, nstart = 20)
km_mtcars$centers
km_mtcars$size
km_mtcars$cluster

# Q3. Use the elbow method to find the optimal number of clusters for iris
wss <- vector()
for (i in 1:10) {
  km <- kmeans(iris_data, centers = i, nstart = 20)
  wss[i] <- km$tot.withinss
}
plot(1:10, wss, type = "b", pch = 19, frame = FALSE,
     xlab = "Number of Clusters (K)",
     ylab = "Total Within-Cluster Sum of Squares",
     main = "Elbow Method for Optimal K")

# Q4. Visualize clusters using PCA-based scatterplot in factoextra
library(factoextra)
fviz_cluster(km_iris, data = iris_data,
             ellipse.type = "convex",
             palette = "jco",
             ggtheme = theme_minimal(),
             main = "K-Means Clustering on iris (K=4)")

# Q5. Create a subset of iris with only Sepal.Length and Sepal.Width and cluster it
iris_subset <- iris[, c("Sepal.Length", "Sepal.Width")]
set.seed(123)
km_subset <- kmeans(iris_subset, centers = 3, nstart = 20)
fviz_cluster(km_subset, data = iris_subset,
             geom = "point",
             ellipse.type = "norm",
             ggtheme = theme_minimal(),
             main = "Clustering on Sepal.Length & Sepal.Width")
