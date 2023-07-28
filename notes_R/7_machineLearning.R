## Unsupervised Learning ####
## Principal Components Analysis
iris_num <- select(iris, -Species)
iris_num

# do pca
pcas <- prcomp(iris_num, scale. = T)
summary(pcas)
pcas$rotation
pcas$rotation^2
# PC2 makes up 95.81% of variance
# PCA is usually ordered from the most important component (dimension) to the least important, which is why we usually take the first one/two components

pcas$x

## get x values of PCAs and make it a data frame
pca_vals <- as.data.frame(pcas$x)
ggplot(pca_vals, aes(PC1, PC2)) +
  geom_point() +
  theme_minimal()
pca_vals$Species <- iris$Species

ggplot(pca_vals, aes(PC1, PC2, color=Species)) +
  geom_point() +
  theme_minimal()

### Supervised Machine Learning Models ####
#install.packages('tidymodels')
#install.packages('ranger')
#install.packages('xgboost')
#install.packages('reshape2')
#install.packages('MLmetrics')
#install.packages('Metrics')

library(dplyr)
library(ggplot2)

x <- 7
x <- c(1,3,5,7,9)
ifelse(x<5, 'small number', 'big number')

mean(iris$Petal.Width)

iris_new <- iris
## add categorical column
iris_new <- mutate(iris_new,
                   petal_size = ifelse(Petal.Width > 1, 'big', 'small'))
iris_new <- mutate(iris_new,
                   petal_size = case_when(
                     Petal.Width < 1 ~ 'small',
                     Petal.Width < 2 ~ 'medium',
                     TRUE ~ 'big'
                   ))
iris_new

ggplot(iris, aes(x=Sepal.Length, y=Sepal.Width)) + 
  geom_point()
#ggsave('plot_img/scatterPlot.png')

## load required packages
library(dplyr)

## step 1: collect data
head(iris)

## step 2: clean and process data
## get rid of NAs
# only use na.omit when you have specifically selected for the
# variables you want to include in the model
noNAs <- na.omit(starwars)
noNAs <- filter(starwars, !is.na(mass), !is.na(height))

# replace with means
replaceWithMeans <- mutate(starwars,
                           mass = ifelse(is.na(mass),
                                         mean(mass),
                                         mass))

## encoding categories as factors or integers
# if categorical variable is a character, make it a factor
intSpecies <- mutate(starwars,
                     species = as.factor(species))

# if categorical variable is already factor, make it an int
irisAllNumeric <- mutate(iris,
                         Species = as.integer(Species))

## step 3: visualize data
# make PCA
# calculate correlations
library(reshape2)
library(ggplot2)
irisCors <- irisAllNumeric |> cor() |> melt() |> as.data.frame()
irisCors

# heat maps geom_tile
ggplot(irisCors, aes(x=Var1, y=Var2, fill=value)) +
  geom_tile() +
  scale_fill_gradient2(low='red', high='blue', mid='white', midpoint=0)

# high correlation
ggplot(irisAllNumeric, aes(x=Petal.Length, y=Sepal.Length)) +
  geom_point() + theme_minimal()

# low correlation
ggplot(irisAllNumeric, aes(x=Sepal.Width, y=Sepal.Length)) +
  geom_point() + theme_minimal()

## step 4: perform feature selection
# choose which variables you want to classify or predict
# choose which vars to use as features in model
# for iris data
# classify on Species (classification) & predict on Sepal.Length (Regression)



## step 5: separate data into testing and training sets
library(rsample)

## set a seed for reproducability
set.seed(71723)

## regression dataset splits
# put 75% of data into training set, create a split
reg_split <- initial_split(irisAllNumeric, prop = .75)

# use the split to form testing and training tests
reg_train <- training(reg_split)
reg_test <- testing(reg_split)

# classification dataset splits (use iris instead of irisAllNumeric)
class_split <- initial_split(iris, prop = .75)
class_train <- training(class_split)
class_test <- testing(class_split)

