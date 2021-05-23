# Week 11 and 12

# Abstract

This folder is for the assignments related to weeks 11 and 12

## Assignments

1. Introduction to Machine Learning

- These assignments are here to provide you with an introduction to the “Data Science”
  use for these tools. This is your future. It may seem confusing and weird right now
  but it hopefully seems far less so than earlier in the semester. Attempt these homework
  assignments. You will not be graded on your answer but on your approach. This should be
  a, “Where am I on learning this stuff” check. If you can’t get it done, please explain
  why.

- Include all of your answers in a R Markdown report. 

- Regression algorithms are used to predict numeric quantity while classification
  algorithms predict categorical outcomes. A spam filter is an example use case for 
  classification algorithm. The input dataset is emails labeled as either spam (i.e.
  junk emails) or ham (i.e. good emails). The classification algorithm uses features
  extracted from the emails to learn which emails fall into which category.

- In this problem, you will use the nearest neighbors algorithm to fit a model on two
  simplified datasets. The first dataset (found in binary-classifier-data.csv) contains
  three variables; label, x, and y. The label variable is either 0 or 1 and is the output
  we want to predict using the x and y variables (You worked with this dataset last week!).
  The second dataset (found in trinary-classifier-data.csv) is similar to the first dataset
  except that the label variable can be 0, 1, or 2.

- Note that in real-world datasets, your labels are usually not numbers, but text-based
  descriptions of the categories (e.g. spam or ham). In practice, you will encode
  categorical variables into numeric values.
  - Plot the data from each dataset using a scatter plot.
  - The k nearest neighbors algorithm categorizes an input value by looking at the labels
    for the k nearest points and assigning a category based on the most common label. In
    this problem, you will determine which points are nearest by calculating the Euclidean
    distance between two points. As a refresher, the Euclidean distance between two points:
-
p1=(x1, y1) 
and
p2=(x2,y2) 
is
d=

  - Fitting a model is when you use the input data to create a predictive model. There are
    various metrics you can use to determine how well your model fits the data. For this
    problem, you will focus on a single metric, accuracy. Accuracy is simply the percentage
    of how often the model predicts the correct result. If the model always predicts the
    correct result, it is 100% accurate. If the model always predicts the incorrect result,
    it is 0% accurate.

  - Fit a k nearest neighbors’ model for each dataset for k=3, k=5, k=10, k=15, k=20, and
    k=25. Compute the accuracy of the resulting models for each value of k. Plot the results
    in a graph where the x-axis is the different values of k and the y-axis is the accuracy
    of the model.

decision boundary

  - Looking back at the plots of the data, do you think a linear classifier would work well
    on these datasets?

  - How does the accuracy of your logistic regression classifier from last week compare?  Why
    is the accuracy different between these two methods?
2. Clustering

- These assignments are here to provide you with an introduction to the “Data Science” use for
  these tools. This is your future. It may seem confusing and weird right now but it hopefully
  seems far less so than earlier in the semester. Attempt these homework assignments. You will
  not be graded on your answer but on your approach. This should be a, “Where am I on learning
  this stuff” check. If you can’t get it done, please explain why.

- Remember to submit this assignment in an R Markdown report.

- Labeled data is not always available. For these types of datasets, you can use unsupervised
  algorithms to extract structure. The k-means clustering algorithm and the k nearest neighbor
  algorithm both use the Euclidean distance between points to group data points. The difference
  is the k-means clustering algorithm does not use labeled data.

- In this problem, you will use the k-means clustering algorithm to look for patterns in an
  unlabeled dataset. The dataset for this problem is found at data/clustering-data.csv.
    - Plot the dataset using a scatter plot.
    - Fit the dataset using the k-means algorithm from k=2 to k=12. Create a scatter plot of
      the resultant clusters for each value of k.
    - As k-means is an unsupervised algorithm, you cannot compute the accuracy as there are no
      correct values to compare the output to. Instead, you will use the average distance from
      the center of each cluster as a measure of how well the model fits the data. To calculate
      this metric, simply compute the distance of each data point to the center of the cluster
      it is assigned to and take the average value of all of those distances.

  - Calculate this average distance from the center of each cluster for each value of k and plot
    it as a line chart where k is the x-axis and the average distance is the y-axis.
  - One way of determining the “right” number of clusters is to look at the graph of k versus
    average distance and finding the “elbow point”. Looking at the graph you generated in the
    previous example, what is the elbow point for this dataset?