library(reshape2)
library(ggplot2)
library(MLmetrics)

og_data <- read.csv("data/dataset_breastcancer.csv")

# predict if patient is pos/neg for breast cancer
# clean data
data <- na.omit(og_data) |> select(age:status)

# visualize data
dataCors <- data |> cor() |> melt() |> as.data.frame()
ggplot(dataCors, aes(x=Var1, y=Var2, fill=value)) +
  geom_tile() +
  scale_fill_gradient2(low='red', high='blue', mid='white', midpoint=0)

# high correlation: meno & age
ggplot(data, aes(x=age, y=meno)) + geom_point()
# some correlation: pgr & er, age & er, nodes & size, status & nodes

# do pca
pcas <- prcomp(data, scale. = T)
summary(pcas)
pcas$rotation
(pcas$rotation)^2
pcas$x

pca_vals <- as.data.frame(pcas$x)
ggplot(pca_vals, aes(PC1, PC2)) +
  geom_point() +
  theme_minimal()

# build ML models
data <- mutate(data, meno = as.factor(meno))

class_split <- initial_split(data, prop = .75)
class_train <- training(class_split)
class_test <- testing(class_split)

# classification: logistic regression
log_fit <- logistic_reg() |>
  set_engine('glm') |>
  set_mode('classification') |>
  fit(meno ~ age + er, data = class_train)

# f1 scores
class_results <- class_test
class_results$log_pred <- predict(log_fit, class_test)$.pred_class
F1_Score(class_results$meno, class_results$log_pred)
class_results$log_pred

# classification: boosted decision tree
boost_class_fit <- boost_tree() |>
  set_engine('xgboost') |>
  set_mode('classification') |>
  fit(meno ~ pgr + er + age, data = class_train)
boost_class_fit$fit$evaluation_log

# f1 scores
class_results$boost_pred <- predict(boost_class_fit, class_test)$.pred_class
F1_Score(class_results$meno, class_results$boost_pred)