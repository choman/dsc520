# Assignment: ASSIGNMENT 3B
# Name: Homan, Chad
# Date: 2021-04-04

# A professor has recently taught two sections of the same course with
# only one difference between the sections. In one section, he used only 
# examples taken from sports applications, and in the other section, he
# used examples taken from a variety of application areas. The sports
# themed section was advertised as such; so students knew which type of
# section they were enrolling in. The professor has asked you to compare
# student performance in the two sections using course grades and total
# points earned in the course. You will need to import the Scores.csv
# dataset that has been provided for you.

# Use the appropriate R functions to answer the following questions:
#  - What are the observational units in this study?
#  - Identify the variables mentioned in the narrative paragraph and
#    determine which are categorical and quantitative?
#  - Create one variable to hold a subset of your data set that contains
#    only the Regular Section and one variable for the Sports Section.
#  - Use the Plot function to plot each Sections scores and the number of
#    students achieving that score. Use additional Plot Arguments to label
#    the graph and give each axis an appropriate label. Once you have
#    produced your Plots answer the following questions:
#      - Comparing and contrasting the point distributions between the two
#        section, looking at both tendency and consistency: Can you say
#        that one section tended to score more points than the other?
#        Justify and explain your answer.
#      - Did every student in one section score more points than every
#        student in the other section? If not, explain what a statistical
#        tendency means in this context.
#      - What could be one additional variable that was not mentioned in
#        the narrative that could be influencing the point distributions
#        between the two sections?

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
workdir <- file.path(workdir, "week04")

## Set the working directory
setwd(workdir)

## Load the `data/r4ds/heights.csv` to
data_frame <- read.csv("scores.csv", stringsAsFactors=TRUE)
data_frame

# -  What are the elements in your data (including the categories and
#    data types)?
summary(data_frame)

# -  Please provide the output from the following functions: str();
#    nrow(); ncol()
str(data_frame)
nrow(data_frame)
ncol(data_frame)

# -  Create a Histogram of the HSDegree variable using the ggplot2
#    package.
hsdegree <- ggplot(data_df, aes(x=HSDegree))
hsdegree + geom_histogram(aes(y = ..density..), fill="Navy", color="black", alpha=.7)

#     -  Set a bin size for the Histogram.
histogram <- geom_histogram(aes(y = ..density..), binwidth=binwidth, fill="Navy", color="black", alpha=.7)
hsdegree + histogram


#     -  Include a Title and appropriate X/Y axis labels on your
#        Histogram Plot.
labels <- labs(title="High School Degrees: Percentage vs Count",
             x="Population Percentage With HS Degrees", 
             y="HS Degrees (count)")
myhistogram <- hsdegree + histogram + labels
myhistogram

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
    
myhistogram +
    stat_function(fun=dnorm, args=list(mean=mean(data_df$HSDegree), sd=sd(data_df$HSDegree)), color="red")

#
#     -  Explain whether a normal distribution can accurately be used
#        as a model for this data.
#     *  Answer: I believe a normal distribution can be used as a model
#        for this data as it help to show how skewed the data is

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
#     *  Answer: Yes it is skewed, according to what I have read. Since 
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
stat.desc(data_df$HSDegree)
stat.desc(data_df$HSDegree, basic=FALSE, norm=TRUE)

# -  In several sentences provide an explanation of the result produced
#    for skew, kurtosis, and z-scores. In addition, explain how a change in
#    the sample size may change your explanation?

## Answers:
## - Skewness measures the symmetry of the distribution. According to 
##   https://www.statology.org/skewness-kurtosis-in-r/ this value can be 
##   negative, positive, or zero (no skewness). 
##   One definition say that this distribution is left skewed (or negatively 
##   skewed) if the mean is less than the median. According to stat.desc, the 
#m   mean is 87.632 and the median is 88.700. Which fits based on the mean <
##   median. Also note that the second stat.desc shows a skewness of -1.6747666915
##   which fits the mentioned web site that:
##       - A negative skew indicates the tail is on the left, extending towards
##         negative values
##       - A positive skew indicates the tail is on the right, extending towards
##         positive values
##       - a zero indicates that there is no skewness meaning perfectly symmetrical
##   So a -1.67 also fits are my results being left skewed 
##   This is also confirmed in the below moments package 
mean(data_df$HSDegree)
median(data_df$HSDegree)
mean(data_df$HSDegree) < median(data_df$HSDegree)
## also skewness is (mean - median)/std.dev
##3 * (87.632 - 88.70) / 5.118 # for some reason this does not map correctly to stat.desc


## - According to https://www.statology.org/skewness-kurtosis-in-r/, kurtosis is
##   the measure of whether or not a distribution is heavy-tailed or light-tailed 
##   relative to a normal distribution. This is defined as:
##       - The kurtosis of a normal distribution is 3
##       - If a distribution has a kurtosis less than 3, it is said to be playkurtic
##         which means it tends to produce fewer and less extreme outliers than a 
##         normal distribution
##       - If a distribution has a kurtosis greater than 3, it is said to be leptokurtic
##         which means it tends to produce more outliers than a normal distribution
##   Since the stat.desc shows a kurtosis of 4.352856, this data is leptokurtic.
##   Excess Kurtosis is therefore 4.352856 - 3 == 1.352856
##   This is also confirmed in the below moments package, which shows a higher kurtosis
##   than stat.desc.
install.packages("moments")
library(moments)
skewness(data_df$HSDegree)
kurtosis(data_df$HSDegree)

## - Z-scores for data_df$HSdegree according to https://www.statology.org/z-score-r/
##   is calculated by a formula similar to:
##
##      (data_df$HSDegree-mean(data_df$HSDegree) / sd(data_df$HSDegree))
##
##   However, the result do not line up correctly. But executing just the initial 
##   part of this equation appears to give me what I am looking for. Since the first
##   value of HSdegree is 89 and the mean is 87.632 is approximately 1.4, which the 
##   output of the following zscores maps to:
data_df
data_df$HSDegree-mean(data_df$HSDegree) 

##89 - 87.632
##sd(data_df$HSDegree)
##zscores <- (data_df$HSDegree-mean(data_df$HSDegree) / sd(data_df$HSDegree))
##zscores

# -  explain how a change in the sample size may change your explanation?
## Since the sample size is approximately 136 counties in the U.S. Getting a 
## sample size that covers many more counties may change the mean and the median 
## enough to skew the results to a more normal distribution. I believe additional 
## questions  need to be answered with this data such as:
##     - Ruralness of the counties
##     - History or events of the population that had circumstances that prevented
##       one from obtaining a HS Degree or Bachelor Degree
