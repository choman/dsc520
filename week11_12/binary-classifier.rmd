# Assignment: Week 10
# Name: Homan, Chad
# Date: 2021-05-16
#
# Abstract: Fit a Logistic Regression Model
# - Fit a logistic regression model to the binary-classifier-data.csv dataset
# - The dataset (found in binary-classifier-data.csv) contains three variables;
#   label, x, and y. The label variable is either 0 or 1 and is the output we want
#   to predict using the x and y variables.
#   - What is the accuracy of the logistic regression classifier?
#   - Keep this assignment handy, as you will be comparing your results from this
#     week to next week.
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
mypackages <- append(mypackages, c("car", "caret"))

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
filename <- "binary-classifier-data.csv"

bd.df <- read.csv(filename)
bd.df
head(bd.df)

# - Fit a logistic regression model to the binary-classifier-data.csv dataset

bd.df$label[bd.df$label > 0]

my.glm <- glm(label ~ x + y, data = bd.df, family=binomial(link="logit"))
summary(my.glm)

# - The dataset (found in binary-classifier-data.csv) contains three variables;
#   label, x, and y. The label variable is either 0 or 1 and is the output we want
#   to predict using the x and y variables.

new.df <- data.frame(label = predict(my.glm, bd.df),
                     x = bd.df$x,
                     y = bd.df$y)

new.df


#   - What is the accuracy of the logistic regression classifier?
mean(new.df$label)


test <- predict(my.glm, type="response", newdata=bd.df)
threshold <- 0.5
install.packages("e1071")

confusionMatrix(factor(test > threshold), factor(bd.df$label == 1), positive="TRUE")

## 58%

#   - Keep this assignment handy, as you will be comparing your results from this
#     week to next week.
