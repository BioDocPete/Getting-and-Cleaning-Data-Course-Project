# COURSE PROJECT FOR GETTING AND CLEANING DATA
########################################################
#install.packages("data.table")
library(data.table)
#install.packages("plyr")
library(plyr)

# Read-in and look at dimensions of files to see how they can snap together like leggos
f = read.table("features.txt", sep=" ") # these are column labels 
        dim(f)          #[1] 561   2    # head(f)
s_test = read.table("subject_test.txt", sep="\t") # ROW LABELS - NUMERICAL SUBJECT IDENTIFIERS
        dim(s_test)     #[1] 2947    1  # head(s_test) class(s_test$V1)
y_test <- read.table("y_test.txt", sep="\t") # ROW LABELS ACTIVITY
        dim(y_test)     #[1] 2947    1  # head(y_test) tail(y_test) class(s_test$V1)
X_test <- as.data.table(read.table("X_test.txt", sep=""))
        dim(X_test)     #[1] 2947  561    1  # head(X_test) class(X_test)

s_train = read.table("subject_train.txt", sep="\t")     # head(s_train) tail(s_train)
        dim(s_train)    #[1] 7352    1
y_train <- read.table("y_train.txt", sep="\t")          # head(y_train) dim(y_train)
        dim(y_train)    #[1] 7352    1
X_train <- as.data.table(read.table("X_train.txt", sep=""))
        dim(X_train)    #[1] 7352    1  # str(X_train) # head(X_train[1,1]) class(X_train)

# add colnames to X_test 
columnName <- paste(f$V1,f$V2, sep="-") # pastes together strings of columns 1 and 2 to make column names
# unique. This was only necessary because the 42 "fBodyAcc-bandsEnergy" variables were
# repeated 3 times. But none of these variables are 'mean' or 'std', so they are not in the final data frame.
old<-colnames(X_test)                   # assign existing column names to a vector
setnames(X_test, old, columnName)       # changes the column names without duplicating the data.table
# add colnames to X_test
old2<-colnames(X_train)                 # assign existing column names to a vector
setnames(X_train, old2, columnName)     # changes the column names without duplicating the data.table

# Add subject and activity columns to both data.tables
X_test[,subject:= s_test]
X_test[,activity:= y_test]
X_train[,subject:= s_train]
X_train[,activity:= y_train]

#########################################################
# 1. Merges the training and test data.tables into one data.table.
mergedDT <- unique(rbind(X_train, X_test)) # dim(mergedDT); class(mergedDT); tail(mergedDT)

#########################################################
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
mergedDT <- as.data.frame(mergedDT) # make the data.table a data.frame so can subset by colnames
# gets cols w/ mean or std or subject or activity
logicalMeanStd <- grepl("mean", f[,2]) & !grepl("meanFr", f[,2]) | 
                grepl("std", f[,2]) | grepl("subject", f[,2]) | grepl("activity", f[,2]) 
df<-mergedDT[,logicalMeanStd] # subsets columns containing mean and std 

#########################################################
# 3. Uses descriptive activity names to name the activities in the data set. 
# Switches out numbers for names according to activity_labels file: 1 WALKING; 2
# WALKING_UPSTAIRS; 3 WALKING_DOWNSTAIRS; 4 SITTING; 5 STANDING; 6 LAYING

df$activity <- as.character(df$activity)
df$activity[df$activity == "1"] <- "WALKING"
df$activity[df$activity == "2"] <- "WALKING_UPSTAIRS"
df$activity[df$activity == "3"] <- "WALKING_DOWNSTAIRS"
df$activity[df$activity == "4"] <- "SITTING"
df$activity[df$activity == "5"] <- "STANDING"
df$activity[df$activity == "6"] <- "LAYING"

######################################################### 
# 4. Appropriately labels the data set with descriptive variable names. 
# As annotated above, the column names are descriptive as they were added using the function
# 'setnames' from the file 'features.txt'.

######################################################### 
#5. Creates a second, independent tidy data set with the average of each
#variable for each activity and each subject.
 
all(colSums(is.na(df))==0) # checks for missing values and found none -- [1] TRUE

# makes new tidy data.frame with the mean of each variable by activity and subject.
newtidy_df<-ddply(df, .(activity,subject), numcolwise(mean))

# write.table(newtidy_df, file = "newtidy_df.txt", sep="," , col.names=NA)

