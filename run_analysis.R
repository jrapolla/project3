
#Download raw data and set directory sctrucrture to store raw/result files 

init <- function(directory = "~/project3/") {
    
    library(dplyr);
    
    #  Setting up paths for downloading files  
    setfolder <- function() {
        if (file.exists(directory)) {
            unlink(directory, recursive=TRUE);
        } else {
            dir.create(directory);
        }
        setwd(directory);
        dir.create("src");
        dir.create("data");
        dir.create("result");
    }
    
    # download and unzip a file 
    getdata <- function() {
        download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "src/data.zip", method='curl');
        unzip("src/data.zip", exdir = "data");
        return(list.dirs("data", recursive=FALSE)[1]);
    }
    
    setfolder();
    return(getdata());
}


##
# Merging data from three files(subject_***, Y_***, X_*** ) 
# from test and train folder:  
##

mergedata <- function(dir) {
    subjects_train <- read.csv(paste(dir, "train", "subject_train.txt", sep = "/"), 
                                 sep = "", header= FALSE);
    y_train <- read.csv(paste(dir, "train", "y_train.txt", sep = "/"), 
                                 sep = "", header= FALSE);
    x_train <- read.csv(paste(dir, "train", "X_train.txt", sep = "/"), 
                               sep = "", header= FALSE);
    train <- cbind(x_train, subjects_train, y_train);
    
    subjects_test <- read.csv(paste(dir, "test", "subject_test.txt", sep = "/"), 
                                 sep = "", header= FALSE);
    y_test <- read.csv(paste(dir, "test", "y_test.txt", sep = "/"), 
                               sep = "", header= FALSE);
    x_test <- read.csv(paste(dir, "test", "X_test.txt", sep = "/"), 
                                 sep = "", header= FALSE);
    
    test <- cbind(x_test, subjects_test, y_test);
    
    return(rbind(train, test));
}

# Functions select fields containig mean and standard deviation values 

filterByName <- function(dir, data) {
    featureNames <- read.csv(paste(dir, "features.txt", sep = "/"), sep = "", header= FALSE);
    featureNames$name <- gsub("-", " ", featureNames[[2]]); 
    featureNames$name <- gsub("\\(\\)", " ", featureNames$name);
    
    len <- length(data[1,])
    
    names(data)[len-1] = "subject";
    names(data)[len] = "activity";
    names(data)[1:(len-2)] = featureNames[,3];
    
    columns <- c(grep("(mean[^F])|(std)", featureNames[[2]], perl = TRUE), 562, 563)
    
    return(data[,columns])
}

# Replacing numeric value with string for activity 

replacename <- function(dir, data) {
    activityNames <- read.csv(paste(dir, "activity_labels.txt", sep = "/"), sep = "", header= FALSE);
    
    len <- length(data[,1])
    
    for (i in 1:len ) {
        data$activity[i] = as.character(activityNames[data$activity[i],2])
    }
    
    return(data)
}

##
# clean function generates tidy result dataset
##
clean <- function(data) {
    return(data %>% group_by(activity, subject) %>% summarise_each(funs(mean)))
}

##
# Function to run all functions
##

run_analysis <- function() {
    dir <- init();
    data <- mergedata(dir);
    data <- filterByName(dir, data);
    data <- replacename(dir, data);
    data <- clean(data);
    write.table(data, "result/result.txt", row.names=FALSE)    
}
