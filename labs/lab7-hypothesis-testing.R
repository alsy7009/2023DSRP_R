# small p-value = correlation
# part 1: Test for a significant difference between 2 groups
# null hypothesis: the average age for grade 1 and grade 2 tumors is the same
data <- read.csv("data/dataset_breastcancer.csv")
grade1 <- filter(data, grade==1)
grade2 <- filter(data, grade==2)
t.test(grade1$age, grade2$age, alternative = 'two.sided')
# p = 0.5894. Fails to reject null hypothesis

# part 2: Test for a significant difference between 3+ groups
# null hypothesis: the average rfstime for different tumor grades is the same
data$grade <- as.factor(data$grade)

aov_rfstime_grade <- aov(rfstime ~ grade, data)
summary(aov_rfstime_grade)
TukeyHSD(aov_rfstime_grade)
# p = 0.0440311, 0.0000453, and 0.0029154 for grades 2-1, 3-1, and 3-2 respectively
# p-value supports alternative hypothesis

# part 3: Test for a significant association between categorical variables
# null hypothesis: there is no association between the tumor grade and menopause status
data$meno <- as.factor(data$meno)

t <- table(data$grade, data$meno)
chi <- chisq.test(t)
chi$p.value
chi$residuals
# p = 0.5545161. Fails to reject null hypothesis