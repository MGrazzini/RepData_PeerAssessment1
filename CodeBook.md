# CodeBook

A script named run_analysis.R is submitted containing all the instructions required to transform a set of data from several txt files into one tidy dataset.

* First, the necessary libraries are loaded (plyr) so as to perform such commands as ddply on the dataset;
* Files are read and stored in data frames; measurements are loaded as numeric values with the option colClasses = "numeric" as numeric manipulation will be necessary at a later stage;
* Two distinct data frames are assembled from raw data by making use of function cbind, one is for testing data and one for training data; column names are assigned from features data frame;
* The two data frames are merged into one by joining their rows with command rbind (1);
* Then, only the columns for Subject and Activity and those containing "mean" or "std" are selected into a new data frame through command grep (2);
* The values in column Activity are decoded from the numeric value to the related string according to the content of the activity_labels data frame (3);
* I decided to improve readability of column names by replacing the initial "t" or "f" with "Time." and "Freq."; likewise, I changed such strings as "-mean()-", "-std()-" with ".Mean." or ".Std." in order to obtain a better manageability (4);
* A tidy data frame is created by grouping the previous one by Subject and Activity, and calculating the mean value of the remaining columns accordingly (5);
* Finally, the tidy data frame is saved as a txt file.

## Variables

* activity_labels:  data frame relating activity numbers and names
* features: data frame listing the names of the measured variables 
* test\_subject and training\_subject: data frames containing a list of numbers corresponding to the subject for each observation, respectively in the test and training dataset
* test\_activity and training\_activity: data frames listing the activity number for each observation, respectively in test and training dataset
* test\_measurements and training\_measurements: data frames containing the measurements for each observation, respectively in the test and training dataset
* test\_global\_dataset and training\_global\_dataset: data frames created by juxtaposing Subject from (test/training)\_subject data frame, Activity from (test/training)\_activity data frame and measurements from (test/training)\_measurements data frame
* merged\_raw\_dataset: a data frame created by merging the two previous global datasets * merged\_selected\_dataset: this data frame contains only the columns related to mean and standard deviation measurements
* tidy\_data: contains the tidied data, that is one observation per Subject and Activity, and the mean value for each measurement