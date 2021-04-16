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

DEBUG    <- FALSE

## Load the ggplot2 package
# clean package loading based on 
# https://statisticsglobe.com/r-install-missing-packages-automatically
mypackages <- c("ggplot2", "pastecs", "plyr", "dplyr", "purrr", "stringr")
mypackages <- append(mypackages, "readxl")


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

sheet_names <- excel_sheets(filename)
house_df    <- readxl::read_xlsx(filename)
sheet_names

house_df
house_df %>% head(4) %>% dim()
class(house_df)
# -  What are the elements in your data (including the categories and
#    data types)?
summary(house_df)

# -  Please provide the output from the following functions: str();
#    nrow(); ncol()
str(house_df)
nrow(house_df)
ncol(house_df)

#  - Use the apply function on a variable in your dataset
#   NOTE: I need to get smarter on apply
apply(house_df, 2, is.vector)
apply(house_df, 2, is.na)
dimnames(house_df)
#apply(house_df$`Sale Price`, 2, is.na)

#  - Using the dplyr package, use the 6 different operations
#    to analyze/transform the data - GroupBy, Summarize, Mutate,
#    Filter, Select, and Arrange – Remember this isn’t just
#    modifying data, you are learning about your data also – so
#    play around and start to understand your dataset in more
#    detail
data(house_df, package="ggplot2")
# GroupBy
house_df %>% group_by(square_feet_total_living) 
house_df %>% group_by(square_feet_total_living) %>% summarize(mean(bath_full_count))

# Summarize
house_df %>% summarize(mean('Sale Price'))

# Mutate
dimnames(house_df)
house_df %>% mutate(Price_per_foot=`Sale Price`/square_feet_total_living)
house_df %>% mutate(Price_per_foot=`Sale Price`/square_feet_total_living) %>% select(zip5, Price_per_foot)

# filter
house_df %>% filter(bath_full_count == 3)
house_df %>% filter(bath_full_count %in% c(2,3))
house_df %>% filter(`Sale Price` < 100000)

# select
select(house_df, "Sale Price", bath_full_count)
house_df %>% select(`Sale Price`, bath_full_count, bedrooms)

# arrange
house_df %>% arrange(-`Sale Price`, bath_full_count, -bedrooms)

#
#  - Using the purrr package – perform 2 functions on your
#    dataset.  You could use zip_n, keep, discard, compact, etc.
dimnames(house_df)[2]
any(is.na(house_df$sale_warning))
stuff <- house_df$sale_warning %>% discard(is.na)
identical(house_df$sale_warning, stuff)

data <- house_df %>% select_if(is.numeric) %>% map(mean)
data

#
#  - Use the cbind and rbind function on your dataset
dimnames(house_df)
newdf <- cbind(house_df$'Sale Price', house_df$square_feet_total_living)
newdf
headdf <- head(house_df)
taildf <- tail(house_df)

newdf <- rbind(headdf, taildf)
newdf

#
#  - Split a string, then concatenate the results back together
# First with the R base packages
mystring <- "The dog ate my homework"
mystring
mylist <- strsplit(mystring, " ")[[1]]
mylist
class(mylist)
mystring2 <- paste(mylist, collapse=" ", sep=" ")
class(mystring2)
mystring2
identical(mystring, mystring2)
#
# And now using stringr
mylist <- str_split(mystring2, " ")[[1]]
mylist
mystring <- paste(mylist, collapse=" ", sep=" ")
mystring
identical(mystring, mystring2)

