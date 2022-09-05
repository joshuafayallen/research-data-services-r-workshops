# The content in this notebook was developed by Jeremy Walker.
# All sample code and notes are provided under a Creative Commons
# ShareAlike license.

# Official Copyright Rules / Restrictions / Privileges
# Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)
# https://creativecommons.org/licenses/by-sa/4.0/

# The dataset used in this workshop is a modified version of the
# data available in the PLM package containing the dataset "Males"
# Documentation: https://www.rdocumentation.org/packages/plm/versions/2.2-0/topics/Males


####################
####################
##### PART - 0 #####
# I make heavy use of annotations throughout my code (and you should too!).
# Annotations or comments in R are preceded by a '#' which effectively tells R
# to ignore that information.  As your code become more intricate and complex,
# and as you begin to share your code with others, these annotations are
# critical for documenting what your code is doing and what it is meant to do.


####################
####################
##### PART - 1 #####
# BASICS OF R SYNTAX

# VALUES - Numbers
# Numbers are represented by digits.  Easy peasy!
# Additionally, line-by-line, you can do most common
# math operations.

# Display arbitrary numbers
3
3.14

# Calculate numbers on the fly
3 + 0.1 + 0.04

22 / 7

3 * 3

3 ** 3

3 ^ 3

1.464592^3

# Complex, complicated, and advanced math is built directly
# into R.  Note, the example below is just an illustration of
# how robust R is, you are not expected to actually understand
# the math behind it all :)

# e^(πi) = -1
exp(1) ^ (pi * sqrt(as.complex(-1)))


# VALUES - Strings and characters
# For words, characters, and other non-numeric representations
# of information and values, you need to use " " or ' ' to
# indicate that a value is a string or character.

"cats"

"bananas"

# Note the difference in output between the character "3"
# and the numeric value 3.

"3"
3

# In R, characters can not be transformed as easily as
# numeric values.  Example that produces an error:
"bananas" + "oranges"


# OBJECTS - The core of "object oriented" programming and scripting.
# Objects are used to store and represent individual values, sets/lists
# of values, and complex information like entire dataframes, statistical
# models, and defined functions/operations. At its core, "objects"
# are useful for succinctly representing, transforming, and working
# with information.

# Example: creating an object x and assigning it <- a value
x <- 3
x

# Example: updating the value of x
x <- x + 20
x


# Example: overwriting the existing value of x with a new value
x <- "bananas"
x

# Note: The use of "x" is entirely arbitrary.  Object names can be
# anything so long as they follow a few rules (see links).

# Guides for naming rules and naming conventions
# (1) https://www.dummies.com/programming/r/how-to-successfully-follow-naming-conventions-in-r/
# (2) https://www.datamentor.io/r-programming/variable-constant/
# (3) https://www.r-bloggers.com/rules-for-naming-objects-in-r/

# Quick rules: start names with roman alphabetic characters and only
# use "." and "_" if you have to.

# Opinion: For compatibility with other tools, don't use special
# characters as at all: variableName, variable3Name, objectNameHere345

look_at_this_number <- 2
look_at_this_number

variable.Name.Here <- "oranges"
variable.Name.Here

# Make your object names meaningful and clear. A very common problem
# in coding is confusing an object's name with an object's value.
bananas <- "pineapples"
bananas

# An extremely common convention is lowercaseFollowedByTitleCase
varPerson <- "Jeremy"
varAge <- 103
varMentalState <- "a very stable genius"


# COMBINED VALUES - Vectors and Lists
# Collections of values are often represented in the form
# of vectors or lists.  These can take a variety of formats
# and structures, but the easiest one to start with is c().

# Create a combined set of values as a list.
c()
c("a","b","c","d","e")

# Assign the collection of values to an object
numList <- c("a","b","c","d","e")

# Show the entire collection
numList

# Access specific sub-components of the object using []
numList[ 1 ]
numList[ 3 ]

# Access a range of values
numList[ 2:4 ]

# Access a sub-collection of values
numList[ c( 1:3 , 5 ) ]


# TYPEOF() & CLASS()
# At times it will be unclear exactly 'what' an object
# represents or what types of values it contains. You
# will often need to inspect objects and values directly
# in order to debug and resolve errors in your code.

typeof(3)
typeof("3")
typeof(numList)

class(3)
class("3")
class(numList)


####################
####################
##### PART - 2 #####
# IMPORTING AND INSPECTING DATA (AND UNDERSTANDING FUNCTIONS)

# R and many R packages come pre-loaded with practice datasets.
# You will often see these reference in tutorials, documentation,
# and support forums.  We won't use these much, but it's good
# to understand a bit about them.

# See the datasets already included in R
data()

# Load the "USJudgeRatings" dataset
data("USJudgeRatings")

