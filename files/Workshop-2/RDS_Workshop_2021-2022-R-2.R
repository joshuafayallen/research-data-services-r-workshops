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


# INSTALL TIDYVERSE
# If necessary, install TidyVerse
install.packages("tidyverse")
library(tidyverse)

# IMPORT DATA & REVIEW
# Option 1 - Set Working directory to correct folder, then use read.csv(...) to open the file
# RStudio -> Menu Bar -> Session -> Set Working Directory
males <- read.csv("males.csv", stringsAsFactors = TRUE, na.strings = "NA")

# Option 2 - Use read.csv(...) and use the full directory/path for the file location
# males <- read.csv("C:/Users/tokyo5/downloads/males.csv", stringsAsFactors = TRUE, na.strings = "NA")

# Option 3 - Import the dataset manually using "Import Dataset" in the environment pane.

# Option 4 - You can load the CSV directly from a URL if needed...
# males <- read.csv("https://research.library.gsu.edu/ld.php?content_id=57157521", stringsAsFactors = TRUE, na.strings = "NA")


# Confirm that the "males" dataset is open and assigned to its own object in R/RStudio
View(males)

# Summary
summary(males)

# First few rows and last few rows of data
head(males, n=7)
tail(males)

# Structure and datatypes in dataset
str(males)


####################
####################
##### PART - 1 #####
# CREATING AND MODIFYING VARIABLES AND COLUMNS (THE BASE R WAY)
# There are a variety of ways to create, transform, and
# modify variables in an existing dataset.

# Inspect the data
head(males)

# Create a new variable from scratch and assign it empty values.
males$var1 <- NA

head(males)

# Create a new variable and assign a fixed value
males$var1 <- "bananas"

head(males)

# Create a new variable that is calculated based on values already
# present in one or more variables.
# Example:  data$var3 <- data$var2 + 1000
#           data$var3 <- data$var2 + data$var1 + 3
#           males$edu_exp <- males$school + males$exper

# View the calculated variables as a standalone vector of results.
males$school + males$exper

# Assign values from this calculation to a new "edu_exp" variable.
males$edu_exp <- males$school + males$exper

head(males)


##               ##
## PRACTICE TIME ##
##               ##

# From the original documentation for the data, we know that each
# respondent's "exper" (experience) is a function of...
# exper = age - school - 6
# Therefore, age = exper + school + 6
# Using that information, generate a new variable "age" for the
# males dataset and assign the calculated values for age to that new
# variable/column.

# males$??? <- males$??? + males$??? + ???



####################
####################
##### PART - 2 #####
# CREATING AND MODIFYING VARIABLES AND COLUMNS (THE TIDYVERSE WAY)

# TidyVerse refers to a curated set of packages within the R
# development community.  These packages are extremely popular, are
# well supported, and make a lot of data-oriented tasks much much easier.

# The remainder of this workshop will mostly focus on using the dplyr
# package, a package that makes data manipulation tasks exceptionally
# straight-forward once you get the hang of it!

# TidyVerse info: https://www.tidyverse.org/
# dplyer homepage: https://dplyr.tidyverse.org/
# dplyer cheatsheet: https://github.com/rstudio/cheatsheets/raw/master/data-transformation.pdf

# Install TidyVerse if necessary
# install.packages("tidyverse")
library(tidyverse)

# str(...) is the base R function for viewing datatypes
str(males)

# Many functions in the TidyVerse and associated packages
# have identical, comparable, or possibly better features
# than related default R functions.  This workshop will
# mainly focus on using the dplyr package within the TidyVerse.

# One example is the glimpse(...) function from the dplyr package.
glimpse(males)

# Another example is tibble(...).  Similar to some Base R functions
# like data.frame(...) and as.data.frame(...), the tibble(...) functions
# transforms a table of data into what is sometimes referred to as a
# "tidy" format.  We will ignore the technical distinctions in this
# workshop.  But for our purposes, transforming males into tibble(males)
# can make the data easier to preview and understand.

# Full default output
males

# tibble(...) or "Tidy" format
tibble(males)

# Update and overwrite the original males using tibble(...)
males <- tibble(males)
males




# The mutate(...) function in dplyr enables us to create and modify
# columns and variables in the datases we are working with.

# Inspect the function's options and documentation
?mutate

