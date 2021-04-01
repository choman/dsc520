# Assignment: ASSIGNMENT 3B
# Name: Homan, Chad
# Date: 2021-03-30

# For this exercise, you will use the following dataset, 2014 American
# Community Survey. This data is maintained by the US Census Bureau and are
# designed to show how communities are changing. Through asking questions
# of a sample of the population, it produces national data on more than
# 35 categories of information, such as education, income, housing, and
# employment. For this assignment, you will need to load and activate the
# ggplot2 package. For this deliverable, you should provide the following:
#
# -  What are the elements in your data (including the categories and
#    data types)?
# -  Please provide the output from the following functions: str();
#    nrow(); ncol()
# -  Create a Histogram of the HSDegree variable using the ggplot2
#    package.
#     -  Set a bin size for the Histogram.
#     -  Include a Title and appropriate X/Y axis labels on your
#        Histogram Plot.
# -  Answer the following questions based on the Histogram produced:
#     -  Based on what you see in this histogram, is the data distribution
#        unimodal?
#     -  Is it approximately symmetrical?
#     -  Is it approximately bell-shaped?
#     -  Is it approximately normal?
#     -  If not normal, is the distribution skewed? If so, in which
#        direction?
#     -  Include a normal curve to the Histogram that you plotted.
#     -  Explain whether a normal distribution can accurately be used
#        as a model for this data.
# -  Create a Probability Plot of the HSDegree variable.
# -  Answer the following questions based on the Probability Plot:
#     -  Based on what you see in this probability plot, is the
#        distribution approximately normal? Explain how you know.
#     -  If not normal, is the distribution skewed? If so, in which
#        direction? Explain how you know.
# -  Now that you have looked at this data visually for normality,
#    you will now quantify normality with numbers using the stat.desc()
#    function. Include a screen capture of the results produced.
# -  In several sentences provide an explanation of the result produced
#    for skew, kurtosis, and z-scores. In addition, explain how a change in
#    the sample size may change your explanation?

## Load the ggplot2 package
install.packages("ggplot2")
install.packages("pastecs")
library(ggplot2)
library(pastecs)
## library(qqplotr)
theme_set(theme_minimal())
binwidth <- .5

## Set the working directory to the root of your DSC 520 directory
## to include the week of the assignment
workdir <- system("git rev-parse --show-toplevel", intern=TRUE) 
workdir <- file.path(workdir, "week03")

## Set the working directory
setwd(workdir)

## Load the `data/r4ds/heights.csv` to
data_df <- read.csv("acs-14-1yr-s0201.csv", stringsAsFactors=TRUE)
data_df

# -  What are the elements in your data (including the categories and
#    data types)?
summary(data_df)

# -  Please provide the output from the following functions: str();
#    nrow(); ncol()
str(data_df)
nrow(data_df)
ncol(data_df)

# -  Create a Histogram of the HSDegree variable using the ggplot2
#    package.
hsdegree <- ggplot(data_df, aes(x=HSDegree))
hsdegree + geom_histogram()

#     -  Set a bin size for the Histogram.
hsdegree + geom_histogram(binwidth=binwidth)


#     -  Include a Title and appropriate X/Y axis labels on your
#        Histogram Plot.
labels <- labs(title="High School Degrees: Percentage vs Count",
             x="HS Degrees (percentage)",
             y="HS Degrees (count)")
histogram <- hsdegree + geom_histogram(binwidth=binwidth) + labels
histogram

# -  Answer the following questions based on the Histogram produced:
#     -  Based on what you see in this histogram, is the data distribution
#        unimodal?
#     *  Answer: Based on my results, this histogram is definitely unimodal.
#
#     -  Is it approximately symmetrical? 
#     *  Answer: No, technically this is a left-skewed or negatively-skewed
#        histogram 
#
#     -  Is it approximately bell-shaped? 
#     *  Answer: No
#
#     -  Is it approximately normal?
#     *  Answer: No
#
#     -  If not normal, is the distribution skewed? If so, in which
#        direction?
#     *  Answer: This is a left-skewed or negatively-skewed distribution 
#
#     -  Include a normal curve to the Histogram that you plotted.



