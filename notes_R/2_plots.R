## install required packages (only once, requires updates)
#install.packages("ggplot2")
install.packages(c('usethis','credentials'))

## load required packages (every time, "import package")
library(ggplot2)

#?ggplot2 # gg = "grammar of graphs"
mpg
str(mpg)

## scatter plot
ggplot(data=mpg, aes(x=hwy, y=cty)) + 
  geom_point() +
  labs(x = 'highway mpg',
       y = 'city mpg',
       title = 'car city vs highway mileage')
ggplot(data=iris, aes(x=Sepal.Length, y=Sepal.Width)) +
  geom_point()
ggplot(data=iris, aes(x=Species, y=Sepal.Width)) +
  geom_jitter(width=0.25)

#ggsave('plots/exampleJitter2.png')

## histogram
# set number of bars with `bins`
ggplot(data=mpg, aes(x=hwy)) +
  geom_histogram()
ggplot(data=iris, aes(x=Sepal.Length)) +
  geom_histogram(bins=35) #default bin num is 30

# set size of bars with `binwidth`
ggplot(data=iris, aes(x=Sepal.Length)) +
  geom_histogram(binwidth=0.25)

head(iris)
## density plots
ggplot(data=iris, aes(x=Sepal.Length), y=after_stat(count)) +
  geom_density() +
  labs(title="Frequency of Iris Sepal Lengths",
       x="Sepal Length",
       y="density")

## boxplot (used to plot one numeric variable)
ggplot(data=iris, aes(x=Sepal.Length)) +
  geom_boxplot()
ggplot(data=iris, aes(y=Sepal.Length)) +
  geom_boxplot()
ggplot(data=iris, aes(x=Sepal.Length, y=Species)) +
  geom_boxplot()

## violin plots
ggplot(data=iris, aes(x=Species, y=Sepal.Length)) +
  geom_violin()

## layering violin plots and boxplots
ggplot(data=iris, aes(x=Species, y=Sepal.Length)) +
  geom_violin(color='violet', fill='grey95') + 
  geom_boxplot(width=0.2, fill=NA) +
  labs(title = "Distribution of Iris Sepal Lengths by Species",
       x = 'Species',
       y = 'Sepal Length')

ggplot(data=iris, aes(x=Species, y=Sepal.Length)) +
  geom_violin(aes(fill=Species)) + 
  geom_boxplot(width=0.2, fill=NA) +
  labs(title = "Distribution of Iris Sepal Lengths by Species",
       x = 'Species',
       y = 'Sepal Length')

colors()

## barplots
ggplot(data = iris, aes(x = Species, y= Sepal.Length, fill=Species)) +
  geom_bar(stat = "summary",
           fun = "mean")

## line plot
ggplot(data=iris, aes(x=Sepal.Length, y=Sepal.Width)) +
  geom_line(stat='summary', fun='mean')
ggplot(data=iris, aes(x=Sepal.Length, y=Sepal.Width)) +
  geom_point()+
  geom_smooth(se=F)

## color scales
ggplot(data=iris, aes(x=Sepal.Length, y=Sepal.Width)) +
  geom_point(aes(color=Species)) +
  scale_color_manual(values=c('violet','lightpink','red'))

## factors (year is categorical but uses numbers, converts it to categorical)
mpg$year <- as.factor(mpg$year)

iris$Species <- factor(iris$Species, levels=c('versicolor','setosa','virginica'))
