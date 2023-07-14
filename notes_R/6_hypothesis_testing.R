## compare mass of male and female human star wars characters
## null hypothesis: avg mass of male and female human star wars characters are the same
## alternative hypothesis: avg mass of male and female human star wars characters are different
swHumans <- starwars |> filter(species == 'Human', mass > 0)
males <- swHumans |> filter(sex == 'male')
females <- swHumans |> filter(sex == 'female')

t.test(males$mass, females$mass, paired = F, alternative = 'two.sided') # default paired = F
# p value is 0.06505
# not significant, failed to reject null hypothesis

## ANOVA ####
iris

anova_results <- aov(Sepal.Length ~ Species, iris)

## are any groups different from each other?
summary(anova_results)

## which ones?
TukeyHSD(anova_results)

## is there significant difference in mean petal lengths or petal widths or by species?
anova_lengths <- aov(Petal.Length ~ Species, iris)
summary(anova_lengths)
TukeyHSD(anova_lengths)
# yes, p = 0

### Starwars
head(starwars)
unique(starwars$species)

## which 5 species most common?
top3species <- starwars |> 
  summarize(.by = species,
            count = sum(!is.na(species))) |>
  slice_max(count, n=3)
top3species

starwars_top3species <- starwars |>
  filter(species %in% top3species$species)

## is there significant difference in mass of each species?
a <- aov(mass ~ species, starwars_top3species)
summary(a)
TukeyHSD(a)


## Chi-Squared ####
starwars_clean <- starwars |>
  filter(!is.na(species), !is.na(homeworld))

t <- table(starwars_clean$species, starwars_clean$homeworld)
chisq.test(t) # not enough data

library(ggplot2)
table(mpg$manufacturer, mpg$class)
table(mpg$cyl, mpg$displ)

## contingency table of year and drive
t <- table(mpg$year, mpg$drv)

chisq_result <- chisq.test(t)
chisq_result
chisq_result$p.value
chisq_result$residuals

install.packages('corrplot')
library(corrplot)

corrplot(chisq_result$residuals)

## chi-squared full analysis
heroes <- read.csv('data/heroes_information.csv')
head(heroes)

## clean data
heroes_clean <- heroes |>
  filter(Alignment != '-', Gender != '-')

## plot counts of alignment and gender
ggplot(heroes_clean, aes(x=Gender, y=Alignment)) +
  geom_count() +
  theme_minimal()

## make contingency table
t <- table(heroes_clean$Alignment, heroes_clean$Gender)
str(t)

## chi squared test
chi <- chisq.test(t)
chi$p.value
chi$residuals

corrplot(chi$residuals, is.cor=F)
# big and red = a lot less than expected if these variables were independent