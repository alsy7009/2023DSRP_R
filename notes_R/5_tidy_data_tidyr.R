#install.packages('tidyr')
#install.packages('janitor')

library(tidyr)
library(janitor)
library(dplyr)

clean_names(starwars, case='small_camel')
new_satrwars <- clean_names(starwars, case='screaming_snake')
clean_names(starwars, case='upper_lower')

clean_names(new_starwars) #snake case

new_starwars <- rename(new_starwars, `hair*color` = hair_color)
clean_names(new_starwars)

StarWarsWomen <- select(filter(arrange(starwars, birth_year), sex=='female'), name, species)

## pipes
StarWarsWomen <- starwars |> 
  filter(sex=='female') |> 
  arrange(birth_year) |> 
  select(name, species)
StarWarsWomen

slice_max(starwars, height, n=10)
slice_max(starwars, height, n=2, by=species)

## Tidy data ####
table4a
tidy_table4a <- pivot_longer(table4a,
                             cols = c(`1999`, `2000`),
                             names_to = 'year',
                             values_to = 'cases')
# ctrl+i to fix indentions

table4b # population data
## pivot table4b to be in "tidy" form
tidy_table4b <- pivot_longer(table4b,
                             cols = c(`1999`, `2000`),
                             names_to = 'year',
                             values_to = 'population')

## pivot wider
table2
pivot_wider(table2,
             names_from = type,
            values_from = count)

## separate
table3
separate(table3,
         rate,
         into = c('cases','population'),
         sep = '/') # automatically finds symbols and split if not specified

## unite
table5
tidy_table5 <- unite(table5,
      'year',
      c('century','year'),
      sep = '') |>
  separate(rate,
           into = c('cases','population'),
           sep = '/')

## bind rows
new_data <- data.frame(country = 'USA', year = '1999', cases = '1042', population = '2000000')
bind_rows(tidy_table5, new_data)
