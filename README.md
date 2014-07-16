GETTING AND READING DATA – COURSE PROJECT 

This project uses the dataset: “Human Activity Recognition Using Smartphones Dataset, Version 1.0”

This README file explains how all of the scripts work and how they are connected.
Annotated the code.

Summarize the separate chunks in this README.md.
Read-in the data files using read.table.
Used the dim function to determine the dimensions of the data to see how they fit together.
Added the same column names to the separate train and test data sets. This is fine because the train and test files are identical because they were derived from the same dataset that was split to make two separate data files (train and test sets). The ‘setnames’ function failed to switch-in the descriptive names and switch-out the numbers because a set of 42 descriptive column names were repeated three times. Therefore column number was pasted onto the descriptive names to make them all unique. This was not a problem because none of the repeated columns were either mean of std measurements—so they are not included in the final tidy data frame.
Appended the the ‘subject’ and ‘activity’ columns onto the data x_train and x_test data tables.
Merged the two data tables into one using rbind. Wrapping it with unique showed that all rows were unique as the number of merged rows was the sum of the rows of the two separate data tables.
Sub-setted the merged data table using ‘grep’ to get all columns with ‘mean’ or ‘std’ in the descriptive column name. Used ‘!grep’ to exclude columns with the string ‘mean’ that were not evidently the calculated means like the others.
Replaced the integers in the ‘activity’ column with their corresponding descriptive names.
Checked to make sure values were not missing.
Created the new tidy data frame of means calculated by ‘activity’ and ‘subject’ using the ddply of the plyr package and numcolwise(mean).
It took half a day to work out github.
