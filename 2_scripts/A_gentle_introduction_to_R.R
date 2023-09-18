##################################################################
##################################################################
#    Learning Outcome: Organize R analysis within a project      #    
##################################################################
##################################################################

#This script is almost the same as the first R script we started with. Since we
#opened this script by going through an R project, the relative file paths for the
#the data read into R and the results exported from and saved outside of R are 
#slightly different. The R project is just another way of keeping your data neat
#and organized in a logical manner.

#One other difference is that I've saved the "generalizedCI" function from the 
#end of the first script in its own R script where customized functions can be stored
#or quickly passed onto other scripts or users.

#Check R and RStudio are working
#install.packages("ggplot2")
library(ggplot2)
p <- ggplot(mtcars, aes(wt, mpg))
p + geom_point(aes(size = qsec, colour = factor(cyl)))
#library is a command used to install R packages that extend what base R can do.
#ggplot2 is a R package containing functions that extend the kinds of plots that base R can do
#mtcars is a data frame and an input to a function called ggplot
#wt and mpg are variables stored in the data frame mtcars: inputs to ggplot
#ggplot is a function for creating nice-looking plots
#p is an object (the nice-looking plot) that is produced by the ggplot function stored in R
#geom_point is another function in the ggplot2 package that is used to customize plot p
#qsec and cyl are variables stored in the data frame mtcars: inputs to geom_point

#Every line that begins with a hashtag is a comment. Comments are not code so R
#doesn't run anything beginning with a hashtag. Comments are used to document R 
#scripts so that other people know what each line or group of lines of code does.

#I encourage you to add your own comments in your own words to any lines of code
#to help reinforce what each line of code does.

##################################################################
##################################################################
#     Learning Outcome: Opening and Navigating R and RStudio     #
##################################################################
##################################################################

#RStudio is a text editor and graphical user interface that makes it easier to 
#write, edit, and run code in R. There are different windows and drop-down menus
#in RStudio. You are reading code within a window for an R script.

#The Console window (by default, lower left pane in RStudio) shows code that is 
#running and results from code that is run. You can either type commands directly
#in the console or highlight lines of code in the script and click the Run icon.

#The Files window (by default, right-side pane in RStudio) shows the file contents of the folder on your computer where you
#have stored and opened this script.

#The Plots window (by default, right-side pane in RStudio) displays plot objects created 
#in R.

#The Packages window (by default, right-side pane in RStudio) shows the list of R packages
#you currently have installed and access to. These packages are not downloaded with base
#R, but once installed can extend R's abilities. New packages are constantly being created.

#The Help window provides information about what specific packages and functions do and how to 
#write the code for executing those functions.

?ggplot2
?ggplot
?geom_point

##################################################################
##################################################################
#      Learning Outcome: Create and Save an Analysis Script      #
##################################################################
##################################################################

#Click File, then Save As, then save this file with another name. 
#I suggest "A_gentle_introduction_to_R_FIRSTNAME_LASTNAME".

#To save edits within a script without saving under a new name, you can
#either click File, then Save, or click the blue disk Save icon.


##################################################################
##################################################################
# Learning Outcome: Read data into R and save data outside of R  #
##################################################################
##################################################################

rugr <- read.csv("1_data/ABMI_RUGR_-_BU_LAB_PROJECT_main_report.csv", header=TRUE)
#read.csv is a base R function that imports data from a *.csv file in the same folder 
#as this script  
#stores the read-in data in a dataframe "rugr" and tells R that first row has variable 
#names (=the header row)
#These data are Ruffed Grouse ("RUGR" for short) observations from Autonomous Recording
#Unit recordings stored and transcribed in the WildTrax data repository.
rugr
#displays data contained in dataframe "rugr". 
names(rugr)
#lists all the variable names in the dataframe "rugr"
str(rugr)
#lists the type of data and possible values of each variable in "rugr"
#data types include int(=integers), chr(=character strings), num(=real numbers),
#    logi(=logical: TRUE/FALSE)
rugr2<-rugr
#create a copy of the data frame "rugr", stored under a different name. Now you
#can modify each data frame separately

