library(ggplot2)
data <- read.csv("data/dataset_breastcancer.csv")

# dist of one var - histogram
ggplot(data=data, aes(x=ages*status)) +
  geom_histogram() +
  xlim(1,max(ages)) +
  labs(title = 'Number of Breast Cancer Patients per Age',
       x = 'Age (yrs)',
       y = 'Number of Patients')

# numeric vs. categorical - violin + boxplot
data$grade <- as.factor(data$grade)
ggplot(data=data, aes(x=grade, y=size)) +
  geom_violin(aes(fill=grade)) + 
  geom_boxplot(width=0.2, fill=NA) +
  labs(title = "Distribution of Tumor Sizes by Tumor Grade",
       x = 'Tumor Grade',
       y = 'Tumor Size (mm)')

# numeric vs. numeric - scatter
ggplot(data=data, aes(x=size, y=rfstime)) +
  geom_point() +
  labs(title='Recurrence Free Survival Time per Tumor Size',
       x = 'Tumor Size (mm)',
       y = 'Recurrence Free Survival Time (days)')