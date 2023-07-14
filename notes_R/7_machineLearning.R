## Unsupervised Learning ####
## Principal Components Analysis
iris_num <- select(iris, -Species)
iris_num

# do pca
pcas <- prcomp(iris_num, scale. = T)
summary(pcas)
pcas$rotation
# PC2 makes up 0.9581 of variance
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