write.csv(rugr, file="3_outputs/RUGR.anotherfilename.csv") 
#saves the data frame "rugr" outside of R, but under another file name. We haven't
#made any changes to this file but you can save edited data frames the same way.
save(rugr,rugr2, file="3_outputs/RUGR.anotherfilename.RData")
#Another way to save data frames or multiple R object types is to use the "save"
#function and store objects in an *.RData file outside of R. Notice that RData files
#can store data more compactly than a *.csv file can.

ls()
#lists the data frames and other objects currently stored in open R workspace
rm(p,rugr,rugr2)
#deletes objects within parentheses from open R workspace
ls()

load("3_outputs/RUGR.anotherfilename.RData")
ls()

getwd()#get working directory where this R project is being stored; result is a file path name in quotation marks
#Relative file paths to input and output files, based on the R project location,
#are used to read in inputs and save outputs.

##################################################################
##################################################################
#     Learning Outcome: Examine the contents of a data frame     #
##################################################################
##################################################################

str(rugr)
summary(rugr)
#produces some summary statistics for each variable in "rugr"

longitude
individual_count
#What happens if you try to look at individual variables in the data frame?

#to refer to specific variables, write dataframeName$variableName
rugr$longitude
#lists all values within the variable "longitude"
rugr$individual_count
#lists all values within the variable "individual_count". 
#NA=missing value. In this data frame, that means for a given recording no Ruffed
#Grouse were detected. We will come back to this later.

#To make it easier to write variable names without including the data frame name
#and dollar sign, you can "attach" a data frame. Then you can get away with writing
#just the variable name.
attach(rugr)
longitude
individual_count
#Attaching a data frame is generally not recommended once you have multiple data 
#frames in the same workspace. To "detach" a data frame and return to the
#dataframeName$variableName syntax:
detach(rugr)

##################################################################
##################################################################
#Learning Outcome: Identify different parts of a script: data    #
#    frame, variables, constants, basic R functions, operations, #
#    objects, comments                                           #
##################################################################
##################################################################

#There are two data frames currently active in this R workspace. What
#are their names?

#Give 2 examples of variable names that are for real numbers stored in either data frame.
#Give 1 example of a variable name that is for TRUE/FALSE data stored in either data frame.
#Give 3 examples of variable names that are for integers stored in either data frame.
#Give 3 examples of variable names that are for character strings stored in either data frame.

#		Sorting Data
rugr$detection_time
Ord1 <- order(rugr$detection_time)
#sorts dataframe "birds" by values in the variable "detection_time"
rugr[Ord1,]
rugr[Ord1,]$detection_time
#displays data in dataframe "rugr", or just the variable "detection_time",
#ordered by values in the variable "detection_time"
rugr$detection_time
#does not save the data inside "rugr" in that order
rugrDetectionTime<-rugr[Ord1,]
#saves the data inside "rugr", ordered by detection time in a new object 
rugrDetectionTime$detection_time

#Basic Functions
mean(rugrDetectionTime$detection_time)
#calculates mean detection time of Ruffed Grouse sounds within each 1-minute recording
#why is mean NA?
mean(rugrDetectionTime$detection_time, na.rm=TRUE)
#mean is now calculated but is not stored in R memory
detectionMean<-mean(rugrDetectionTime$detection_time, na.rm=TRUE)
detectionMean
#mean is now calculated and stored as a constant (single number value) in R object
#"detectionMean"

