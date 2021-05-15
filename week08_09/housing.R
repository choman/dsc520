# Assignment: Week 08/09 Housing
# Name: Homan, Chad
# Date: 2021-05-07
#
# Abstract 
#  - Work individually on this assignment. You are encouraged to collaborate on 
#    ideas and strategies pertinent to this assignment. Data for this assignment
#    is focused on real estate transactions recorded from 1964 to 2016 and can be
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
#      - Explain any transformations or modifications you made to the dataset
#      - Create two variables; one that will contain the variables Sale Price 
#        and Square Foot of Lot (same variables used from previous assignment on
#        simple regression) and one that will contain Sale Price and several 
#        additional predictors of your choice. Explain the basis for your 
#        additional predictor selections.
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
DEBUG            <- FALSE
REMOVALS         <- FALSE
HEAVY_PREDICTORS <- TRUE

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
mypackages <- append(mypackages, c("relaimpo")) #, "Boruta"))
#mypackages <- append(mypackages, c("car"))

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
workdir <- file.path(workdir, "week08_09")

## Set the working directory
setwd(workdir)

## Load the `housing` to data
filename <- "week-6-housing.xlsx"

sheet_names <- excel_sheets(filename)
house_df    <- readxl::read_xlsx(filename)
sheet_names

#house_df[rowSums(is.na(house_df)) > 0,]
house_df %>% head(4) %>% dim()
class(house_df)
str(house_df)
# Need to work on this
house_df %>% var() %>% cov() %>% cor()

################################################################
#
# Begin Answers here!!
#
################################################################

#      - Explain any transformations or modifications you made to the
#        dataset

# removals ----

if (REMOVALS) {
## Remove columns with NA
df1 <- as.data.frame(cbind(lapply(lapply(house_df, is.na), sum)))
remove_cols <- rownames(subset(df1, df1$V1 != 0))

## Remove the following, reasons on side
#remove_cols <- append(remove_cols, c("Sale Date", # don't need dates
#                                     "sale_reason", # mostly 1's
#                                     "sale_instrument", # mostly 3's
##                                     "sitetype", # all R1
#                                     "lon", # not needed
#                                     "lat", # not needed
#                                     "prop_type", # All R's
#                                     "addr_full", # not needed
#                                     "postalctyn", # All REDMOND
#                                     "present_use", # mostly 2's
#                                     "zip5", # only 3 zips
##                                     "current_zoning", # unknown codes
##                                     "year_renovated" # mostly 0's
#                        ))

remove_cols

house_df <- house_df[ , ! names(house_df) %in% remove_cols]

names(house_df)

dim(house_df)
#"building_grade", # ?????
#"current_zoning", # ????

                 
house_df <- house_df[ , ! names(house_df) %in% remove_cols]
          
}       
names(house_df)
house_df$building_grade

#     - Create two variables; one that will contain the variables 
#       Sale Price and Square Foot of Lot (same variables used from
#       previous assignment on simple regression) and one that will
#       contain Sale Price and several additional predictors of your
#       choice. Explain the basis for your additional predictor
#       selections.

# 2vars ----

sale_price_by_lot_square_ft <- data.frame(house_df$`Sale Price`,
                                          house_df$sq_ft_lot)

#lmMod <- lm(`Sale Price` ~ . , data = house_df)  # fit lm() model

## Based on my experience with REIA, these predictors are things that affect 
## Sale Price

if (HEAVY_PREDICTORS) {
  mylm <- lm(`Sale Price` ~ square_feet_total_living +
                            sq_ft_lot +
                            bedrooms +
                            building_grade +
                            bath_full_count +
                            bath_half_count + 
                            bath_3qtr_count + 
                            year_built,
                            data = house_df)
} else {
  mylm <- lm(`Sale Price` ~ square_feet_total_living +
                            bedrooms +
                            building_grade +
                            bath_full_count +
                            year_renovated +
                            year_built,
                            data = house_df)
}


summary(mylm)
head(house_df)
dimnames(house_df)