# The USJudgeRatings object now appears in the
# R environment window.  The whole dataset can
# now be called as its own object.
USJudgeRatings

# It's much more common to load data from a CSV file
# or some other form of externally saved data.


# OPTION 1: Import the data manually.

# In the Environment pane in RStudio, click on "Import
# Dataset" and select the "From text (base)" option to
# begin manually importing the "males.csv" dataset.


# OPTION 2: Import data using code and the full directory.

# Using the read.csv(...) command, you can tell R to
# open the CSV file by giving the full path directory on
# your computer.  It might look something like this...
# (note: forward slashes "/" are used to delineate folders)

# read.csv("C:/Users/tokyo5/downloads/males.csv")


# OPTION 3: Import the data from the "working directory"
# Setting the working directory during the R sessions will
# tell R to use a specific folder by default for the purposes
# of importing and exporting data.

# The following steps will allow you to set the working
# directory.  For this workshop, you should choose the folder
# on your computer in which the "males.csv" file is located.

# RStudio -> Menu Bar -> Session -> Set Working Directory
read.csv("males.csv")


# Load a CSV file and assign it to an object called "data"
males <- read.csv("males.csv", stringsAsFactors = TRUE, na.strings = "NA")
males

# ALTERNATIVE You can load the CSV directly from a URL if needed...
# males <- read.csv("https://research.library.gsu.edu/ld.php?content_id=57157521", stringsAsFactors = TRUE, na.strings = "NA")
# males

# You can inspect the data base double-clicking on the new "males"
# object in the environment pane of RStudio.  Alternatively, you
# can use the View(...) function
View(males)

# Inspect the structure/datatypes and first few samples of the data
# using either the environment pane or the str(...) function
str(males)

# Basic descriptive statistics can be generated using summary(...)
summary(males)

# View the first few rows of data using head(...)
head(males)

# FUNCTIONS - Predefined series of commands, operations, and tasks.
# Functions in R usually take the form of functionName(...).  Inside
# the parentheses is where you include values for various parameters
# (i.e. "options").  Sometimes nothing is required, sometimes there are
# values required, and sometimes you only need to specify some of the
# parameters....It can be wildly different from function to function.

# To learn more about a function within RStudio, simply run the command ?functionName()
?head()

# explicitly set parameter options
head(x = males)

# explicitly set parameter options and override defaults
head(x = males, n = 15)



##               ##
## PRACTICE TIME ##
##               ##

# Using the tail(...) function, view the last 3 rows of data from the males dataset.

# ???(x = ???, n = ???)


####################
####################
##### PART - 3 #####
# SUBSETTING BY INDIVIDUAL COLUMNS
# In addition to doing operations on the entire dataset, you can select individual
# columns to use in calculations and processes.

# First, identify column names.  One shortcut is the colnames(...) function.
colnames(males)

# One of the most common ways to access a sub-component of an object
# is by using the "$".
# Example: objectName$attribute
# Example: males$school yields the vector of values representing the
#          "school" column from the dataset.

males$school

# With this single vector of information, many of the same summary statistics
# and functions can be used to inspect the data.
str(males$school)
head(males$school)
summary(males$school)

# Additionally, some functions that do not work on whole datasets are now
# usable when viewing a single variable.

min(males$school)

max(males$school)

mean(males$school)

median(males$school)

quantile(males$school)

?quantile

quantile(males$school, probs = c(0.25,0.75))

IQR(males$school)

quantile(males$school, probs = c(0.025,0.975))



##               ##
## PRACTICE TIME ##
##               ##

# Generate a few calculations (similar to above),
# but using the "exper" variable representing the
# years of experience for each individual sample.

# Quick note: The "exper" function contains missing
# values, so we need to add the "na.rm = TRUE"
# parameter/options in order for the functions to work as expected.

# min
# min(males$exper, na.rm = TRUE)

# max
# ???(males$exper, na.rm = TRUE)

# mean
# ???(males$???, na.rm = TRUE)

# median
# ???(???$???, na.rm = TRUE)

# quantile
#


####################
####################
##### PART - 4 #####
# INSTALLING AND IMPORTING NEW PACKAGES

# In many cases, you will want to rely on additional
# packages that have been developed by members of the R
# community.  These packages may help with particular
# forms of analysis, data visualization, or just about
# anything else you can imagine.

# Once you have identified a package, you can
# Example:  install.packages("package_name_goes_here")
#           install.packages("tidyverse")
#           install.packages("psych")
#           install.packages(c("psych","tidyverse","MASS"))

# Once you have installed a package using R, you will not
# need to run that command again, regardless of which R script
# you are working from.

# install.packages("psych")

