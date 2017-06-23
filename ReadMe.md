---
title: "Readme.md"
author: "Brad Cooley"
date: "6/23/2017"
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

**Project summary**: collect and process the Human Activity Using Smartphones dataset: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

All code in **run_analysis.R** script while **CodeBook.md** describes the data and processing.

---

### Repository table of contents

* **README.md** (this file)
* **run_analysis.R**
* **CodeBook.md**

---

Data description
----------------

#### The raw dataset

The measurement data was collected in experiments using recordings of 30 volunteer persons (`Subject`), aged [19-48], performing daily-living activities (`Activity`) while carrying a waist-mounted Samsung Galaxy S II smartphone. The smartphone was equipped with two sensors: an accelerometer and a gyroscope that recorded, respectively, the 3-axial linear acceleration and 3-axial angular velocity signals of the subject. The experiments were video-recorded to label the data manually. The measurements were randomly partitioned into two sub-sets: `Training` (70%) and `Test` (30%).

 
#### Processing the HAR raw data into tidyHAR (tidy format)
Summary of Data processing steps in **run_analysis.R**: 

The raw data consists of three text files for both TRAINING data and TEST data. Each of the three TRAINING files contains 7352 rows, each TEST file contains 2947 rows. For both TRAINING and TEST,  three files contain;
* measurement data for 561 measures (X_~.txt)
* subject IDs for each row of measures (subject~.txt)
* activity IDs for each row of measures (Y_~.txt)

Additional files apply to both TRAINING and TEST data:
* Activity descriptions (activity_labels.txt)
* Feature descriptions (features.txt)

run_analysis.R
--------------
In summary, the script:

* Reads the TRAINING and TEST files into data frames 
* Appends the TEST files to each of the TRAINING files
* Applies Activity names and feature names to the data
* Subsets only those columns which contain Mean or Std Deviation measures (68 of the 561 measures)
* Creates a "tidy" data set of averages for each of the 68 mean and std. dev measures by Subject / Activity
* Writes the tidy data set to a csv file

### References
<a name="Ref1"></a> [1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012. </a>