if (HEAVY_PREDICTORS) {
  sale_price_predictors <- data.frame(`Sale Price` = predict(mylm, house_df),
                                    building_grade = house_df$building_grade,
                                    bedrooms = house_df$bedrooms,
                                    sq_ft_lot = house_df$sq_ft_lot,
                                    square_feet_total_living = house_df$square_feet_total_living,
                                    bath_full_count = house_df$bath_full_count,
                                    bath_half_count = house_df$bath_half_count,
                                    bath_3qtr_count = house_df$bath_3qtr_count,
                                    year_renovated = house_df$year_renovated,
                                    year_built = house_df$year_built) 
} else {
  sale_price_predictors <- data.frame(`Sale Price` = predict(mylm, house_df),
                                    building_grade = house_df$building_grade,
                                    bedrooms = house_df$bedrooms,
                                    square_feet_total_living = house_df$square_feet_total_living,
                                    bath_full_count = house_df$bath_full_count,
                                    year_built = house_df$year_built) 

}

sale_price_by_lot_square_ft

#      - Execute a summary() function on two variables defined in the 
#        previous step to compare the model results. What are the R2
#        and Adjusted R2 statistics? Explain what these results tell
#        you about the overall model. Did the inclusion of the
#        additional predictors help explain any large variations found
#        in Sale Price?
summary(sale_price_by_lot_square_ft)
summary(sale_price_predictors)
head(sale_price_predictors)

mean_sale_price <- mean(house_df$`Sale Price`)
## Corrected Sum of Squares Total
sst <- sum((mean_sale_price - house_df$`Sale Price`)^2)
## Corrected Sum of Squares for Model
ssm <- sum((mean_sale_price - sale_price_predictors$Sale.Price)^2)
## Residuals
residuals <- house_df$`Sale Price` - sale_price_predictors$Sale.Price
## Sum of Squares for Error
residuals
residuals^2
sse <- sum(residuals^2)
## R Squared R^2 = SSM\SST
r_squared <- ssm / sst
r_squared

## Number of observations
n <- prod(dim(house_df))
## Number of regression parameters
p <- 8
## Corrected Degrees of Freedom for Model (p-1)
dfm <- p -1
## Degrees of Freedom for Error (n-p)
dfe <- n - p
## Corrected Degrees of Freedom Total:   DFT = n - 1
dft <- n - 1

## Mean of Squares for Model:   MSM = SSM / DFM
msm <- ssm / dfm
## Mean of Squares for Error:   MSE = SSE / DFE
mse <- sse / dfe
## Mean of Squares Total:   MST = SST / DFT
mst <- sst / dft
## F Statistic F = MSM/MSE
f_score <- msm/mse
f_score

## Adjusted R Squared R2 = 1 - (1 - R2)(n - 1) / (n - p)
1 - r_squared
n - 1
(1 - r_squared) * (n - 1)
n - p
adjusted_r_squared <- 1 - (1 - r_squared) * (n - 1) / (n - p)
r_squared
adjusted_r_squared

## According to https://analyticsindiamag.com/r-squared-vs-adjusted-r-squared, 
## adjusted r_squared has the capability to decrease with the addition of less 
## significant variables, thus resulting in a more reliable and accurate 
## evaluation. Since:

r_squared > adjusted_r_squared

## So I would interpret this to mean I have an accurate evaluation. 
## Currently, I cannot say if the inclusion of the additional predictors 
## help explain any large variations found in Sale Price?


#      - Considering the parameters of the multiple regression model
#        you have created. What are the standardized betas for each
#        parameter and what do the values indicate?

lm.beta(mylm)
summary(lm.beta(mylm))

## According to Discovering Statistics with R, these outputs tell us 
## the number of standard deviations by which the outcome will change
## as a result of one standard deviation change in the predictor.

#      - Calculate the confidence intervals for the parameters in your 
#        model and explain what the results indicate.

head(house_df)
head(predict(mylm, house_df, interval = "confidence"))
confint(mylm)

## Based on a 95% confidence level, a house with a sale price of $698000
## could really sell between $719247 and $736218 base on my predictors