# https://parsnip.tidymodels.org/articles/Examples.html
# glm can be used to do linear regression on non-linear data. Linear usually refers to the m1, m2, … coeffiicients

## steps 6 and 7: choose ML model and train it
library(parsnip)

#rank by significance
lm_fit <- linear_reg() |>
  set_engine('lm') |>
  set_mode('regression') |>
  fit(Sepal.Length ~ Petal.Length + Petal.Width + Species + Sepal.Width,
      data = reg_train)
## Sepal.Length = 2.3 + Petal.Length*0.7967 + Petal.Width*-0.4067 + Species*-0.3312 + Sepal.Width*0.5501

lm_fit$fit

summary(lm_fit$fit)


## logistic regression
# for logistic regression,
# 1. filter data into only 2 groups in categorical variable of interest
# 2. make categorical var a factor
# 3. make your training and testing splits

# for our purposes, just filter test and training (don't do this)
binary_test_data <- filter(class_test, Species %in% c('setosa', 'versicolor'))
binary_train_data <- filter(class_train, Species %in% c('setosa', 'versicolor'))

# build model
log_fit <- logistic_reg() |>
  set_engine('glm') |>
  set_mode('classification') |>
  fit(Species ~ Petal.Width + Petal.Length + ., data = binary_train_data)
# "." means everything else
log_fit$fit
summary(log_fit$fit)


## boosted decision trees
library('xgboost')
# min_n is the number of datapoints that end up as an output of a node of a tree to see if it should increase. The tree depth and split further e.g. for classification if >= 10 datapoints end up as the output of a node after splitting,  it will split again, but you. Can set this size using min_n=int
boost_reg_fit <- boost_tree() |> 
  set_engine('xgboost') |>
  set_mode('regression') |> 
  fit(Sepal.Length ~ ., data = reg_train)

boost_reg_fit$fit$evaluation_log

# classification
# use "classification" as mode, use Species as predictor (independent) var
# use class_train as data

boost_class_fit <- boost_tree() |>
  set_engine('xgboost') |>
  set_mode('classification') |>
  fit(Species ~ ., data = class_train)
boost_class_fit$fit$evaluation_log


## Random Forest
# regression
forest_reg_fit <- rand_forest() |>
  set_engine('ranger') |>
  set_mode('regression') |>
  fit(Sepal.Length ~ ., data = reg_train)

forest_reg_fit$fit

# classification using random forest
forest_class_fit <- rand_forest() |>
  set_engine('ranger') |>
  set_mode('classification') |>
  fit(Species ~ ., data = class_train)
forest_class_fit$fit

## step 8: evaluate model performance on test set
# calculate errors for regression
library(yardstick)

# lm_fit, boost_reg_fit, forest_reg_fit
reg_results <- reg_test
reg_results$lm_pred <- predict(lm_fit, reg_test)$.pred
reg_results$boost_pred <- predict(boost_reg_fit, reg_test)$.pred
reg_results$forest_pred <- predict(forest_reg_fit, reg_test)$.pred

yardstick::mae(reg_results, Sepal.Length, lm_pred)
yardstick::mae(reg_results, Sepal.Length, boost_pred)
yardstick::mae(reg_results, Sepal.Length, forest_pred)

yardstick::rmse(reg_results, Sepal.Length, lm_pred)
yardstick::rmse(reg_results, Sepal.Length, boost_pred)
yardstick::rmse(reg_results, Sepal.Length, forest_pred)

# calculate accuracy for classification models
library(Metrics)
class_results <- class_test
class_results$log_pred <- predict(log_fit, class_test)$.pred_class
class_results$boost_pred <- predict(boost_class_fit, class_test)$.pred_class
class_results$forest_pred <- predict(forest_class_fit, class_test)$.pred_class

#f1(class_results$Species, class_results$log_pred)
#f1(class_results$Species, class_results$boost_pred)
#f1(class_results$Species, class_results$forest_pred)

class_results$Species == 'setosa'
class_results$log_pred == 'setosa'

f1(class_results$Species == 'virginica', class_results$log_pred == 'virginica')
