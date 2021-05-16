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


################################################################
#
# Start loading default operations
#
################################################################
## Load the ggplot2 package
# clean package loading based on 
# https://statisticsglobe.com/r-install-missing-packages-automatically
mypackages <- c("ggplot2", "pastecs", "plyr", "dplyr", "purrr", "stringr")
mypackages <- append(mypackages, c("readxl"))
mypackages <- append(mypackages, c("boot", "QuantPsyc"))
mypackages <- append(mypackages, c("relaimpo", "corrplot")) #, "Boruta"))
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

## Set the working directory to the root of your DSC 520 directory
## to include the week of the assignment
workdir <- system("git rev-parse --show-toplevel", intern=TRUE) 
workdir <- file.path(workdir, "week10")

## Set the working directory
setwd(workdir)

## Load the `housing` to data
filename <- "ThoraricSurgery.arff"
ts.df <- farff::readARFF(filename)

head(ts.df)
summary(ts.df)