# Using mutate(...) we can start by simply specifying the dataset,
# creating a new variable (var2) and assigning it a value.  This
# will return a temporary view of the dataset with the added variable.

# Example:  mutate(dataset , newVariable = values)
# Example:  mutate(males , var2 = "LOOK_HERE")
mutate(males, var2 = "LOOK_HERE")


# We can also use this function to effectively overwrite the original
# dataframe with the new dataframe generated from the mutate(...) function.
males <- mutate(males, var2 = "LOOK_HERE")


# Inspect the data
males

# Same function as above, but with the .data parameter explicitly included.
mutate(.data = males, var2 = "look2")


# Same function as above, but with cleaner formatting
mutate(
  .data = males,
  var2 = "look2"
  )


# mutate(...) can actually take any number of new variable parameters all at once!
# In the example below, we are adding var2, num3, and bool4 (the naming is arbitrary)
mutate(
  males,
  var2 = "look2",
  num3 = 3,
  bool4 = TRUE
  )

# Inspect the data
males

# Like before, to retain these values, we need to actually assign the outputs of the
# mutate(...) function to the dataset.
males <- mutate(
  males,
  var2 = "look2",
  num3 = 3,
  bool4 = TRUE
  )

# Inspect the data
males


# When creating a new variable, you can also indicate where you want the new column
# to be positioned with respect to other variables.
males <- mutate(
  males,
  var3 = "look3",
  .before = school
  )

# Inspect the data
males


# So far, we have strictly assigned fixed values to a new column, but mutate(...)
# and other functions in dplyr can actually do calculations and more complex assignments.

# Base R function mean(...) for getting the average value of a column
# Example:  mean( dataframe$variable)
# Example:  mean( males$school)
mean( males$school )

# In many TidyVerse functions, including mutate(...) in dplyr, once we have identified the
# dataset, we no longer need to use the "$" to specify columns.

# Example:
#
# mutate(
#   .data = dataset,
#   newVariable = mean(existingVariable)
# )
#
# mutate(
#   .data = males,
#   school_avg = mean(school)
# )

# Original mean function
mean( males$school )

# Dplyr use of mean()
mutate(
  males,
  school_avg = mean(school)
  )

# Same as above, but positioning the new column explicitly.
mutate(
  males,
  school_avg = mean(school),
  .after = school
  )

# Using the same function as above and overwriting the males dataset
males <- mutate(
  males,
  school_avg = mean(school),
  .after = school
)

# Inspect the data
males


# Going one step further, we can use mutate(...) to calculate values based
# on multiple existing columns.  In the example below, school_avg is subtracted
# from school to generate a new variable column: school_avg_centered.
mutate(
  males,
  school_avg_centered = school - school_avg,
  .after = school_avg
  )

# Overwrite and update the males dataset using the function above.
males <- mutate(
  males,
  school_avg_centered = school - school_avg,
  .after = school_avg
  )

# Inspect the data
males



##               ##
## PRACTICE TIME ##
##               ##

# From the original documentation for the data, we know that each
# respondent's "exper" (experience) is a function of...
# exper = age - school - 6
# Therefore, age = exper + school + 6
# Using that information, generate a new variable "age_tidy" for the
# males dataset and assign the calculated values for age to that new
# variable/column and place it before the "school" column.


# males <- mutate(
#   ???,
#   ??? = ??? + ??? + 6,
#   .before = school
# )

# Inspect the data
# males



####################
####################
##### PART - 3 #####
# SELECTING COLUMNS AND ROWS (THE TIDYVERSE WAY)

# Instead of using [ ] with a dataframe, dplyr provides extremely efficient
# and easy tools for subsetting data.  Most prominently, the select(...)
# function allows you to select which columns you want and the filter(...)
# function allows you to select which rows you.


# SELECTING COLUMNS using select(...)

# Inspect the function's options and documentation
?select()

# By default, the select(...) function only requires you to specify the dataset.
# However, by default, this will also subset the entire data to 0 columns.

# Example:  select(.data = dataset)
# Example:  select(.data = males)
# Example:  select(males)
select(
  males
)

# You can identify single or multiple columns by simply adding the column names
# to the parameters inside of the select(...) function.
select(
  males,
  school
)

