#Accessing Various File Types

#1. Write R code to:
#  - Load a CSV file (dataset_Facebook.csv) into a dataframe.
#  - Load an Excel file (LungCap_Dataset.xls) into a dataframe.
#  - Load a text file separated by commas.
#2. Display the first 10 rows of each dataset using head().
#3. Check the data type of each column in the Titanic dataset.
#4. Save the Titanic dataset into a new CSV file after filtering only passengers who survived.


#Q1
# Loading CSV file
facebook_data <- read.csv("dataset_Facebook.csv")

# Loading Excel file using 'readxl' package
library(readxl)
lungcap_data <- read_excel("LungCap_Dataset.xls")

# Loading comma-separated text file
text_data <- read.table("your_text_file.txt", sep = ",", header = TRUE)



#Q2
# First 10 rows of each dataset
head(facebook_data, 10)
head(lungcap_data, 10)
head(text_data, 10)

#Q3
# Load Titanic dataset from CSV
titanic_data <- read.csv("train_titanic.csv")

# Display structure and data types
str(titanic_data)

#q4
# Filter passengers who survived (Survived == 1)
survivors <- subset(titanic_data, Survived == 1)


# Save filtered data to a new CSV file
write.csv(survivors, "Titanic_Survivors.csv", row.names = FALSE)


-----------------------------------------------------------------------------------------
  
  #Data Selection & Manipulation

#1. From the Titanic dataset:
 # - Select only the columns Name, Sex, Age, and Survived.
#- Show passengers older than 50.
#- Count the number of survivors in each passenger class (Pclass).
#2. From the Facebook dataset:
 # - Find the post with the maximum number of likes.
#- Calculate the average number of shares per post.
#- Create a new column Engagement = Likes + Comments + Shares.
#3. Using the Lung Capacity dataset:
 # - Select children below age 12.
#- Group by Gender and calculate average Lung Capacity.
#- Find the child with the maximum Lung Capacity.  
  
  
#q1
# Select specific columns
titanic_selected <- titanic[, c("Name", "Sex", "Age", "Survived")]

# Show passengers older than 50
titanic_over_50 <- subset(titanic_selected, Age > 50)

# Count survivors by passenger class
survivor_count <- aggregate(Survived ~ Pclass, data = titanic, sum)

# Display results
head(titanic_selected)
head(titanic_over_50)
print(survivor_count)


#q2
# Load Facebook dataset
facebook <- read.csv("dataset_Facebook.csv")

# Post with maximum likes
max_likes_post <- facebook[which.max(facebook$like), ]

# Average shares per post
avg_shares <- mean(facebook$share, na.rm = TRUE)

# Create Engagement column
facebook$Engagement <- facebook$like + facebook$comment + facebook$share

# Display results
print(max_likes_post)
print(paste("Average Shares:", avg_shares))
head(facebook[, c("like", "comment", "share", "Engagement")])


#q3
# Load Lung Capacity dataset
library(readxl)
lungcap <- read_excel("LungCap_Dataset.xls")

# Select children below age 12
children <- subset(lungcap, Age < 12)

# Group by Gender and calculate average Lung Capacity
avg_lungcap_by_gender <- aggregate(LungCap ~ Gender, data = children, mean)

# Find child with maximum Lung Capacity
max_lungcap_child <- children[which.max(children$LungCap), ]

# Display results
head(children)
print(avg_lungcap_by_gender)
print(max_lungcap_child)

----------------------------------------------------------------------------------
 # Data Manipulation (Using dplyr/base R)

#1. Rename the columns of Titanic dataset to lowercase.
#2. Sort the Titanic dataset by Age in descending order.
#3. Create a new column in Titanic dataset AgeGroup:
#  - “Child” (< 12),
#- “Teen” (12–18),
#- “Adult” (19–59),
#- “Senior” (60+).
#4. Calculate mean Fare by Pclass and Survived status.
#5. From Facebook dataset, group posts by Type (e.g., Photo, Link, Status) and compute average likes.
  
  
library(dplyr)

