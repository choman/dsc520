# Assignment: ASSIGNMENT 6
# Name: Homan, Chad
# Date: 2021-05-03

## Set the working directory to the root of your DSC 520 directory
basedir <- system("git rev-parse --show-toplevel", intern=TRUE)
setwd(basedir)

## Load the `data/r4ds/heights.csv` to
heights_df <- read.csv("data/r4ds/heights.csv")

## Load the ggplot2 library
library(ggplot2)
library(pastecs)

heights_df
## Fit a linear model using the `age` variable as the predictor and `earn` as 
#the outcome
age_lm <- lm(age ~ earn, data=heights_df)

age_lm

## View the summary of your model using `summary()`
summary(age_lm)
head(heights_df)

## Creating predictions using `predict()`
if (0) {
age_predict_df <- data.frame(earn = predict(age_lm, heights_df, interval="prediction"), age=heights_df$age)
} else {
age_predict_df <- data.frame(earn = predict(age_lm, heights_df), age=heights_df$age)
}

head(age_predict_df)
#age_predict_df$earn = round(age_predict_df$earn * 1000)
#head(age_predict_df)

## Plot the predictions against the original data
ggplot(data = heights_df, aes(y=earn, x=age)) +
  geom_point(color='blue')

ggplot(data = heights_df, aes(y=earn, x=age)) +
  geom_point(color='blue') + geom_smooth(method="lm",se=F, col='red', formual=age ~ earn)

ggplot(data = heights_df, aes(y = earn, x = age)) +
  geom_point(color='blue') +
  geom_line(data = age_predict_df, aes(y=earn))

ggplot(data = heights_df, aes(y = earn, x = age)) +
  geom_point(color='blue') +
  geom_line(color='red', data = age_predict_df, aes(y=age_lm, x=age))

mean_earn <- mean(heights_df$earn)
## Corrected Sum of Squares Total
sst <- sum((mean_earn - heights_df$earn)^2)
## Corrected Sum of Squares for Model
ssm <- sum((mean_earn - age_predict_df$earn)^2)
## Residuals
residuals <- heights_df$earn - age_predict_df$earn
## Sum of Squares for Error
sse <- sum(residuals^2)
## R Squared R^2 = SSM\SST
r_squared <- ssm / sst
r_squared

nrow(heights_df)
length(heights_df)
length(as.matrix(heights_df))
prod(dim(heights_df))
dim(heights_df)
stat.desc(heights_df)
## Number of observations
n <- prod(dim(heights_df))
## Number of regression parameters
p <- 2
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
adjusted_r_squared <- 1 = (1 - r_squared)(n - 1) / (n - p)

## Calculate the p-value from the F distribution
p_value <- pf(f_score, dfm, dft, lower.tail=F)
p_value