# Multiple columns
select(
  males,
  school,
  exper
)

# Using the "-" in front a column name will negate/remove it from the resulting
# data subset.  You can also explicitly request everything using "everything()".
# For more options, read the documentation for the functions and the dplyr cheatsheet :)
select(
  males,
  everything(),
  -var2
)

# Inspect the data
males

# Using select(...), select all columns EXCEPT any of the variables that are included
# with a prepended "-" and overwrite the males dataset accordingly.

males <- select(
  males,
  everything(),
  -var1,-var2, -var3,-num3,-bool4,-school_avg,-school_avg_centered
  )

# Inspect the data
males


# FILTERING FOR ROWS using filter(...)

# Inspect the function's options and documentation
?filter

# Similar to select(...), the filter(...) function only requires a dataset as
# a minimum.  However, this will by default simply return the entire dataset as is.
filter(males)

# Expanding filter(...), we can add a conditional statement.  In the example below,
# filter(...) will only return rows from the male dataset where the value in the
# union-column is "yes"
filter(
  males,
  union == "yes"
)

# There are many options available for use with filter(...).  Below are some of the
# most commonly used conditional operators.  See the cheatsheet and documentation for
# more examples and guidance.

# <         less than
# <=        less than or equal to
# >         greater than
# >=        greater than or equal to
# ==        equivalent to
# is.na()   is null
# |         Boolean OR
# !         Boolean NOT
# &         Boolean AND

# Filter for rows where wage is greater than 5
filter(
  males,
  wage > 5
)

# Expand filter(...) by using multiple variables with different conditions.
filter(
  males,
  union == "yes",
  married == "yes"
)

# Expand filter(...) further by incorporating calculated values (e.g. mean(...)
# as part of conditional statements.
filter(
  males,
  union == "yes",
  married == "yes",
  ethn == "hisp",
  school > mean(school)
)

# Similar to select(...), you need to assign the results to an object in order to retain it.
males_filter_table <- filter(
                          males,
                          union == "yes",
                          married == "yes",
                          ethn == "hisp",
                          school > mean(school)
                        )

males_filter_table


##               ##
## PRACTICE TIME ##
##               ##

# Make a quick copy of the males dataset for the purposes of practice
males_temporary <- males

# Using the select(...) function, select and retain only the following
# variables: school, union, wage

# males_temporary <- select(
#   ???,
#   ?variable?,
#   ?variable?,
#   ?variable?
# )


# Now, using the filter(...) function, filter and retain only the rows from the
# males dataset that the following conditions: union == "yes" and wage >= 5

# males_temporary <- filter(
#   ???,
#   ?condition1?,
#   ?condition2?
# )

# Inspect the data
males_temporary




####################
####################
##### PART - 4 #####
# PIPING (THE REAL MAGIC IN TIDYVERSE)

# "Piping" is incorporated into the TidyVerse via a package called magrittr.
# This is automatically included whenever you load library(TidyVerse) as well
# as many individual TidyVerse packages.

# For further documentation, see magrittr homepage: https://magrittr.tidyverse.org/reference/pipe.html

# But in essence, the piping tool is a succinct way in R to chain multiple
# functions together.  This can be a bit strange at first.  But once you get the
# hang of it, this method can rapidly increase your productivity with respect to
# managing, manipulating, and preparing your data.

# Inspect the data
males

# Example using mutate(...) the default way to create a "year" variable and
# assign the value 1980 to all rows.
mutate( males, year = 1980 )

# Alternatively, using the %>% operator, the exact same operation can be performed as follows:
# Example:  dataset %>% function(...)
# Example:  dataset %>% mutate( newVariable = value)
# Example:  males   %>% mutate( year = 1980 )

males %>% mutate(year = 1980)


# In generalized terms, here is a side by side comparison of using mutate(...)
# without and with piping.

# Without piping:     mutate( a , b = c )
# Without piping:     mutate( dataset , newVar = value )
# Without piping:     mutate( males , year = 1980 )

# With piping:        a %>% mutate( b = c )
# With piping:        dataset %>% mutate( newVar = value )
# With piping:        males %>% mutate( year = 1980 )

# In essence, what is happening when using the %>% tool is that the ".data" parameter of
# the mutate(...) function is inherited from whatever is preceding the %>%.

