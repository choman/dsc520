# Assignment: ASSIGNMENT 3B
# Name: Homan, Chad
# Date: 2021-04-04

# NOTE: Answers to questions are in comments in the code
#
# A professor has recently taught two sections of the same course with
# only one difference between the sections. In one section, he used only 
# examples taken from sports applications, and in the other section, he
# used examples taken from a variety of application areas. The sports
# themed section was advertised as such; so students knew which type of
# section they were enrolling in. The professor has asked you to compare
# student performance in the two sections using course grades and total
# points earned in the course. You will need to import the Scores.csv
# dataset that has been provided for you.
#
# NOTE: Answers to questions are in comments in the code

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
mypackages <- c("ggplot2", "pastecs", "data.table")
not_installed <- mypackages[!(mypackages %in% installed.packages()[, "Package"])]
if(length(not_installed)) install.packages(not_installed)

# Load libraries
for (package in mypackages) {
  library(package, character.only=TRUE)
}

##install.packages("ggplot2")
##install.packages("pastecs")
##install.packages("data.table")
##library(ggplot2)
##library(pastecs)
##library(data.table)
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
df <- read.csv("scores.csv", stringsAsFactors=TRUE)
df

# Create a data table
dt = data.table(df)
dt


#  - What are the observational units in this study?
#    Answer: score and count based on either Sports or Regular
#            Output of data_frame (df)
summary(df)
str(df)
nrow(df)
ncol(df)

#  - What are the observational units in this study?
#    Answer: score and count based on either Sports or Regular
#            Output of data.table (dt)
summary(dt)
str(dt)
nrow(dt)
ncol(dt)

#  - Create one variable to hold a subset of your data set that contains
#    only the Regular Section and one variable for the Sports Section.
sports  <- dt[dt$Section == "Sports"]
regular <- dt[dt$Section == "Regular"]

sports
regular

mean(sports$Score)
mean(regular$Score)

mean(sports$Score, trim=0.3)
mean(regular$Score, trim=0.3)

median(sports$Score)
median(regular$Score)

min(sports$Score)
min(regular$Score)

max(sports$Score)
max(regular$Score)

# https://www.geeksforgeeks.org/central-tendency-in-r-programming/
# defines mode values repeated the most
get.mode <- function(data)
{
  y <- table(data)
  print(y)
  m <- names(y)[which(y==max(y))]
  print(m)
}

# https://analytics4all.org/2016/04/16/r-intro-to-statistics-central-tendency/
# define value as most common in list
get.mode2 <- function(data)
{
  y <- unique(data)
  print(y)
  y[which.max(tabulate(match(data,y)))]
  
}

get.mode(sports$Score)
get.mode(regular$Score)

get.mode2(sports$Score)
get.mode2(regular$Score)

stat.desc(sports$Score)
stat.desc(regular$Score)

# Set labels
labels <- labs(title="Score vs Count",
             x="Score", 
             y="Count of people receiving score")

legend <- scale_color_manual(name="Sections",
                             values=c(Sports="black", Regular="red"))

# Create a point plot (scatterplot?) of the Sport and Regular 
# scores and counts
gg <- ggplot()
gg <- gg + geom_point(data=sports, aes(x=Score, y=Count, col="Sports"))
gg <- gg + geom_point(data=regular, aes(x=Score, y=Count, col="Regular"))
gg + labels + legend

#      - Comparing and contrasting the point distributions between the two
#        section, looking at both tendency and consistency: Can you say
#        that one section tended to score more points than the other?
#        Justify and explain your answer.
#
#        Answer: Based on what I see when I analyze the data, the regular
#        section appears to do better than the sports section. Even though 
#        10 of the students in the sports section were able to score the 
#        highest between the sections. The mean and the median show higher
#        scores for central tendency in the regular section.
#
#           Sports vs Regular mean:   307.4 < 327.6
#           Sports vs Regular mean:   316.1 < 326.1 (trimmed)
#           Sports vs Regular median: 315 < 325
#           Sports vs Regular min:    200 < 265
#           Sports vs Regular max:    395 > 380
#        
#        In regards to mode, mode function#1 shows every value as a mode
#        for the sports section, whereas the regular section had repeated 
#        values of 305 and 320
#
#        However mode function#2 show the sports section having a mode of
#        200 and the regular section having a mode of 305.
#
#
#      - Did every student in one section score more points than every
#        student in the other section? If not, explain what a statistical
#        tendency means in this context.
#
#        Answer: To begin let's define what a central tendency is. According
#        to wikipedia[1] a central tendency is center of a probability
#        distirbution. Based on this, I would say no to the question of every
#        student in one section score more point then ecery student in the
#        other section. Although in total points scored the regular section
#        did obtain more points
#         
#        [1] https://en.wikipedia.org/wiki/Central_tendency
#
#
#      - What could be one additional variable that was not mentioned in
#        the narrative that could be influencing the point distributions
#        between the two sections?
#
#        Answer: First of all, the classes are not "balanced", there are 30 
#        more student in the regular class that could have influenced the 
#        higher performance. An additional variable however may be time. 
#        When were the classes taught? Arguably there is no best time to learn,
#        however according to some sites like babel[1], 10am-2pm and 4pm-10pm
#        are the best times. Others like learnerfix[2] say 8am-2pm and 4pm-10pm.
#        Others reference similar times. But in this context if the sports section
#        was taught around noon that could point to poor performance.
#
#        Also, one might speculate on the 'variety' of the regular section. Perhaps
#        this was more entertaining information than the sports section.
#
#        [1] https://www.babbel.com/en/magazine/best-time-of-day-to-learn
#        [2] https://learnerfix.com/best-time-of-day-to-learn/
#