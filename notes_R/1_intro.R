2 + 2

number <- 5
number
number + 1
number <- number + 1

#this is a comment
number <- 10 # set number to 10

print(number)
# R Objects ####
ls() # print names of all objects in our environment
rm(logic2)
rm("number") # removes object(s)

number <- 5
decimal <- 1.5

letter <- "a"
word <- "hello"

logic <- TRUE
logic2 <- T

## types of variables
## 3 main classes: numeric, character, logical
class(number)
class(decimal) # numeric

class(letter)
class(word) # character

class(logic) # logical


## there is more variation in types
typeof(number) # double (by default)
typeof(decimal)

## change type of object
as.character(number)
as.integer(number)
as.integer(decimal)


## how to round numbers (not truncate)
round(decimal) # round by 0.5 rule
round(22/7, 3) # 3 values after decimal
?round

22/7
ceiling(22/7)
floor(22/7)

?as.integer
word_as_int <- as.integer("hello")

## NA values
NA + 5

## naming 
# using periods and "=" are allowed
name <- "Sarah"
NAME <- "Joe"
n.a.m.e. <- "Sam"
n_a_m_e <- "Lisa"

## illegal naming schemes:
# starting with number
# starting with underscore
# using operators: + - * / =
# conditionals: & | < > !
# forward/backslash
# spaces, $

## good naming conventions
camelCase <- "start with capital letter"
snake_case <- "underscores between words"

## object manipulation ####
number
number + 7

decimal
number + decimal

name
paste(name,"Parker", "is", "awesome") # concatenates character vectors
paste(name, "Parker is awesome")
paste0(name,"Parker")

paste(name,number) # can join characters and numbers
logic <- T
paste(name,logic)

myName <- "Amy"
paste("My name is", myName)

?grep # global regex (regular expression) print
food <- "watermelon"
grep("me", food)
grepl("me", food)
sub("me","you",food)
# wateryulan 
sub("me", "", food)



# Vectors ####
# make a vector of numerics
numbers <- c(2,4,6,8,10) #combine
range_of_vals <- 1:5 # all ints from 1-5 inclusive
5:10
seq(2,10,2) # from 2 to 10 by 2's
seq(to=10, by=2, from=2) #can put parameters out of order if they're named

rep(3,5) # repeat 3 5x
rep(c(1,2),5) # repeat 1,2 5x

# get all values between 1 and 5 by 0.5
seq(1,5,0.5)

# get [1 1 1 2 2 2]
c(rep(1,3), rep(2,3))
rep(1:2, each=3)

# make vector of characters
letters <- c("a","b","c")
paste("a","b","c")

letters <- c(letters,"d")
letter
letters <- c(letters, letter)
letters <- c("x",letters,"w")

# make a vector of random numbers between 1 and 20
numbers <- 1:20
five_nums <- sample(numbers, 5, replace=F)
five_nums <- sort(five_nums)
rev(five_nums) # reverse 

fifteen_nums <- sample(numbers, 15, replace=T)
fifteen_nums <- sort(fifteen_nums)
length(fifteen_nums)
unique(fifteen_nums)
length(unique(fifteen_nums))

table(fifteen_nums) # get count of each value in vector
fifteen_nums + 5 #elementwise addition
fifteen_nums/2

nums1 <- c(1,2,3)
nums2 <- c(4,5,6)
nums1 + nums2 # values added together element-wise

nums3 <- c(nums1,nums2)
nums3 + nums1 # values recycled (broadcasted?) to add together, lengths must be multiple
nums3 + nums1 + 1

sum(nums3 + 1)
sum(nums3) + 1

# Vector indexing
numbers <- rev(numbers)
numbers
numbers[1]
numbers[5]

numbers[c(1,2,3,4,5)]
numbers[1:5]
numbers[c(1,5,2,12)]
i <- 5
numbers[i]

# datasets ####
?datasets
library(help = "datasets")
?mtcars
mtcars

View(mtcars) #view entire dataset in new tab

summary(mtcars) # gives us info about spread of each variable
str(mtcars) # preview the structure

names(mtcars) # var names
head(mtcars) # var names and first 6 rows
head(mtcars, 10) # var names and first 10 rows

## pull out individual vars as vectors
mpg <- mtcars[,1] # blank means "all". All rows, first column
mtcars[2,2] # value at 2nd row, 2nd column
mtcars[3,] #3rd row, all columns
mtcars[,1:3] #all rows, first 3 columns

# use names to pull out columns
mtcars$gear
mtcars[,c("gear", 'mpg')]

sum(mtcars$gear)


# Statistics ####
first5 <- iris$Sepal.Length[1:5]
mean(first5)
mean(iris$Sepal.Length)

median(first5)
median(iris$Sepal.Length)

max(first5) - min(first5) # range stat
range(first5)
max(iris$Sepal.Length) - min(iris$Sepal.Length)

#variance
var(first5)
var(iris$Sepal.Length)

#stdev
sd(first5)
sqrt(var(first5)) # stdev = sqrt(variance)

#interquartile range (range of middle 50%)
IQR(first5)
quantile(first5, 0.25) #Q1. 25% of data is at or below this value
quantile(first5, 0.73) #Q3

sl <- iris$Sepal.Length

#outlier bounds
lower <- mean(sl) - 3*sd(sl)
upper <- mean(sl) + 3*sd(sl)
as.numeric(quantile(sl,0.25) - 1.5*IQR(sl))
quantile(sl,0.75) + 1.5*IQR(sl)

## subsetting vectors
first5
first5 < 4.75
first5[first5 < 4.75 | first5 > 5]

values <- c(first5,3,9)
upper
lower

values_no_outliers <- values[values > lower & values < upper]
getwd() # get working directory
super_data <- read.csv("data/dataset_super_hero_powers.csv")

## Conditionals ####
x <- 5
x > 3
numbers == 3

sum(1,2,3,NA,na.rm=T)
mean(c(1,2,3,NA), na.rm=T)