# For simple modifications, this may feel like overkill.
males %>% mutate( year = 1980 )

# However, what makes piping useful is you can chain together multiple functions in sequence.
# Example:  dataset %>% function(...) %>% function(...) %>% function(...) %>% function(...)

# Example:  males %>% mutate( year = 1980 ) %>% select( school, exper, year, wage ) %>% filter( wage > 5)

# Example:
#           males %>%
#             mutate( year = 1980 ) %>%
#             select( school, exper, year, wage ) %>%
#             filter( wage > 5)

# Inline example
males %>% mutate( year = 1980 ) %>% select( school, exper, year, wage ) %>% filter( wage > 5)

# Same example as above, but starting small and building up.
# Step 0
males

# Step 1
males %>%
  mutate( year = 1980 )

# Step 2
males %>%
  mutate( year = 1980 ) %>%
  select( school, exper, year, wage )

# Step 3
males %>%
  mutate( year = 1980 ) %>%
  select( school, exper, year, wage ) %>%
  filter( wage > 5)


# Using pipes is extremely helpful when developing a pipeline or sequence of processing tasks
# that you need to be both readable and succinct.  Here's an example of using pipes to achieve
# five unique steps of data processing.

# 1 - drop all missing values
# 2 - create a calculated "school_avg" variable and position it after the "school" variable
# 3 - create a calculated "school_avg_centered" variable and position it after "school_avg"
# 4 - subset the data to specified columns
# 5 - subset the data to rows meeting a specific condition

males %>%
  drop_na( ) %>%
  mutate( school_avg = mean(school), .after = school ) %>%
  mutate( school_avg_centered = school - school_avg, .after = school_avg ) %>%
  select( school, school_avg, school_avg_centered, union, ethn, married, health, wage) %>%
  filter( union == "yes", married == "yes" )


# Even piped data needs to be assigned using "<-" to create or overwrite a data object.
males_piped <-
  males %>%
  drop_na( ) %>%
  mutate( school_avg = mean(school), .after = school ) %>%
  mutate( school_avg_centered = school - school_avg, .after = school_avg ) %>%
  select( school, school_avg, school_avg_centered, union, ethn, married, health, wage) %>%
  filter( union == "yes", married == "yes" )

# Inspect the data
males_piped



# Order matters!  The order in which you sequence piped functions consequently changes how
# your data is processed and what your outcomes are.
males_piped_2 <-
  males %>%
  drop_na( ) %>%
  filter( union == "yes", married == "yes" ) %>%
  mutate( school_avg = mean(school), .after = school ) %>%
  mutate( school_avg_centered = school - school_avg, .after = school_avg ) %>%
  select( school, school_avg, school_avg_centered, union, ethn, married, health, wage)

# Inspect the data
males_piped_2



##               ##
## PRACTICE TIME ##
##               ##

# Using the males dataset, create the males_pipePractice_1 dataset. Using pipes, filter by
# rows where wage is greater than 8. Then select the columns school, ethn, and wage.

# males_pipePractice_1 <-
#   males %>%
#   filter(??? > ???) %>%
#   select(??? , ??? , ???)

# Inspect the data
# males_pipePractice_1


# Using the males dataset, create the males_pipePractice_2 dataset. Using pipes, filter by
# rows where union is "yes" and married is "no".  Then select the columns union, married,
# ethn, and wage.

# males_pipePractice_2 <-
#   males ???
#   filter(??? == "???" , ??? == ???) ???
#   select( ??? , ??? , ???, ??? )

# Inspect the data
# males_pipePractice_2



####################
####################
##### PART - 5 #####
# GROUPING AND AGGREGATING

# Inspect the data
males

# Remove all incomplete observations (just to make this section a little easier)
males_complete <- males %>% drop_na()

# Inspect the data
males_complete

# Using piping, use the group_by(...) function and summarise(...) function
# to calculate the average of wage.

# Example:

# dataset %>%
#   group_by() %>%
#   summarise( newVar = function(existingVar) )

# males_complete %>%
#   group_by() %>%
#   summarise( avg_wage = mean(wage) )

males_complete %>%
  group_by() %>%
  summarise( avg_wage = mean(wage) )

# For this specific example, the base R mean(...) function is just as easy to use.
mean(males_complete$wage)