sum(rugrDetectionTime$detection_time, na.rm=TRUE)
#calculates sum of all values from all observations for the variable "detection_time"
median(rugrDetectionTime$detection_time, na.rm=TRUE)
#calculates median value (50th percentile) for the variable "detection_time"
min(rugrDetectionTime$detection_time, na.rm=TRUE)
#calculates minimum observed value for the variable "detection_time"
max(rugrDetectionTime$detection_time, na.rm=TRUE)
#calculates maximum observed value for the variable "detection_time"
sd(rugrDetectionTime$detection_time, na.rm=TRUE)
#calculates standard deviation for all observations of the variable "detection_time"
var(rugrDetectionTime$detection_time, na.rm=TRUE)
#calculates variance for all observations of the variable "detection_time"
length(rugrDetectionTime$detection_time)
#calculates sample size for the variable "detection_time"
stem(rugrDetectionTime$detection_time)
#generates a stem-leaf plot for values of the variable "detection_time"
hist(rugrDetectionTime$detection_time)
#generates a histogram plot showing distribution of values of the variable "detection_time"
hist(rugrDetectionTime$detection_time,
     xlab = "Detection Time", 
     ylab="# of Detections",
     main="Ruffed Grouse Detection Times",
     col="blue")
#same histogram, modified axis labels.
#histogram is another graphical diagnostic of normality in data. If the sparrow data
#were normally distributed (they are not), distribution would be more symmetrical.

quantile(rugrDetectionTime$detection_time, na.rm=TRUE)
#0 %, 25 %, 50 %, 75 %, and 100 % quantiles for the variable "detection_time"
summary(rugrDetectionTime$detection_time, na.rm=TRUE)
#0 % (minimum), 25 % (first quartile), 50 % (median), mean, 75 % (third quartile), and 100 % quantiles (maximum) for the variable "detection_time"

#Save results from each of the above commands in a separate object.


qqnorm(rugrDetectionTime$detection_time)
#produces a very basic quantile-quantile plot of Ruffed Grouse detection times.
qqnorm(rugrDetectionTime$detection_time, main = "Normal Q-Q Plot of Ruffed Grouse detection times",
       xlab = "Theoretical Quantiles",
       ylab = "Sample Quantiles", plot.it = TRUE, datax = FALSE)
#same Q-Q plot, modified axis labels
qqline(rugrDetectionTime$detection_time, datax = FALSE)
#produces a line with slope y/x=1.0 running through first and third quartile.
#Q-Q plot is another graphical diagnostic of normality in data. If the sparrow data
#were normally distributed (they are not), points in the plot would more or less be 
#a straight line.

shapiro.test(rugrDetectionTime$detection_time)
#calculates a normality test statistic. 
#Significant difference indicates that detection times are non-normally distributed.
shapiro.test(rnorm(100, mean = 5, sd = 3))
#calculates the Shapiro-Wilks test statistic for some randomly generated data. 
#Here,#the test statistic suggests a normal distribution.

#There are other normality test statistics you can try, but you need to download
#the package 'nortest' independently of the main R software, then call up that
#package before running these tests

#Some basic operations
2+3         #not stored in memory
A<-2+3      #stored in memory

B<-rugrDetectionTime$detection_time/60 #rescale detection variable
mean(B, na.rm=TRUE)
min(B, na.rm=TRUE)
max(B, na.rm=TRUE)

timeBeforeEnd<-60-rugrDetectionTime$detection_time
#estimates time between detection and end of 1-minute recording: object not part
#of data frame "rugrDetectionTime"

rugrDetectionTime$timeBeforeEnd<-60-rugrDetectionTime$detection_time
#estimates time between detection and end of 1-minute recording: object becomes part
#of data frame "rugrDetectionTime"

negDetectionTime<-rugrDetectionTime$detection_time*(-1)
#a nonsensical variable I created to show a basic multiplication function


##################################################################
##################################################################
#        Learning Outcome: Slice and filter data frames          #    
##################################################################
##################################################################
range(rugrDetectionTime$latitude, na.rm=TRUE)
range(rugrDetectionTime$longitude, na.rm=TRUE)

hist(rugrDetectionTime$latitude, 
     main="Latitude of Recording Observations",#optional
     xlab="Latitude of Observation",#optional
     ylab="Number of Observations",#optional
     col="darkred")
hist(rugrDetectionTime$longitude, 
     main="Longitude of Recording Observations",#optional
     xlab="Longitude of Observation",#optional
     ylab="Number of Observations",#optional
     col="darkgreen")