# Once installed, you can import a package and all of its
# components by using the library(...) function and typing
# the name of the package without quotation marks "".
library(psych)

# Some packages have overlapping function names, so you may need
# to explicitly call functions from their respective packages.
# Example:  package_name::function_name(...)
#           pscyh::describe(...)
psych::describe(males)

# However, in most cases you can just use the functions directly.
describe(males)

# As with other functions, use the "?" to learn about function
# parameters, options, and requirements.
?describe



##               ##
## PRACTICE TIME ##
##               ##

# Using the describe(...) function, generate the descriptive
# statistics only for the "wage" variable in the males dataset.

# ???(males$???)

# Using the describe(...) function, generate the descriptive
# statistics for the "wage" variable in the males dataset.  ALSO,
# change the describe(...) parameters in the following way...
#
# ranges = FALSE
# type = 2
# IQR = TRUE

# describe(males$???, ????, ????, ????)



####################
####################
##### PART - 5 #####
# SUBSETTING DATA BY ROWS & COLUMNS
# Instead of using the $ to access specific columns, another
# approach to subsetting the data is to use [ ].

# Available column names:
colnames(males)

# Subsetting by column name:
males[ "exper" ]

# Subsetting by column location:
males[ 2 ]

# In Part 1 there is information about the C(...) function that
# effectively collects (c) a list of *things*.  These things may be
# numbers, labels, sequences....a lot of different options depending
# on the context in which c(...) is used.  In this case, c(...) let's
# us specify multiple column labels.

# Subsetting by multiple columns by name:
males[ c("school","union","ethn") ]

# Subsetting by multiple columns by location:
males[ c(1,3:4) ]


# ROWS AND COLUMNS - Subsetting by both columns and rows (i.e. by variables and observations)
# Subsetting by both rows and columns requires using a
# structured notation that is similar to matrix-notation.
# Example: dataframe[ rows , columns ]
# Example: males[ 1 , "wage" ]

# Get the datum for the row #1 and the column "wage"
males[ 1 , "wage" ]

# Get the data for rows 1-10 and the column "wage"
males[ 1:10 , "wage" ]

# Get the data for rows 1-10 and the column
males[ 1:10 , c("union","wage") ]

# Get the data for non-sequential roles and the columns "union" AND "wage"
males[ c(2,3,5,7,11) ,  c("union","wage") ]

# CONDITIONAL SUBSETTING
# Instead of using fixed requests for rows/columns, conditional
# statements can be used to dynamically request subsets.

# Commonly used conditional operators are...
# > greater than
# < less than
# == equivalent too
# ! boolean "NOT"
# | boolean "OR"
# & boolean "AND"

# Get the data where the "wage" is greater than 5; select all columns
males[ males$wage > 5 ,  ]

# Get the data by selecting only "union", "wage", "married" columns
males[  , c("union","wage","married") ]

# Get the data where the "wage" is greater than 5; select only
# "union", "wage", "married" columns
males[ males$wage > 5 , c("union","wage","married")]

# Get the data where the "majVotes" is less than or equal to 8; select only
# "union", "wage", "married" columns
males[ males$wage <= 8 , c("union","wage","married")]
males[ males["wage"] <= 8 , c("union","wage","married")]

# Same as above, except "wage" is less than or equal to 8 AND the union
# is equal to "yes"
males[ (males$wage <= 8) & (males$union == "yes") , c("union","wage","married")]

# Select the same columns as above, but only select rows where "union" is not null
males[ !is.na(males$union) , c("union","wage","married")]

# Alternative method using na.omit(DATA_OBJECT) to remove any/all observations that are
# not fully complete.
# Example:  na.omit(...)
#           na.omit( data )
#           na.omit( data[ rows , columns ] )
#           na.omit( males[  , c("union","wage","married")])
na.omit( males[  , c("union","wage","married")])


##               ##
## PRACTICE TIME ##
##               ##
# Subset the data according to the following:
# Rows/Observation - Only include rows where "married" is equivalent to "yes"
# Columns/Variables - Only include the following columns: "school", "married", "wage"

# males[ ???  ,  ???  ]



####################
####################
##### PART - 6 #####
# SAVING AND EXPORTING DATA

colnames(males)

# Subset males according to the desired rows / columns
# and assign it to a new object
males_subset <- males[ (males$wage <= 8) & (males$union == "yes") , c("union","wage","married")]

# Inspect new data subset
head(males_subset, n=20)

# Drop missing values / observation
males_subset <- na.omit(males_subset)
males_subset

# Lastly, the write.csv(...) will let you output a dataframe object
# directly to your harddrive.
write.csv(x = males_subset, file = "males_subset.csv", row.names = FALSE)

# For info about this function (or any other function), do not forget
# about the "?" utility.
?write.csv

