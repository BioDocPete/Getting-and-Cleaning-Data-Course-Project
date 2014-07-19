==================================================================
GETTING AND READING DATA – COURSE PROJECT 
This project uses the dataset: “Human Activity Recognition Using Smartphones Dataset, Version 1.0”
“The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually.” From http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
The "newtidy_df" is a data.frame containing the means of variables of calculated means and standard deviations broken out by “activity” (character variable of 6 types) and “subject” (integer variable of 30 individuals who participated in this analysis of smart phone movements when attached to the waist of the subjects). The dimensions of newtidy_df are 180 rows by 68 columns. The 68 variables consist of 66 numeric variables with descriptive names that are the means (calculated by the R code) of the means and standard deviations of the movement parameters. For each parameter, there were 6 different activities performed by each of the 30 subjects for data collection. Each of the 30 subjects performed each of the 6 activities during which 33 parameters were measured over very short time intervals. This code takes the means and standard deviations of these data. 
6 * 30 * 33 * 2 = 11880 means

This README file explains how all of the scripts work and how they are connected.
==================================================================
==================================================================
1.	The code is annotated in detail so the information below is a summary. 
2.	Read-in the data files using read.table. 
3.	Used the ‘dim’ function to determine the dimensions of the data to see how they fit together. 
4.	Added the same column names to the separate train and test data sets. This is fine because the train and test files are identical because they were derived from the same dataset that was split to make two separate data files (train and test sets). The ‘setnames’ function failed to switch-in the descriptive names and switch-out the numbers because a set of 42 descriptive column names were repeated three times. Therefore column number was pasted onto the descriptive names to make them all unique. This was not a problem because none of the repeated columns were either mean of std measurements—so they are not included in the final tidy data frame.
5.	Appended the the ‘subject’ and ‘activity’ columns onto the data x_train and x_test data tables.
6.	Merged the two data tables into one using rbind. Wrapping it with unique showed that all rows were unique as the number of merged rows was the sum of the rows of the two separate data tables.
7.	Sub-setted the merged data table using ‘grep’ to get all columns with ‘mean’ or ‘std’ in the descriptive column name. Used ‘!grep’ to exclude columns with the string ‘mean’ that were not evidently the calculated means like the others.
8.	Replaced the integers in the ‘activity’ column with their corresponding descriptive names.
9.	Checked to make sure values were not missing.
10.	Created the new tidy data frame of means calculated by ‘activity’ and ‘subject’ using the ddply of the plyr package and numcolwise(mean). 
