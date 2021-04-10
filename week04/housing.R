# Assignment: ASSIGNMENT 3B
# Name: Homan, Chad
# Date: 2021-03-30

# We interact with a few datasets in this course, one you are
# already familiar with, the 2014 American Community Survey
# and the second is a Housing dataset, that provides real
# estate transactions recorded from 1964 to 2016.  For this
# exercise, you need to start practicing some data transformation
# steps – which will carry into next week, as you learn some
# additional methods.  For this week, using either dataset (or
# one of your own – although I will let you know ahead of time
# that the Housing dataset is used for a later assignment, so
# not a bad idea for you to get more comfortable with now!),
# perform the following data transformations:

#  - Use the apply function on a variable in your dataset
#  - Use the aggregate function on a variable in your dataset
#  - Use the plyr function on a variable in your dataset – more
#    specifically, I want to see you split some data, perform a
#    modification to the data, and then bring it back together
#  - Check distributions of the data
#  - Identify if there are any outliers
#  - Create at least 2 new variables

USE_XLSX <- FALSE
DEBUG    <- FALSE

## Load the ggplot2 package
# clean package loading based on 
# https://statisticsglobe.com/r-install-missing-packages-automatically
mypackages <- c("ggplot2", "pastecs", "plyr")
if (USE_XLSX) {
  mypackages <- append(mypackages, "xlsx")
} else {
  mypackages <- append(mypackages, "readxl")
}

not_installed <- mypackages[!(mypackages %in% installed.packages()[, "Package"])]
if(length(not_installed)) install.packages(not_installed)

# Load libraries
for (package in mypackages) {
  library(package, character.only=TRUE)
}

##lapply(mypackages, library)
##library(ggplot2)
##library(pastecs)
##library(plyr)
##ifelse(USE_XLSX, library(xlsx), library(readxl))

theme_set(theme_minimal())
binwidth <- .5

## Set the working directory to the root of your DSC 520 directory
## to include the week of the assignment
workdir <- system("git rev-parse --show-toplevel", intern=TRUE) 
workdir <- file.path(workdir, "week04")

## Set the working directory
setwd(workdir)

## Load the `data/r4ds/heights.csv` to
acs_df <- read.csv("acs-14-1yr-s0201.csv", stringsAsFactors=TRUE)
acs_df

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

