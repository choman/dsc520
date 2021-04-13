# Assignment: ASSIGNMENT 5.2
# Name: Homan, Chad
# Date: 2021-04-13

# We interact with a few datasets in this course, one you are
# Using either the same dataset(s) you used in the previous
# weeks’ exercise or a brand-new dataset of your choosing,
# perform the following transformations (Remember, anything
# you learn about the Housing dataset in these two weeks can
# be used for a later exercise!)
#
#  - Using the dplyr package, use the 6 different operations
#    to analyze/transform the data - GroupBy, Summarize, Mutate,
#    Filter, Select, and Arrange – Remember this isn’t just
#    modifying data, you are learning about your data also – so
#    play around and start to understand your dataset in more
#    detail
#  - Using the purrr package – perform 2 functions on your
#    dataset.  You could use zip_n, keep, discard, compact, etc.
#  - Use the cbind and rbind function on your dataset
#  - Split a string, then concatenate the results back together
#

USE_XLSX <- FALSE
DEBUG    <- FALSE

## Load the ggplot2 package
# clean package loading based on 
# https://statisticsglobe.com/r-install-missing-packages-automatically
mypackages <- c("ggplot2", "pastecs", "plyr", "dplyr")
if (USE_XLSX) {
  mypackages <- append(mypackages, "xlsx")
} else {
  mypackages <- append(mypackages, "readxl")
}

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
workdir <- file.path(workdir, "week05")

## Set the working directory
setwd(workdir)

## Load the `housing` to data
filename <- "week-6-housing.xlsx"

if (USE_XLSX) {
  house_df <- xlsx::read.xlsx(filename)
} else {
  sheet_names <- excel_sheets(filename)
  house_df    <- readxl::read_xlsx(filename)
  sheet_names
}

house_df

# -  What are the elements in your data (including the categories and
#    data types)?
summary(acs_df)
summary(house_df)

# -  Please provide the output from the following functions: str();
#    nrow(); ncol()
str(acs_df)
nrow(acs_df)
ncol(acs_df)

str(house_df)
nrow(house_df)
ncol(house_df)

#  - Use the apply function on a variable in your dataset
#   NOTE: I need to get smarter on apply
apply(house_df, 2, is.vector)
apply(house_df, 2, is.na)
dimnames(house_df)
#apply(house_df$`Sale Price`, 2, is.na)


#  - Use the aggregate function on a variable in your dataset
aggregate(`Sale Price` ~ bath_full_count, house_df, mean)
aggregate(`Sale Price` ~ square_feet_total_living, house_df, mean)
aggregate(`Sale Price` ~ square_feet_total_living + bath_full_count, house_df, mean)
aggregate(`Sale Price` ~ zip5, house_df, mean)

#  - Use the plyr function on a variable in your dataset – more
#    specifically, I want to see you split some data, perform a
#    modification to the data, and then bring it back together
#library(plyr)
any(is.na(house_df$`Sale Price`))
any(is.na(house_df$bath_full_count))
house_df$`Sale Price`[house_df$`Sale Price` < 80000]

# NOTE: I need to get smarter on ddply!! :)
ddply(house_df, .(house_df$`Sale Price`), summarize, mean=round(mean(house_df$`Sale Price`)))

#  - Check distributions of the data
p = runif(house_df$`Sale Price`)
hist(house_df$`Sale Price`)

#  - Identify if there are any outliers
summary(house_df)
summary(house_df$`Sale Price`)
hist(house_df$`Sale Price`)
boxplot(house_df$`Sale Price`)

# Based on my histogram and boxplot I believe there 
# are outliers in the data.

#  - Create at least 2 new variables
get_values <- function(seq) {
  samp <- seq
  rand <- c(sample(samp, nrow(house_df)))
  return(rand)
}

arv <- get_values(100000:800000)
roi <- get_values(10000:100000)
if (DEBUG) {
  arv
  roi
}

head(house_df)
house_df$ARV <-arv
house_df$ROI <-roi
dimnames(house_df)