#      - Assess the improvement of the new model compared to your
#        original model (simple regression model) by testing whether
#        this change is significant by performing an analysis of
#        variance.

predict(mylm, house_df)

#      - Perform casewise diagnostics to identify outliers and/or 
#        influential cases, storing each function's output in a
#        dataframe assigned to a unique variable name.

fitted(mylm)

## Outliers
my.resid <- resid(mylm)
my.rstandard <- rstandard(mylm)
my.rstudent <- rstudent(mylm)

## Influential Cases
my.cooks <- cooks.distance(mylm)
my.dfbeta <- dfbeta(mylm)
my.dffits <- dffits(mylm)
my.hatvalues <- hatvalues(mylm)
my.covratio <- covratio(mylm)
is.vector(my.resid)
typeof(c(my.resid))
id(my.resid)
is.vector(my.resid)

head(sale_price_predictors)
sale_price_predictors$residuals = resid(mylm)
sale_price_predictors$standardized.residuals = rstandard(mylm)
sale_price_predictors$studentized.residuals = rstudent(mylm)
sale_price_predictors$cooks.distance = cooks.distance(mylm)
sale_price_predictors$dfbeta = dfbeta(mylm)
sale_price_predictors$dffit = dffits(mylm)
sale_price_predictors$leverage = hatvalues(mylm)
sale_price_predictors$covariance.ratios = covratio(mylm)


head(sale_price_predictors)

#      - Calculate the standardized residuals using the appropriate
#        command, specifying those that are +-2, storing the results 
#        of large residuals in a variable you create.
sale_price_predictors$large.residuals <- sale_price_predictors$standardized.residuals > 2 |
                                         sale_price_predictors$standardized.residuals < -2

#      - Use the appropriate function to show the sum of large 
#        residuals.

sum (sale_price_predictors$large.residuals)


#      - Which specific variables have large residuals (only cases 
#        that evaluate as TRUE)?
sale_price_predictors[sale_price_predictors$large.residuals, 
                      c("Sale.Price",
                        "bedrooms",
                        "square_feet_total_living",
                        "bath_full_count",
                        "year_built")] 

## NEED INFO

#      - Investigate further by calculating the leverage, cooks 
#        distance, and covariance rations. Comment on all cases that 
#        are problematic.
sale_price_predictors[sale_price_predictors$large.residuals,
                      c("cooks.distance",
                        "leverage",
                        "covariance.ratios")]

## NEED INFO

#      - Perform the necessary calculations to assess the assumption 
#        of independence and state if the condition is met or not.
durbinWatsonTest(sale_price_predictors)

#      - Perform the necessary calculations to assess the assumption 
#        of no multicollinearity and state if the condition is met or 
#        not.

## Unable to compile a dependency of the car library, so no vif()

#      - Visually check the assumptions related to the residuals using 
#        the plot() and hist() functions. Summarize what each graph is 
#        informing you of and if any anomalies are present.

scaleFUN <- function(x) sprintf("%.0fk", x/10000)

ggplot(house_df, aes(`Sale Price`)) +
  geom_histogram(fill = "blue", bins=20) +
  scale_x_continuous(name = "Sale Price ($K)",
                   labels = scaleFUN)


## With the histogram I see outliers in the Sale Price

myplot <- ggplot(house_df, aes(x=square_feet_total_living, 
                              y=`Sale Price`)) +
          geom_point(color='blue') +
          scale_y_continuous(name = "Sale Price ($K)",
                             labels = scaleFUN)

myplot

## with the point plot I see clustering of sale prices for houses
## under 5000 sq ft just under 150K

myplot +  
  geom_line(color='red', data = sale_price_predictors, 
            aes(x=square_feet_total_living, y=`Sale.Price`))

## with the predictions plotted, I see how the cluster is swarm against 
## those prices



#      - Overall, is this regression model unbiased? If an unbiased 
#        regression model, what does this tell us about the sample vs. 
#        the entire population model?

## I believe this regression model is unbiased. NEED MORE