#create a new variable
rugrDetectionTime$latitudeGroup<-ifelse(rugrDetectionTime$latitude<54.5,"South","North")
levels(as.factor(rugrDetectionTime$latitudeGroup))
levels(rugrDetectionTime$latitudeGroup)#Why do we get a value of NULL?


boxplot(detection_time~latitudeGroup, data=rugrDetectionTime,
        main="Ruffed Grouse Detection Times (N vs. S)",
        xlab="Latitude Group (N>54.5, S<54.5)", 
        ylab="Detection Times (s)") 
#Draws a boxplot of Ruffed Grouse detection times vs latitude group

#Box plots can be used as one graphical diagnostic of normality in data. The Ruffed
#Grouse detection times are not that normally distributed but are fairly 
#symmetrically distributed at northern vs. southern sites. 


mean(rugrDetectionTime$detection_time[rugrDetectionTime$latitudeGroup == "South"], na.rm=TRUE)
mean(rugrDetectionTime$detection_time[rugrDetectionTime$latitudeGroup == "North"], na.rm=TRUE)
#alternatively
mean(rugrDetectionTime[rugrDetectionTime$latitudeGroup == "South",]$detection_time, na.rm=TRUE)
mean(rugrDetectionTime[rugrDetectionTime$latitudeGroup == "North",]$detection_time, na.rm=TRUE)

mean(rugrDetectionTime[rugrDetectionTime$latitudeGroup == "South"]$detection_time, na.rm=TRUE)
mean(rugrDetectionTime[rugrDetectionTime$latitudeGroup == "North"]$detection_time, na.rm=TRUE)
#What error do you get if you do not include a comma within the square brackets

nrow(rugrDetectionTime)
northernSites<-rugrDetectionTime[rugrDetectionTime$latitudeGroup == "North",]
nrow(northernSites)
#filters data frame to northern sites only and saves result in a new data frame
southernSites<-rugrDetectionTime[rugrDetectionTime$latitudeGroup == "South",]
nrow(southernSites)
#filters data frame to southern sites only and saves result in a new data frame

#another way of filtering: what is the exclamation mark doing?
southernSites2<-rugrDetectionTime[!rugrDetectionTime$latitudeGroup == "North",]
nrow(southernSites2)

#another way of filtering: what is the %in% doing?
northernSites2<-rugrDetectionTime[rugrDetectionTime$latitudeGroup %in% c("North"),]
nrow(northernSites2)

#one way of slicing (creating a data frame with fewer variables)
rugrFewerVariables<-rugrDetectionTime[,c("location",
                                         "longitude",
                                         "latitude",
                                         "latitudeGroup",
                                         "recording_id",
                                         "recording_date_time",
                                         "species_code",
                                         "species_common_name",
                                         "individual_order",
                                         "individual_count",
                                         "detection_time")]
#results saved in a new data frame
str(rugrFewerVariables)

#another way of slicing: 
names(rugrDetectionTime)
ncol(rugrDetectionTime)
rugrDetectionTime$equipment_make<-NULL
rugrDetectionTime$organization<-NULL
rugrDetectionTime$observer<-NULL
rugrDetectionTime$project_id<-NULL
rugrDetectionTime$location_buffer_m<-NULL
rugrDetectionTime$location_id<-NULL
names(rugrDetectionTime)
ncol(rugrDetectionTime)
#What has happened in the original data frame?


tapply(rugrFewerVariables$detection_time, rugrFewerVariables$latitudeGroup, mean, na.rm=TRUE)
#calculates mean value of "detection_time" by latitude group 
m1 <- tapply(rugrFewerVariables$detection_time, rugrFewerVariables$latitudeGroup, mean, na.rm=TRUE)
#calculates and stores mean values of "detection_time" by latitude group in a single step

#gives number values for the variable columns in dataframe "rugrFewerVariables"
sapply(rugrFewerVariables[,9:11], FUN=mean, na.rm=TRUE)
#calculates mean for multiple variables, the bird codes in columns 9, 10, 11
#confirm this
mean(rugrFewerVariables$individual_count, na.rm=TRUE)
mean(rugrFewerVariables$individual_order, na.rm=TRUE)
mean(rugrFewerVariables$detection_time, na.rm=TRUE)