#
#     -  Explain whether a normal distribution can accurately be used
#        as a model for this data.
#     *  Answer:

# -  Create a Probability Plot of the HSDegree variable.
#    http://www.sthda.com/english/wiki/ggplot2-qq-plot-quantile-quantile-graph-quick-start-guide-r-software-and-data-visualization
ggplot(data_df, aes(sample=HSDegree)) + stat_qq()
ggplot(data_df, aes(sample=HSDegree)) + geom_qq() + geom_abline(intercept=80, slope=7)


# -  Answer the following questions based on the Probability Plot:
#     -  Based on what you see in this probability plot, is the
#        distribution approximately normal? Explain how you know.
#     *  Answer: Assuming that I understand what I have read, this is
#        not a normal probability plot as it has a curve
#
#     -  If not normal, is the distribution skewed? If so, in which
#        direction? Explain how you know.
#     *  Answer: Yes it is skewed, according to what I have read, since 
#        I have a C shape, as opposed to a inverse-C shape. My plot is 
#        a left-skewed or negative-skewed probability curve. 

# -  Now that you have looked at this data visually for normality,
#    you will now quantify normality with numbers using the stat.desc()
#    function. Include a screen capture of the results produced.
attach(data_df)
summary(data_df)
info <- cbind(Id, Id2, Geography, RacesReported, HSDegree, BachDegree)
options(scipen=100)
options(digits=2)
stat.desc(info)
stat.desc(info, basic=FALSE, norm=TRUE)

# -  In several sentences provide an explanation of the result produced
#    for skew, kurtosis, and z-scores. In addition, explain how a change in
#    the sample size may change your explanation?

## Answers:
## - Skewness measures the symmetry of the distribution. According to 
##   https://www.statology.org/skewness-kurtosis-in-r/ this value can be 
##   negative, positive, or zero (no skewness). 
##   One definition say that this disturbution is left skewed (or negatively 
##   skewed) if the mean is less than the median. According to stat.desc, the 
#m   mean is 87.632 and the median is 88.700. Which fits based on the mean <
##   median. Also note that the second stat.desc shows a skewness of -1.6747666915
##   which fits the mentioned web site that:
##       - A negative skew indicates the tail is on the left, extending towards
##         negative values
##       - A positive skew indicates the tail is on the right, extending towards
##         positive values
##       - a zoer inidcates that there is no skewness meaning perfectly symmetrical
##   So a -1.67 also fits are my results being left skewed 
##   This is also confirmed in the below moments package 
mean(data_df$HSDegree)
median(data_df$HSDegree)
mean(data_df$HSDegree) < median(data_df$HSDegree)
## also skewness is (mean - median)/std.dev
3 * (87.632 - 88.70) / 5.118 # for ome reason this does not map correctly to stat.desc


## - According to https://www.statology.org/skewness-kurtosis-in-r/, kurtosis is
##   the measure of whether or not a distribution is heavy-tailed or light-tailed 
##   relative to a normal distribution. This is defined as:
##       - The kurtosis of a nomral distribution is 3
##       - If a distribution has a kurtosis less than 3, it is said to be playkurtic
##         which means it tends to produce fewer and less extreme outliers than a 
##         normal distribution
##       - If a distribution has a kurtosis greater than 3, it is said to be leptokurtic
##         which means it tends to produce more outliers than a normal distribution
##   Since the stat.desc shows a kurtossis of 4.352856, this data is leptokurtic.
##   Excess Kurtosis is therefore 4.352856 - 3 == 1.352856
##   This is also confirmed in the below moments package, which shows a higher kurtosis
##   than stat.desc.
install.packages("moments")
library(moments)
skewness(data_df$HSDegree)
kurtosis(data_df$HSDegree)

## - Z-scores measure 
zscore <- (62.2 - 87.636)/5.188
zscore