# Load Titanic dataset
titanic <- read.csv("train_titanic.csv")

# 1. Rename columns to lowercase
names(titanic) <- tolower(names(titanic))

# 2. Sort by Age in descending order
titanic_sorted <- titanic[order(-titanic$age), ]

# 3. Create AgeGroup column
titanic <- titanic %>%
  mutate(agegroup = case_when(
    age < 12 ~ "Child",
    age >= 12 & age <= 18 ~ "Teen",
    age >= 19 & age <= 59 ~ "Adult",
    age >= 60 ~ "Senior",
    TRUE ~ "Unknown"
  ))

# 4. Mean Fare by Pclass and Survived
fare_summary <- titanic %>%
  group_by(pclass, survived) %>%
  summarise(mean_fare = mean(fare, na.rm = TRUE), .groups = "drop")

# Display results
head(titanic_sorted)
head(titanic$agegroup)
print(fare_summary)


# Load Facebook dataset
facebook <- read.csv("dataset_Facebook.csv")

# 5. Group by Type and compute average likes
likes_by_type <- facebook %>%
  group_by(Type) %>%
  summarise(avg_likes = mean(like, na.rm = TRUE), .groups = "drop")

# Display results
print(likes_by_type)


-----------------------------------------------------------------------------------------
#      Handling Missing Values
  
#1. Identify the columns with missing values in the Titanic dataset.
#2. Replace missing Age values with the median Age.
#3. Drop rows where Embarked is missing.
#4. For Lung Capacity dataset, fill missing values of LungCap with the mean LungCap.
#5. Explain the difference between:
#  - Listwise deletion
#- Pairwise deletion
#- Mean/median imputation
  
  
  
  # Load Titanic dataset
  titanic <- read.csv("train_titanic.csv")

# 1. Identify columns with missing values
missing_summary <- colSums(is.na(titanic))
print(missing_summary)

# 2. Replace missing Age values with median Age
median_age <- median(titanic$Age, na.rm = TRUE)
titanic$Age[is.na(titanic$Age)] <- median_age

# 3. Drop rows where Embarked is missing
titanic_cleaned <- titanic[!is.na(titanic$Embarked), ]


# Load Lung Capacity dataset
library(readxl)
lungcap <- read_excel("LungCap_Dataset.xls")

# Fill missing LungCap values with mean
mean_lungcap <- mean(lungcap$LungCap, na.rm = TRUE)
lungcap$LungCap[is.na(lungcap$LungCap)] <- mean_lungcap


---------------------------------------------------------------------------------------------
#  Exploratory Data Analysis (EDA)

#1. Draw a histogram of Age (Titanic dataset).
#2. Create a bar chart of Pclass vs. count of passengers.
#3. Plot a boxplot of LungCap by Gender.
#4. In Facebook dataset:
#  - Create a scatter plot of Likes vs Comments.
#- Create a histogram of Shares.
#5. For Titanic dataset, use a pie chart to show the proportion of survivors vs non-survivors.
  
  library(ggplot2)
library(readxl)


# Load Titanic dataset
titanic <- read.csv("train_titanic.csv")

# 1. Histogram of Age
ggplot(titanic, aes(x = Age)) +
  geom_histogram(binwidth = 5, fill = "steelblue", color = "black") +
  labs(title = "Age Distribution", x = "Age", y = "Count")

# 2. Bar chart of Pclass vs. count of passengers
ggplot(titanic, aes(x = factor(Pclass))) +
  geom_bar(fill = "darkorange") +
  labs(title = "Passenger Count by Class", x = "Passenger Class", y = "Count")

# 5. Pie chart of survivors vs non-survivors
survival_data <- data.frame(
  Status = c("Survived", "Did Not Survive"),
  Count = c(sum(titanic$Survived == 1), sum(titanic$Survived == 0))
)

