matrixStats
===========
Calculate statistics on a set of symmetrical matrices (For Terry Bertozzi).

Testing the script
------------------

First, load the `calc_rf_stats` function into your R session. This function is contained in the file named calc_rf_stats.R in this repo
```
source(file="/calc_rf_stats_function.R")
```

Then set the directory containing the matrix files. The test files are in the folded names testData in this repo
```
dir <- "/testData/"
```

To calculate the stats for the matricies:
```
results <- calc_rf_stats(dataDirectory=dir)
```
The results variable is an object of class `data.frame` and contains the statistics for each matrix file; one file per row.

To output the results as comma seperated values file:
```
write.csv(results, "results.csv")
```
