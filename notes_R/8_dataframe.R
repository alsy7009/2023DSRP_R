# create data frame
zooData <- data.frame(animals = c('lion', 'tiger', 'bear'),
           age = c(10, 2, 7))

predicted <- c(1,3,5,7,6)
actual <- c(2,4,1,8,6)

library(Metrics)
errors <- data.frame(mae=mae(actual, predicted),
                     rmse=rmse(actual, predicted),
                     modelType = 'randForest')

predicted2 <- c(5,6,5,9,3)
errors <- rbind(errors, 
                data.frame(mae=mae(actual, predicted2),
                     rmse=rmse(actual, predicted2),
                     modelType = 'boostTree'))

# make data frame all at once
errors <- data.frame(mae = c(mae(actual, predicted), mae(actual, predicted2)),
                     rmse = c(rmse(actual, predicted), rmse(actual, predicted2)),
                     modelType = c('randForest', 'boostTree'))

# plot errors
library(ggplot2)
ggplot(errors, aes(x=modelType, y=rmse)) +
  geom_bar(stat='summary', fun='mean')

values <- data.frame(actual = actual,
           predicted = predicted,
           predicted2 = predicted2)

ggplot(values, aes(x=actual, y=predicted)) +
  geom_abline(lty = 'dashed') +
  geom_point() +
  theme_minimal() +
  annotate(geom='text', label= paste('rmse =', round(rmse(actual,predicted),2)),
             x = 6, y = 1.5)
