# Assignment: Week 08/09 Housing
# Name: Homan, Chad
# Date: 2021-05-07
#
# Abstract 
#  - Work individually on this assignment. You are encouraged to collaborate on 
#    ideas and strategies pertinent to this assignment. Data for this assignment
#    is focused on real estate transactions ecorded from 1964 to 2016 and can be
#    found in Housing.xlsx. Using your skills in statistical correlation, 
#    multiple regression, and R programming, you are interested in the following
#    variables: 
#          Sale Price and several other possible predictors.
#
#      - If you worked with the Housing dataset in previous week – you are in 
#        luck, you likely have already found any issues in the dataset and made 
#        the necessary transformations. If not, you will want to take some time 
#        looking at the data with all your new skills and identifying if you 
#        have any clean up that needs to happen.
#
#  - Complete the following:
#      - Explain any transformations or modifications you made to the
#        dataset
#      - Create two variables; one that will contain the variables 
#        Sale Price and Square Foot of Lot (same variables used from
#        previous assignment on simple regression) and one that will
#        contain Sale Price and several additional predictors of your
#        choice. Explain the basis for your additional predictor
#        selections.
#      - Execute a summary() function on two variables defined in the 
#        previous step to compare the model results. What are the R2
#        and Adjusted R2 statistics? Explain what these results tell
#        you about the overall model. Did the inclusion of the
#        additional predictors help explain any large variations found
#        in Sale Price?
#      - Considering the parameters of the multiple regression model
#        you have created. What are the standardized betas for each
#        parameter and what do the values indicate?
#      - Calculate the confidence intervals for the parameters in your 
#        model and explain what the results indicate.
#      - Assess the improvement of the new model compared to your
#        original model (simple regression model) by testing whether
#        this change is significant by performing an analysis of
#        variance.
#      - Perform casewise diagnostics to identify outliers and/or 
#        influential cases, storing each function's output in a
#        dataframe assigned to a unique variable name.
#      - Calculate the standardized residuals using the appropriate
#        command, specifying those that are +-2, storing the results 
#        of large residuals in a variable you create.
#      - Use the appropriate function to show the sum of large 
#        residuals.
#      - Which specific variables have large residuals (only cases 
#        that evaluate as TRUE)?
#      - Investigate further by calculating the leverage, cooks 
#        distance, and covariance rations. Comment on all cases that 
#        are problematics.
#      - Perform the necessary calculations to assess the assumption 
#        of independence and state if the condition is met or not.
#      - Perform the necessary calculations to assess the assumption 
#        of no multicollinearity and state if the condition is met or 
#        not.
#      - Visually check the assumptions related to the residuals using 
#        the plot() and hist() functions. Summarize what each graph is 
#        informing you of and if any anomalies are present.
#      - Overall, is this regression model unbiased? If an unbiased 
#        regression model, what does this tell us about the sample vs. 
#        the entire population model?
#
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
workdir <- file.path(workdir, "week08")

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

#      - Explain any transformations or modifications you made to the
#        dataset

#      - Create two variables; one that will contain the variables 
#        Sale Price and Square Foot of Lot (same variables used from
#        previous assignment on simple regression) and one that will
#        contain Sale Price and several additional predictors of your
#        choice. Explain the basis for your additional predictor
#        selections.
sale_price_by_lot_square_ft <- data.frame(house_df$`Sale Price`, 
                                          house_df$sq_ft_lot)

sale_price_by_lot_square_ft

#      - Execute a summary() function on two variables defined in the 
#        previous step to compare the model results. What are the R2
#        and Adjusted R2 statistics? Explain what these results tell
#        you about the overall model. Did the inclusion of the
#        additional predictors help explain any large variations found
#        in Sale Price?
summary(sale_price_by_lot_square_ft)

#      - Considering the parameters of the multiple regression model
#        you have created. What are the standardized betas for each
#        parameter and what do the values indicate?


#      - Calculate the confidence intervals for the parameters in your 
#        model and explain what the results indicate.


#      - Assess the improvement of the new model compared to your
#        original model (simple regression model) by testing whether
#        this change is significant by performing an analysis of
#        variance.


#      - Perform casewise diagnostics to identify outliers and/or 
#        influential cases, storing each function's output in a
#        dataframe assigned to a unique variable name.


#      - Calculate the standardized residuals using the appropriate
#        command, specifying those that are +-2, storing the results 
#        of large residuals in a variable you create.


#      - Use the appropriate function to show the sum of large 
#        residuals.


#      - Which specific variables have large residuals (only cases 
#        that evaluate as TRUE)?


#      - Investigate further by calculating the leverage, cooks 
#        distance, and covariance rations. Comment on all cases that 
#        are problematics.


#      - Perform the necessary calculations to assess the assumption 
#        of independence and state if the condition is met or not.


#      - Perform the necessary calculations to assess the assumption 
#        of no multicollinearity and state if the condition is met or 
#        not.


#      - Visually check the assumptions related to the residuals using 
#        the plot() and hist() functions. Summarize what each graph is 
#        informing you of and if any anomalies are present.


#      - Overall, is this regression model unbiased? If an unbiased 
#        regression model, what does this tell us about the sample vs. 
#        the entire population model?