# However, including new variables in the group_by(...) function allows us to start
# gaining more granular perspectives on our data.  For example, what is the average
# wage for two subgroups; those who are in a union and those who are not?

males_complete %>%
  group_by(union) %>%
  summarise(avg_wage = mean(wage))


# We can expand the group_by() to collate observations by multiple variables at once
# (assuming we have sufficient quantities of data)
males_complete %>%
  group_by( union , ethn , married , health ) %>%
  summarise(avg_wage = mean(wage))


# We are not limited to using mean(...) in the summarise(...) function either. Within
# summarise(...) we can specify multiple aggregations and summary statistics. The examples
# below include:

# CONCEPT     		    LABEL   	=   FUNCTION/CALCULATION
# Average				      avg_wage		  mean(...)
# Count				        n				      n()
# Standard Deviation	stdev			    sd(...)
# Standard Error		  se 				    sd(wage)/sqrt(n())
# Minimum			        min 			    min(...)
# Maximum				      max 			    max(...)

# Average + Count included
males_complete %>%
  group_by( union , ethn , married , health ) %>%
  summarise(
    avg_wage = mean(wage),
    n = n()
  )

# All metrics described above included
males_complete %>%
  group_by( union , ethn , married , health ) %>%
  summarise(
    avg_wage = mean(wage),
    n = n(),
    stdev = sd(wage),
    se = sd(wage)/sqrt(n()),
    min = min(wage),
    max = max(wage)
  )

# Assign grouped and calculated table to a new object: males_group
males_group <-
  males_complete %>%
  group_by( union , ethn , married , health ) %>%
  summarise(
    avg_wage = mean(wage),
    n = n(),
    stdev = sd(wage),
    se = sd(wage)/sqrt(n()),
    min = min(wage),
    max = max(wage)
    )

# Inspect the data
males_group


# CROSSTABS AND CONTINGENCY TABLES!!!
# Note: This is only a very light introduction to tables in R

# Now that we have a grouped/aggregated set of data (males_group), we can start generating
# crosstabs using a few base R functions.

# First, the xtabs(...) feature is one of the friendlier functions for creating crosstabs
# once you already have data grouped and aggregated the way we do in males_group.

# Example: xtabs( metric    ~ var1+var2+var3      ,       data = dataset    )
# Example: xtabs( avg_wage  ~ union+ethn+married+health , data = males_group)

# Assign the xtabs(...) result to a new object called crosstab
crosstab <- xtabs(avg_wage~union+ethn+married+health, data=males_group)

# Insepct the output.  It is a bit dense and unhelpfully organized.
crosstab


# One helpful function for formatting xtabs(...) objects in a more helpful way
# is the ftable(...) function.
frequency_table <- ftable(crosstab)
frequency_table


# Do you remember the summary(...) function?????
# The summary(...) function can be used on a variety of different types of objects, datatypes,
# and models to produce interesting summaries and outputs.  When used with xtabs(...) objects,
# summary(...) will yield a chi-squared test of independence.
summary(crosstab)



##               ##
## PRACTICE TIME ##
##               ##

# (1) Create a "males_practice" object and assign it values based on the following tidyverse data pipe.
# (2) use the males dataset
# (3) filter observations where the value for "married" is "no"
# (4) select the "school", "union", and "ethn" columns
# (5) drop all observations with missing values
# (6) group by the "union" and "ethn" variables
# (7) summarise the groupings with three new variables:
#     --  "avg_years_school" for the average of "school"
#     --  "standard_deviation" for the standard deviation of "school"
#     --  "counts" for the number of samples/observation/rows associated with each groupping.

# males_practice <-
#   males %>%
#   ???( married == "no") %>%
#   select( ??? , ??? , ???) %>%
#   drop_na() %>%
#   group_by( ??? , ??? ) %>%
#   ???( avg_years_school = mean(???) , standard_deviation = sd(???) , counts = n() )



# Check your work, does males_practice contain what you expect?
males_practice

# Create the crosstab_practice object
crosstab_practice <- xtabs( avg_years_school~union+ethn , data = males_practice)

# View summary of the crosstab
summary(crosstab_practice)

# Create and few the flattended frequency table of the crosstab
ftable_practice <- ftable(crosstab_practice)
ftable_practice