ggplot(survival_data, aes(x = "", y = Count, fill = Status)) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar("y") +
  labs(title = "Survival Proportion") +
  theme_void()


# Load Lung Capacity dataset
lungcap <- read_excel("LungCap_Dataset.xls")

# 3. Boxplot of LungCap by Gender
ggplot(lungcap, aes(x = Gender, y = LungCap, fill = Gender)) +
  geom_boxplot() +
  labs(title = "Lung Capacity by Gender", x = "Gender", y = "Lung Capacity")


# Load Facebook dataset
facebook <- read.csv("dataset_Facebook.csv")

# 4a. Scatter plot of Likes vs Comments
ggplot(facebook, aes(x = like, y = comment)) +
  geom_point(color = "purple", alpha = 0.6) +
  labs(title = "Likes vs Comments", x = "Likes", y = "Comments")

# 4b. Histogram of Shares
ggplot(facebook, aes(x = share)) +
  geom_histogram(binwidth = 50, fill = "forestgreen", color = "black") +
  labs(title = "Distribution of Shares", x = "Shares", y = "Count")


------------------------------------------------------------------------------------------
  
#               Detecting and Handling Outliers


#Boxplot Method

#1. Using the Titanic dataset:
 # - Create a boxplot of Fare and visually identify potential outliers.
#- Create a boxplot of Age separated by Survived (use boxplot(Age ~ Survived, data=Titanic) in R).
#- Which group (Survived/Not Survived) has more spread in ages?
 # 2. Using the Facebook dataset:
  #- Create a boxplot of Likes and identify extreme posts.
#- Draw a combined boxplot of Likes, Shares, and Comments side by side.
#- Which metric has the highest variation
  
  
  library(ggplot2)
library(readxl)
# Load Titanic dataset
titanic <- read.csv("train_titanic.csv")

# Boxplot of Fare to identify outliers
ggplot(titanic, aes(y = Fare)) +
  geom_boxplot(fill = "skyblue") +
  labs(title = "Boxplot of Fare", y = "Fare")

# Boxplot of Age by Survived status (base R method)
boxplot(Age ~ Survived, data = titanic,
        main = "Age Distribution by Survival Status",
        xlab = "Survived", ylab = "Age",
        col = c("tomato", "lightgreen"))

# Optional: Compare spread using IQR
iqr_survived <- IQR(titanic$Age[titanic$Survived == 1], na.rm = TRUE)
iqr_not_survived <- IQR(titanic$Age[titanic$Survived == 0], na.rm = TRUE)

cat("IQR (Survived):", iqr_survived, "\n")
cat("IQR (Not Survived):", iqr_not_survived, "\n")



# Load Facebook dataset
facebook <- read.csv("dataset_Facebook.csv")

# Boxplot of Likes to identify extreme posts
ggplot(facebook, aes(y = like)) +
  geom_boxplot(fill = "orchid") +
  labs(title = "Boxplot of Likes", y = "Likes")

# Combined boxplot of Likes, Shares, Comments
facebook_long <- facebook %>%
  select(like, share, comment) %>%
  pivot_longer(cols = everything(), names_to = "Metric", values_to = "Value")

ggplot(facebook_long, aes(x = Metric, y = Value, fill = Metric)) +
  geom_boxplot() +
  labs(title = "Engagement Metrics Distribution", x = "Metric", y = "Value")

# Optional: Compare variation using IQR
iqr_likes <- IQR(facebook$like, na.rm = TRUE)
iqr_shares <- IQR(facebook$share, na.rm = TRUE)
iqr_comments <- IQR(facebook$comment, na.rm = TRUE)

cat("IQR - Likes:", iqr_likes, "\n")
cat("IQR - Shares:", iqr_shares, "\n")
cat("IQR - Comments:", iqr_comments, "\n")


----------------------------------------------------------------------------------
