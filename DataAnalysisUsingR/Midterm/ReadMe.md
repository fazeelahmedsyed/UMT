# Course Project - Getting and Cleaning Data
## Data Science Specialization

### Purpose:
The purpose of this file is to explain the analysis done on the original study, the processes defined in 'Run_analysis65.R' and the resultant data set 'Averages.txt'.

### Original Study:
Analysis was done on data sets produced from the original study of Human Activity Recoginition using smartphones done by Reyes-Ortiz, J. L.; Anguita, D.; Ghio, A.; Oneto, L.; and Parra, X.

### Analysis:
The objective of the analysis was to calculate Average Mean and Standard Deviation measurements for each Activity defined in the original Study. The analysis is carried out by running the script 'Run_Analysis65.R'.

'Run_Analysis65.R' does the following to data sets ascertained from the initial study.
1. Checks working directory, which is required to be the downloaded Zip folder. The function displays a warning message otherwise.
2. Reads all Training and Test data sets.
3. Combines all Training and Test data in a R Object named 'HAR'.
4. Extracts all Measurements of Means and Standard Deviations in a R Object named 'HAR2' and provides Activity labels to the column 'Activity Name'.
5. Calculates Average of all observed Mean & Standard Deviation measurements for each Activity and saves the result in a new file named 'Averages.txt' within the working directory.

'Averages.txt' is the resultant file created in the working directory. For details on 'Averages.txt' read 'CodeBook.md'.