lapply(rugrFewerVariables[,9:11], FUN=mean, na.rm=TRUE)
#same result as sapply command but results are in a vertical list
C<-lapply(rugrFewerVariables[,9:11], FUN=mean, na.rm=TRUE)
C$individual_order
C$individual_count
C$detection_time
#Don't be fooled: C is a list, not a data frame
C[["individual_order"]]
C[["individual_count"]]
C[["detection_time"]]

##################################################################
##################################################################
#        Learning Outcome: Install and call in R packages        #    
##################################################################
##################################################################

#R is different from a product like SAS 9.4, which is produced by a single central institute.
#Many independent programmers contribute programs for conducting different analyses in R.
#These programs are stored in "packages" that are separate from the main programming techniques that are downloaded with R.
#You can download these packages for free just like basic R, but you may need to download them separately.
#You also have to make sure that the packages you are interested in can be run with the version of R on your computer.
#Finally, some packages may require that you have other packages in addition to the basic R package.
#The "library" function is used to activate a given package not in basic R, before you invoke that package's programs.
#The package "e1071" should be downloaded in addition to R if you want to use it to measure skewness and kurtosis in data.

#First, you must "install" a new package like "e1071" in R before you call it into R.
#There are a few ways to do that: the easier way is to go into the Tools dropdown menu and pick "Install Packages"
#Another, slower way is to go to a CRAN (Comprehensive R Archive Network) website and download the package,
#then copy it to a library folder in R on your computer. 

#WARNING: A third way is to include a command in R to install packages automatically rather than do it 
#manually, using the install.packages function. This way may save time but is less desirable if you
#are sharing R scripts with other people, who may not realize until too late that R is downloading a
#program that they may not want onto their laptops.
#install.packages("e1071")

#Once you have installed a package that is not part of basic R, activate it with the library function
library(e1071)
#calls up the R statistics package e1071 so that we can use skewness and kurtosis functions
skewness(rugrDetectionTime$detection_time, na.rm=TRUE)
#calculates skewness of distribution of values for the variable "detection_time"
kurtosis(rugrDetectionTime$detection_time, na.rm=TRUE)
#calculates kurtosis of distribution of values for the variable "detection_time"

library(nortest) #run some normality statistics not available in base R
cvm.test(rugrDetectionTime$detection_time)
#Cramer-von Mises test
ad.test(rugrDetectionTime$detection_time)
#Anderson-Darling test
lillie.test(rugrDetectionTime$detection_time)
#Lilliefors (Kolmogorov-Smirnov) test
pearson.test(rugrDetectionTime$detection_time)
#Pearson-chi square test
#try these R functions with another variable in the "rugrDetection" dataset

#or see what you get for test results with simulated random data
cvm.test(rnorm(100, mean = 5, sd = 3))
ad.test(rnorm(100, mean = 5, sd = 3))
lillie.test(rnorm(100, mean = 5, sd = 3))
pearson.test(rnorm(100, mean = 5, sd = 3))


#Remember when diagnosing normality in variables of interest that
#normality of independent and dependent variables often matters less than normality
#of residuals from the models using these independent and dependent variables.



##################################################################
##################################################################
#Learning Outcome: Load a custom-made function with inputs and   #
#     outputs                                                    #
##################################################################
##################################################################

#We'll load a generalized confidence interval function that is stored 
#in another script
source("0_functions/myFunctions.R")

generalizedCI(rugrDetectionTime, rugrDetectionTime$detection_time, 50)
generalizedCI(rugrDetectionTime, rugrDetectionTime$detection_time, 90)
generalizedCI(rugrDetectionTime, rugrDetectionTime$detection_time, 95)
#size of confidence interval increases as third input to function increases

save(rugr,
     rugrDetectionTime,
     rugrFewerVariables,
     generalizedCI, file="3_outputs/RUGRoutputLessonEnd.RData")

help.start()
#this is the built-in R tutorial
quit()
#quits the R program


















