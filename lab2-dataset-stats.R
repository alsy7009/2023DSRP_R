data <- read.csv("data/dataset_breastcancer.csv")
age <- data$age

mean <- mean(age)
median <- median(age)
range <- max(age) - min(age)
variance <- var(age)
sd <- sd(age)
iqr <- IQR(age)

print("mean, median, range, variance, standard deviation, iqr:")
print(c(mean, median, range, variance, sd, iqr))

lower <- mean - 3*sd
upper <- mean + 3*sd
outliers <- age[age<lower | age>upper]
print(outliers)

age_no_outliers <- age[age>(lower) & age<(upper)]
mean_no_outliers <- mean(age_no_outliers)
median_no_outliers <- median(age_no_outliers)

print("mean and median without outliers:")
print(c(mean_no_outliers, median_no_outliers))
