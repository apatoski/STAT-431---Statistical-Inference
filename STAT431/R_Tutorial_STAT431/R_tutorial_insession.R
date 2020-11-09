# title: "STAT471: Intro To R"
# author: "Raiden Hasegawa"
# date: "August 27, 2015"

# This is the companion R script

# Installing RStudio

# Preliminaries

## A few basic notes on syntax and creating an R document

# This is a comment
x <- pi # this assigns the variable x the value π
paste("π is approximately",x) # this concatenates strings separated by spaces
# these two operations do the same thing:
x <- cos(pi) # prefered syntax
x =  cos(pi)


## Setting your working directory

getwd()                # Get your current working directory
setwd("~/TA/STAT471/R_Tutorial_STAT471") # Set working directory (where R will search for files)
# or...
dir <- "~/TA/STAT471/R_Tutorial_STAT471"
setwd(dir)             # pass the string variable dir to setwd()

## Here's an example of how to read in a .csv data file located in your working directory:

radio=read.csv("Survey_results_final.csv", header=T, na.strings="")		
# comma is default seperator for read.csv: sep=","
# with some different options now
radio=read.csv("Survey_results_final.csv",header=T, stringsAsFactors=F,as.is=T, na.strings="")


## HELP!!! How to get it
?read.csv
??read.csv
help(read.csv)
apropos("read")	#	List all the functions with "read" as part of the function. Very useful!

# google: R: how to import a data set? 
# If you pair "R" with some phrase related 
# to stats or data google usually does a good job

args(read.csv) # list all the arguments
str(read.csv)  # string representation of read.csv function
# ... both of these show you the defaul arguments (if there are any)



## Packages: what are they and how to install them

install.packages("MASS")    # Many packages available. We only need a few.
library(MASS)       # load package MASS
help(package=MASS)  # get information about MASS

installed.packages()[1:10,1] # packages installed (first 10)
pckgs.all <- available.packages("http://cran.r-project.org/bin/windows/contrib/3.2")
# get all the package with "knn" as part of the name
grep("knn", rownames(pckgs.all), val=T) 
# get first 10 packages with "plot" as part of the name
grep("plot", rownames(pckgs.all), val=T )[1:10]



# Cleaning and examining the data

## Quick Check

class(radio)
str(radio) # make sure the variables are correctly defined.


## Get a table view

# If our dataset is not too big, we can graphically inspect the data in an Excel-like table with
View(radio) # note that case matters in R


##	Inspect the first (or last) few rows

head(radio) # or tail(radio), or head(radio,10) -- the first 10 rows
# In this case, the graphical `View()` command is a better option.

## Find the size of the data or the numbers or rows and columns

dim(radio)


## Get the variable names

names(radio)[1:10] # hear we look at only the first 10


## Work with a subset which includes relevant variables

radio1=radio[, c( 24,28:33)] # take columns 24, 28, ... 33
str(radio1)
View(radio1)
head(radio1)
dim(radio1)
summary(radio1)

## rename the varables

names(radio1)
names(radio1)=c("worktime", "age", "education", "gender", "income", "sirius", "wharton")
names(radio1)
str(radio1) # Notice that age is not a continuous variable, why?

## Cleaning up the data: subsetting data

summary(radio1)
levels(radio1$age)

# need to take care of "27`", "Eighteen (18)", "female" and "223"
radio1$age[radio1$age == "27`"] <- 27
radio1$age[radio1$age == "Eighteen (18)"] <- 18
radio1$age[radio1$age == "female"] <- NA

radio1$age=as.character(radio1$age)
radio1$age=as.numeric(radio1$age)


## Summarizing data

summary(radio1$age)
radio2=radio1[(radio1$age >15) & (radio1$age < 100), ]
hist(radio2$age, breaks=10, main="Hist of age", xlab="age")
# use a large number as break points to see the details



## Excluding missing data: more subsetting

radio1=radio1[!is.na(radio1$sirius),]
radio1=radio1[!(radio1$sirius==""),]
radio1=radio1[!is.na(radio1$wharton),]
radio1=radio1[!(radio1$wharton==""),]
dim(radio1)
paste("The complete data has", dim(radio1)[1], "cases")
str(radio1)


## make all varaibles with correct nature

radio1$wharton=as.factor(radio1$wharton)
radio1$sirius=as.factor(radio1$sirius)
radio1$gender=as.factor(radio1$gender)
radio1$income=as.factor(radio1$income)
str(radio1)
summary(radio1)


## We could output radio1 as a cleaner data

# row.names=T  by default, we usually don't want these
write.csv(radio1, file="Radio_Survey_Clean.copy", row.names=F) 
temp=read.csv("Radio_Survey_Clean.copy", header=T)
dim(temp)
str(temp)
head(temp)


