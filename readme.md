---
title: "Readme"
author: "Mehdi Halit"
date: "25 juillet 2015"
output: html_document
---

Getting and cleaning Data - Course Project

Course project deliverables for the Coursera course Getting and Cleaning Data

Installation

    Create a directory for this project
    All the data used for that project are included in a directory called "data" with the following structure, similar to the original one. All files are unzipped.:
     ????????? data
      ???   ????????? README.txt
      ???   ????????? activity_labels.txt
      ???   ????????? features.txt
      ???   ????????? features_info.txt
      ???   ????????? tidyX2.txt
      ???   ????????? test
      ???   ????????? train
      ????????? run_analysis.R
      
    To run the analysis, just execute the script run_analysis.R
    
Dependencies

The script run_analysis.R depends on the libraries plyr, dplyr and reshape2. If you have not installed them, you will be prompted a choice to do so.

Running the analysis

    The dataset asked in the project is called "tidyX2.txt" and is already included in the data directory.
    If you want to run the analysis : 
    Change the working directory in R to the installation directory
    Source the script run_analysis.R in R: source("run_analysis.R")
    The result wil be a text file called "tidyX2.txt" in the data directory
    
Codebook

Information about the dataset and the variables used and their signification is provided in CodeBook.pdf

Code

The code contains detailed commments explaining the steps in which the original data was transformed to tidyX2.txt

To get tidy dataset, we only kept the 66 measurements from the 561 originally available and which measure mean and standard deviations as required in the assignment instructions. We did not kept the 13 other variables that describe "MeanFreq" of the same variables, and which we supposed to be not independent from the mean measurements.

at the end of our data reshaping, we just executed the R follwing command to output the dataset to a txt file :

```{r}
write.table(newX2, "./data/tidyX2.txt", sep=" ", row.names = FALSE)
```

Thus, to read the data into an R script, you just have to execute the read alternative of this command :

```{r}
newX <- read.table("./data/tidyX2.txt", sep=" ", row.names = FALSE)
```


