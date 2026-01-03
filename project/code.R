# --- 1. LOAD LIBRARIES ---
library(tidyverse)
library(mice)
library(MatchIt)
library(ggplot2)

# --- 2. LOAD AND CLEAN DATA ---
df_raw <- read.csv("Thyroid-Dataset.csv", na.strings = "NA")
df_cleaned <- df_raw %>%
  filter(age > 0 & age <= 100)

# --- 3. PREPARE & IMPUTE (Phase 2) ---
df_for_imputation <- df_cleaned %>%
  filter(class == "negative") %>%
  select(
    T3, on.thyroxine, age, sex, TSH, TT4, 
    sick, pregnant, thyroid.surgery
  ) %>%
  mutate(
    on_thyroxine_numeric = ifelse(on.thyroxine == "True", 1, 0),
    sex_numeric = ifelse(sex == "F", 1, 0),
    sick_numeric = ifelse(sick == "True", 1, 0),
    pregnant_numeric = ifelse(pregnant == "True", 1, 0),
    thyroid.surgery_numeric = ifelse(thyroid.surgery == "True", 1, 0)
  ) %>%
  select(
    T3, on_thyroxine_numeric, age, sex_numeric, TSH, TT4, 
    sick_numeric, pregnant_numeric, thyroid.surgery_numeric
  )

set.seed(123)
imputed_data <- mice(df_for_imputation, m = 1, method = 'pmm', printFlag = FALSE)
df_final <- complete(imputed_data, 1)

# --- 4. RUN CAUSAL ANALYSIS (Phase 3) ---
psm_model <- matchit(
  on_thyroxine_numeric ~ age + sex_numeric + TSH + TT4 + 
    sick_numeric + pregnant_numeric + thyroid.surgery_numeric,
  data = df_final,
  method = "nearest", 
  distance = "glm"    
)

matched_data <- match.data(psm_model)

effect_model <- lm(
  T3 ~ on_thyroxine_numeric + age + sex_numeric + TSH + TT4 + 
    sick_numeric + pregnant_numeric + thyroid.surgery_numeric, 
  data = matched_data 
)

# --- 5. PRINT RESULTS & PLOTS ---
print(summary(psm_model))
print(summary(effect_model))

# Add log_tsh column for plotting
df_final <- df_final %>% mutate(log_tsh = log(TSH))
matched_data <- matched_data %>% mutate(log_tsh = log(TSH))

# Plot 1: Before
plot_before <- ggplot(df_final, aes(x = log_tsh, fill = as.factor(on_thyroxine_numeric))) +
  geom_density(alpha = 0.6) +
  scale_fill_manual(values = c("0" = "blue", "1" = "red"), labels = c("Untreated", "Treated")) +
  labs(title = "Plot 1: The Problem (Before Matching)") +
  theme_minimal()
ggsave("before_matching_plot.png", plot_before)

# Plot 2: After
plot_after <- ggplot(matched_data, aes(x = log_tsh, fill = as.factor(on_thyroxine_numeric))) +
  geom_density(alpha = 0.6) +
  scale_fill_manual(values = c("0" = "blue", "1" = "red"), labels = c("Untreated", "Treated")) +
  labs(title = "Plot 2: The Solution (After Matching)") +
  theme_minimal()
ggsave("after_matching_plot.png", plot_after)

print("--- Script Finished. All plots and results are ready. ---")