## A primer on simple linear regression and plotting

# Reading in data 
fName <- "tips.txt" # store your file name as a string variable
# (see also "read.table" for another function to read in data)
tips <- read.csv(fName, header = T, sep=",", stringsAsFactors = T)


# Taking a peak around
dim(tips)      # the size of the data
head(tips)     # look at the first few entries
head(tips, 10) # look at the first ten entries
names(tips)    # see the name of the columns
summary(tips)  # get a simple summary of each variable


# Accessing variables in data frame
tips[1,1]            # all equivalent ways 
tips[1,"total_bill"]  # of accessing the same 
tips$total_bill[1]     # variable in the data frame


## Creating a new variable as a function of other variables
tips$percent <- 100*tips$tip/tips$total_bill # create a new variable


# Plotting

## A very basic plot

plot(tips$total_bill,tips$percent) 


## The same plot with some bells and whistles

plot(tips$total_bill, tips$percent, 
     main = "Total Bill v. Percent Tip", # give plot a title
     xlab = "Percent",    # label the x-axis
     ylab = "Total Bill", # label the y-axis
     pch = 16,            # change the type of plot point
     col = "red",         # set the color of plot point
     lwd = 2,             # set the line width
     xlim = c(0, 60),     # change limits of x-axis
     ylim = c(0,50))      # change the limits of y-axis


## You can also just set a few options

plot(tips$total_bill, 
     tips$percent, 
     col="red", 
     main="Total Bill v. Percent Tip")


## A few more useful plot types

hist(tips$percent, breaks=10)                               # A histogram
boxplot(tips$percent ~ tips$sex, main = "Tip by Sex")       # A boxplot
boxplot(tips$percent ~ tips$smoker, main = "Tip by Smoker") # Another boxplot


## Saving Plots

pdf("boxplot.pdf") # open pdf graphics device;
# analogous commands: jpeg(), png()
boxplot(tips$percent ~ tips$sex) # A boxplot
dev.off()                        # close device and 
# save plot to pdf


## A simple linear regression

model <- lm(percent ~ total_bill, data = tips) # save your regression as an object
model # show modelling results
model.summary <- summary(model) # save the results summary as an object
model.summary # show more detailed results

# model.summary has accessible attributes
names(model.summary)
# an example
model.summary$coefficients[1,1] # a matrix of the coeffs, SEs, t-stat, p-val 

# plotting the results
plot(tips$total_bill, 
     tips$percent, 
     col="red", 
     main="Total Bill v. Percent Tip")
abline(model) # add best fit line



# Appendix: Basic Operations

## R as a calculator

1 + 1
exp(2)
pi
log(3) # this is the NATURAL log not base 10.
cos(2)


## Variables

x <- 1 # assign a value to x
x      # print the value of x
ls()            # see what variables are stored in your workspace
rm(x)           # remove x from your workspace
rm(list = ls()) # remove everything in your workspace (very handy trick)


## Vectors and Vector Arithmetic

x <- c(1,2,3,4,5) # variables can store collections of numbers
y <- 11:15  # use ":" as a quick way to write sequence of numbers
z <- c(x,y) # glue two vectors together

length(x)   # find the length of x
sum(x)      # find the sum of elements in x
max(x)      # find the maximum value, ...

x[1] <- 100 # change the value at a location
x

y[c(2,3)] <- c(1,1) # change the value at multiple locations
y

x
x > 2    # which x are bigger than 2
x[x > 2] # select the elements of x bigger than 2

z <- x + y # math is done "component wise"
z

x * y   # element by element multiplication
sqrt(x) # even "scalar" functions operate on vectors

# you can also perform standard vector alegebra
# such as dot products (not elementwise)

t(y)       # take the transpose - makes y a column vector
x %*% t(y) # dot product


## Matrices

A <- matrix(c(1,2,3,4,5,6),nrow=3,ncol=2) # elements are stored columnwise!
A

A[3,2] <- 1 # can change and access elements of a matrix
A[,1] # or a column
A[3,] # or a row


# Appendix: Further references

# Some more R references:
  # For more detail about writing functions: <http://en.wikibooks.org/wiki/R_Programming/Working_with_functions>
  # An advanced reference for those who have used R before or for those who are programmatically inclinde: <http://adv-r.had.co.nz/>
  # An excellent reference for the powerful and easy to use graphics package ggplot2 for more complex graphics: <http://www.ceb-institute.org/bbs/wp-content/uploads/2011/09/handout_ggplot2.pdf>
  # An aggregator of R blogs (with beginner to expert tips): <http://www.r-bloggers.com/>