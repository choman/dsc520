# Assignment: Week 10
# Name: Homan, Chad
# Date: 2021-05-16
#
# Abstract: Fit a Logistic Regression Model to Thoracic Surgery Binary Dataset
# 
# For this problem, you will be working with the thoracic surgery data set from
# the University of California Irvine machine learning repository. This dataset
# contains information on life expectancy in lung cancer patients after surgery.
# The underlying thoracic surgery data is in ARFF format. This is a text-based
# format with information on each of the attributes. You can load this data using
# a package such as foreign or by cutting and pasting the data section into a CSV
# file.
# 
# Assignment Instructions:
# - Fit a binary logistic regression model to the data set that predicts whether
#   or not the patient survived for one year (the Risk1Y variable) after the
#   surgery. Use the glm() function to perform the logistic regression. See
#   Generalized Linear Models for an example. Include a summary using the summary()
#   function in your results.
# 
# - According to the summary, which variables had the greatest effect on the
#   survival rate?
#
# - To compute the accuracy of your model, use the dataset to predict the outcome
#   variable. The percent of correct predictions is the accuracy of your model.
#   What is the accuracy of your model?
#
DEBUG            <- FALSE
REMOVALS         <- FALSE


# NOTES:
# variance -> covariance -> corrleation -> regression
# 

parent.frame(2)
################################################################
#
# Start loading default operations
#
################################################################
## Load the ggplot2 package
# clean package loading based on 
# https://statisticsglobe.com/r-install-missing-packages-automatically
mypackages <- c("this.path", "ggplot2", "pastecs", "plyr", "dplyr", "purrr")
mypackages <- append(mypackages, c("stringr"))
mypackages <- append(mypackages, c("readxl"))
mypackages <- append(mypackages, c("boot", "QuantPsyc"))
##mypackages <- append(mypackages, c("relaimpo", "corrplot")) #, "Boruta"))
mypackages <- append(mypackages, c("car", "foreign", "farff"))

mypackages

not_installed <- mypackages[!(mypackages %in% installed.packages()[, "Package"])]
if(length(not_installed)) install.packages(not_installed)

# Load libraries
##lapply(mypackages, require, character.only=TRUE)
for (package in mypackages) {
  library(package, character.only=TRUE)
}

theme_set(theme_minimal())
binwidth <- .5
getwd
## Set the working directory to the root of your DSC 520 directory
## to include the week of the assignment

workdir <- dirname(this.path(verbose=TRUE))
setwd(workdir)
workdir <- system("git rev-parse --show-toplevel", intern=TRUE) 
workdir
workdir <- file.path(workdir, "week10")

## Set the working directory
setwd(workdir)

## Load the `housing` to data
filename <- "ThoraricSurgery.arff"
ts.df <- farff::readARFF(filename)

head(ts.df)
summary(ts.df)

# - Fit a binary logistic regression model to the data set that predicts whether
#   or not the patient survived for one year (the Risk1Y variable) after the
#   surgery. Use the glm() function to perform the logistic regression. See
#   Generalized Linear Models for an example. Include a summary using the 
#   summary() function in your results.

dimnames(ts.df)
my.glm <- glm(Risk1Yr ~ PRE7 +
                        PRE4 +
                        PRE5 +
                        PRE6 +
                        PRE8 + 
                        PRE9 + 
                        PRE10 +
                        PRE11 +
                        PRE14 +
                        PRE17 +
                        PRE19 +
                        PRE25 +
                        PRE30 +
                        AGE + 
                        PRE32, 
                        data=ts.df, family=binomial(link="logit"))


summary(my.glm) 


# - According to the summary, which variables had the greatest effect on the
#   survival rate?

According to the summary; PRE9, PRER14OCT14, PRE14OCT13 and PRE30 have the 
greatest effect on the survival rate.



# - To compute the accuracy of your model, use the dataset to predict the outcome
#   variable. The percent of correct predictions is the accuracy of your model.
#   What is the accuracy of your model?






