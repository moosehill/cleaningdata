	Final Project Dataset Code Book

This dataset is based on the UCI HAR Dataset available here: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

A full description of the UCI project is available here: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

All documentation in the original project description is still relevant unless otherwise stated below.

The present dataset is a subset of the UCI dataset. The following changes have been made:

    - The training and test data have been merged together
    - All Inertial data has been dropped from the dataset
    - Of the 561 features in the original dataset, only the 66 that related to the mean and standard deviation have been retained. Specifically,
      only features with the strings "std()" or "mean()" have been kept.
    - Rather than using numeric codes to represent the six activity values, this dataset uses the text descriptions defined in the UCI study
    - Each row in the dataset contains the mean feature values for each Subject and Activity type. That is, there is one row in the dataset
      for each combination of Subject and Activity.
    - The column names are the names used in the UCI study ( so the documentation will still be relevant) with "Average_" prepended to
      indicate that those values have been averaged across multiple rows from the original dataset.

