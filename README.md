---
title: "Data Cleanup Guide"
author: "Elena Chernousova"
date: "Sunday, May 24, 2015"
output: html_document
---

## Overview

There is R script cleanning data collected from the accelerometers installed in Samsung Galaxy S smartphone

## Usage

To run script: 

```
source("run_analysis.R");
run_analysis();
```

## Script details

Script contains the following functions:

### init
> Download raw data and set directory sctrucrture to store raw/result files

### mergedata
> Merging data from three files(subject_***, Y_***, X_*** ) 
> from test and train folder: 

### filterByName
> Functions select fields containig mean and standard deviation values 

### replacename
> Replacing numeric value with string for activity 

### clean 
> clean function generates tidy result dataset

### run_analysis
> Function to run all functions


