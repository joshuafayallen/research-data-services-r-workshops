######## DATA VISUALIZATION WORKSHOP ##########

# The content in this notebook was developed by Muhammet Emre Coskun and Jeremy Walker.
# All sample code and notes are provided under a Creative Commons ShareAlike license.

# Official Copyright Rules / Restrictions / Privileges
# Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)
# https://creativecommons.org/licenses/by-sa/4.0/

# Supplemental resources and tools for GGPLOT AND GRAPHICS:
# http://www.cookbook-r.com/Graphs/
# https://socviz.co/workgeoms.html
# https://r4ds.had.co.nz/data-visualisation.html
# http://sape.inf.usi.ch/quick-reference/ggplot2/colour
# https://www.r-graph-gallery.com/38-rcolorbrewers-palettes.html

# Information about the dataset used in this code script:
# The data contains spatial and table data for 177 countries around the World.
# The data comes with the tmap package. Check the following link:
# https://rdrr.io/cran/tmap/man/Shapes.html


# Start by installing necessary packages
install.packages(c("tidyverse", "ggmap", "ggthemes", "sp", "sf", "tmap",
                   "tmaptools", "RColorBrewer", "viridisLite", "rgdal",
                   "rgeos", "tigris", "RSocrata"))

# Load the required packages:
library(tidyverse) # for manipulating data
library(ggplot2)   # to have cool graphs
library(tmap)      # to draw maps (also includes the data we use below)
library(sf)        # to clear the geometry from world data
library(ggthemes)  # to have nice plot themes
library(RColorBrewer) # to adjust more color options

# IMPORT THE DATA:
# Get the World dataset provided by tmap package:
data(World)
world_data <- st_drop_geometry(World) # do not worry about this for now!
world_data <- na.omit(world_data)     # eliminate countries with missing data!

# Check structure of the World dataset:
str(world_data)

# Explore the world_data
head(world_data)
summary(world_data)




####################  PART - 1 BASICS  ####################
### GGPLOT2 - GRAPHS AND PLOTS.  START SMALL, BUILD UP!

# ggplot is by far the most popular general-purpose plotting library in the R development-community.
# It is immensely powerful and offers a lot of options and utility for both beginners and advanced users.

# Quoted from the ggplot cheatsheet:
# "ggplot2 is based on the grammar of graphics, the idea that you can build every graph from the same
# components: a data set, a coordinate system, and geoms-visual marks that represent data points."

# ggplot plots all build from the same structure and building blocks.

# First establishing the ggplot object and assigning a dataset
# ggplot( data = dataset )

# Second adding a geometry type (i.e. plot type such as "histogram" or "scatterplot")
# ggplot( data = dataset ) + geom_function( ..... )

# Third adding mapping information that connects the dataset with the type of plot
# ggplot( data = dataset, mapping = aes( x=... , y=..., ...)) + geom_function( )
#   or
# ggplot( data = dataset ) + geom_function( mapping = aes( x=... , y=..., ...) )

# Following from that basic pattern, you can continue to add layers, metadata, colors,
# and other information to an existing ggplot object.


# LET'S START WITH AN EXAMPLE

# Create the ggplot object by defining the core dataset
# Example:    plot_object <-  ggplot( data = dataset )
# Example:    world_plot  <-  ggplot( data = world_data )

# Note: while this will create the plot, we haven't defined enough parameters to actually visualize anything.
world_plot <- ggplot(data = world_data)
world_plot

# Next, you will define the "mapping" for the plot.  The "mapping = aes(...)" parameter effectively tells
# ggplot and R which columns/variables from the data you want to be associated with which components of
# the plot (x-axis, y-axis, color-coding, sizing, etc...)

# Example:    plot_object <-  ggplot( data = dataset  , mapping = aes( x = x_axis_data) )
# Example:    world_gdp_plot   <-  ggplot( data = world_data    , mapping = aes( x = gdp_cap_est ) )

# Note: this will create the plot and add markers to the mapped axes, but nothing else will be visualized yet.
world_gdp_plot   <-  ggplot( data = world_data, mapping = aes(x = gdp_cap_est ))
world_gdp_plot

# Lastly, adding the geom_function results in a visualized plot
world_gdp_plot <- ggplot(data = world_data, aes(x = gdp_cap_est)) + geom_histogram( )
world_gdp_plot


# RECAP - Putting it all together
# (1) world_gdp_plot <- ggplot(data = world_data )
# (2) world_gdp_plot <- ggplot(data = world_data, mapping = aes( x=gdp_cap_est))
# (3) world_gdp_plot <- ggplot(data = world_data, mapping = aes( x=gdp_cap_est)) + geom_histogram(  )


# Same as above, but with the code reformatted a bit to make it easier to read.
world_gdp_plot <-
  ggplot(data = world_data, aes(x = gdp_cap_est)) +
  geom_histogram()

world_gdp_plot


##               ##
## PRACTICE TIME ##
##               ##

# Create a histogram plot using the world_data dataset and the variable pop_est

# population_plot <-
#   ggplot(data = ???, mapping = aes( x = ??? ) ) +
#   geom_histogram(  )
#
# population_plot


# Create a histogram plot using the world_data dataset and the variable HPI (The Happy Planet Index)

# hpi_plot <-
#   ???(??? = ???, ??? = ???( ??? = ??? ) ) +
#   ???(  )
#
# hpi_plot




####################  PART - 2 AESTHETICS  ####################

# Aesthetics help us assign variables or values to various visual aspects of the graph.

# They are defined by aes() function assigned to 'mapping' parameter inside the ggplot() to affect the main plot,
# or inside geom layers to affect only the specific layer.

# Some commonly used aesthetics are: x, y, color, size, shape, fill, alpha, linetype, labels


# EXAMPLE:

# ggplot(data = world_data, mapping = aes(x=... , y=..., color=..., size=...)) +
#   geom_point()

# We do not have to write 'mapping =' explicitly, so the following code works fine:

# ggplot(data = world_data, aes(x=... , y=..., color=..., size=...)) +
#   geom_point()

# Different set of aesthetics are available depending on the type of geom selected.

# Some aesthetics work better with certain type of variables, such as size for continous variables,
# and color for discrete variables.

# Lets start by a simple SCATTER GRAPH example:

# A scatter graph of expected lifetime (y-axis) vs gdp per capita (x-axis):
ggplot(world_data, aes( x = gdp_cap_est, y = life_exp)) +
  geom_point()

# Note that we can omit x and y specification as the first and second arguments
#are automatically assigned to x and y.
# So, the following lines result in EXACTLY SAME output:
ggplot(world_data, aes(gdp_cap_est, life_exp)) +
  geom_point()


## Plotting 3 variables:
# We can also add a color aesthetic, in this case color represents 'continent' variable:
ggplot(world_data, aes(gdp_cap_est, life_exp, color = continent)) +
  geom_point()

# We can use shape aesthetic to obtain a similar plot, but color works better:
ggplot(world_data, aes(gdp_cap_est, life_exp, shape = continent)) +
  geom_point()

# But wait, there's more! Plotting 4 variables:
# Lets go back to using color aesthetic, and also add a size aesthetic to represent population:
ggplot(world_data, aes(gdp_cap_est, life_exp, color = continent, size = pop_est)) +
  geom_point()

# and set alpha level inside geom_point layer to set transparancy of points:
ggplot(world_data, aes(gdp_cap_est, life_exp, color = continent, size = pop_est)) +
  geom_point(alpha = 0.5)

# But wait, there's more! 5 variables! But this plot now looks messy:
ggplot(world_data, aes(gdp_cap_est, life_exp, color = continent, size = pop_est,
                       shape=income_grp)) +
  geom_point(alpha = 0.5)



## Aesthetics inside geom()
# Note that we can define aesthetics inside the geom function.
# See below example, which results in same as the plot with 4 variables above:
ggplot(world_data, aes(gdp_cap_est, life_exp)) +
  geom_point(aes(color = continent, size = pop_est), alpha = 0.5)

# On an important note, aesthetics or arguments set in the geom layers OVERRIDE the main aesthetics:
# Below, main aesthetics set color to continent and size to population estimates
ggplot(world_data, aes(gdp_cap_est, life_exp, color = continent, size = pop_est)) +
  # but geom layer sets color 'aesthetic' to economy and size 'argument' to 2
  geom_point(aes(color = economy), size = 2, alpha = 0.5)



##               ##
## PRACTICE TIME ##
##               ##

# Create a scatter plot using the world_data data set and
#plot the HPI (The Happy Planet Index) (y-axis) by gdp_cap_est (x-axis)

# ggplot(data = ???, mapping = aes( x = ???, y = ??? ) ) +
#   geom_?????(  )
#

# Now lets add a color aesthetic argument inside the geom function and assign it to income_grp

# ???(??? = ???, aes( x = ???, y = ???) ) +
#   ???( aes(color =  ???))
#

# Finally add a size aeshtetic inside geom and assign it to population estimate (pop_est)
# and also make the layer 40% transparant

# ???(??? = ???, aes( x = ???, y = ???) ) +
#   ???( ???(color =  ???, size = ??? ), alpha = ???)
#




####################  PART - 3 GEOMS, LAYERS  ####################

# Histogram and scatter plots are among the many geom layers we can use in our plots.
#
# Some of the most commonly used geom layers are the following:
#
# geom_point() -> scatter plots: continuous x, continuous y
# geom_smooth() -> smooth curve: continuous x, continuous y
# geom_hist() -> histograms: one variable continuous x
# geom_bar() -> bargraph (count): one discrete variable x
# geom_density() -> density plot: one variable continuous x
# geom_boxplot() -> boxplot: discrete x, continuous y
# geom_col() -> column plot (a barplot with y values): discrete x, continuous y
# geom_line() -> line graph: continuous x over time
# geom_text() -> text markers: labels with character or factor variables
# geom_abline() -> a preset line with intercept and slope
# geom_hline() -> a preset horizontal line with y intercept
# geom_vline() -> a preset vertical line with x intercept

# Please check ggplot2 Data Visualization cheat-sheet for many other examples.



## BAR GRAPH:
# a simple bar graph showing count of countries in each continent
ggplot(world_data, aes(continent)) +
  geom_bar()

# Adding a fill argument provides further distinction:
# COUNT of countries in each continent stacked BY income groups
ggplot(world_data, aes(continent, fill=income_grp)) +
  geom_bar()

# COUNT of countries in each continent BY income groups, shown side by side:
ggplot(world_data, aes(continent, fill=income_grp)) +
  geom_bar(position = 'dodge')  # more on the position argument in part 4!

# proportions of continents in income groups in each continent:
ggplot(world_data, aes(continent, fill=income_grp)) +
  geom_bar(position = 'fill')


## COLUMN GRAPH:
# Similar to a bar graph but instead of the count of elements it shows total
#values of y variable by the categories of discrete x variable:

# a column graph showing total population estimate by continents:
ggplot(world_data, aes(continent, pop_est)) +
  geom_col()

# a column graph: total population in each continent separated by economy groups:
ggplot(world_data, aes(continent, pop_est, fill = economy)) +
  geom_col()


## LINE GRAPH:
# Line graph is similar to a scatter graph but the points are combined with lines
# A line graph is usually useful when there is a time trend exist (i.e. temporal data).
# Otherwise, a line graph does not give better information than a simple scatter plot as in the case below.
# You are advised to search for line graphs with temporal data, which is not included in this workshop!

# A line graph showing relationship between life expectancy vs gdp per capita:
ggplot(world_data, aes(gdp_cap_est, life_exp)) +
  geom_line()


## AREA GRAPH:
# Area graph is similar to a line graph, with the area under the line filled with a fill aesthetic or color.
# An area graph plotting inequality against gdp per capita, with fill set to income groups:
ggplot(world_data, aes(gdp_cap_est, inequality)) +
  # an area plot
  geom_area(aes(fill = income_grp), alpha = 0.4)


## BOXPLOT:
# Recall that for a continuous variable a box plot shows the median value,
#the inter-quantile range (Q1-Q3) inside the box and extreme values outside it.

# Making a box plot of gdp per capita estimates (continuous y) by income groups (discrete x):
ggplot(world_data, aes(income_grp, gdp_cap_est )) +
  geom_boxplot()


##               ##
## PRACTICE TIME ##
##               ##

# Create a boxplot using the world_data dataset and
#plot the HPI (The Happy Planet Index) (y-axis) by continent (x-axis)

# ggplot(data = ???, aes( x = ???, y = ??? ) ) +
#   geom_?????(  )
#



###  ADDING MULTIPLE GEOM LAYERS

## Adding a median line and shaded area on an area plot:

# An area plot of inequality vs gdp per capita for all countries together:
# Start with a simple plot of inequality vs gdp_cap_est
gdp_ineq_plot <- ggplot(world_data, aes(gdp_cap_est, inequality))

gdp_ineq_plot +
  # area plot layer
  geom_area(fill = "#F4B066", alpha = 0.9)

# now lets add a horizontal line with median inequality and annotate it:
gdp_ineq_plot +
  geom_area(fill = "#F4B066", alpha = 0.9) +
  # horizontal line which passes through median of inequality
  geom_hline(yintercept=median(world_data$inequality), linetype="dotted") +
  # annotation for the line
  annotate("text", x = 70000, y = 0.22,
           label = "Median inequality", size = 3)

# next, add country labels:
gdp_ineq_plot +
  geom_area(fill = "#F4B066", alpha = 0.9) +
  geom_hline(yintercept=median(world_data$inequality), linetype="dotted") +
  annotate("text", x = 70000, y = 0.22,
           label = "Median inequality", size = 3) +
  #country labels with geom_text():
  geom_text(aes(label = name), check_overlap = TRUE, size = 3)

# lastly, we add color shades for each continent using another area layer:
gdp_ineq_plot +
  geom_area(fill = "#F4B066", alpha = 0.9) +
  geom_hline(yintercept=median(world_data$inequality), linetype="dotted") +
  annotate("text", x = 70000, y = 0.22,
           label = "Median inequality", size = 3) +
  geom_text(aes(label = name), check_overlap = TRUE, size = 3) +
  # geom_area layer for continents:
  geom_area(aes(x = gdp_cap_est, y=0.5, fill = continent), alpha = 0.1)



## Adding a smooth curve to a scatter plot:

# Lets check our previous scatter plot of life expectancy by gdp per capita
ggplot(world_data, aes(gdp_cap_est, life_exp)) +
  geom_point()

# Now lets add a smooth curve layer to this plot with geom_smooth():
ggplot(world_data, aes(gdp_cap_est, life_exp)) +
  geom_point() +
  geom_smooth()


# Smooth also takes the method argument which can define parametric models: lm, glm, rlm, gam
# The default estimation method in smooth layer is loess (check help for more info)
# Here we set the smoothing method to the linear method to get linear fits:
ggplot(world_data, aes(gdp_cap_est, life_exp)) +
  geom_point() +
  geom_smooth( method = lm )

# We can also add continent as a color aesthetic and add smooth curves with glm method for each group
#while setting transparency levels with alpha:
ggplot(world_data, aes(gdp_cap_est, life_exp, color = continent)) +
  geom_point(alpha=0.4) +
  geom_smooth(method = "glm")


# Note that we could obtain the same graph in separate steps by creating an object for the main plot base:
gdp_life_plotbase <- ggplot(world_data, aes(gdp_cap_est, life_exp, color = continent))

#add point geometry layer to the plot:
gdp_life_plotbase +
  geom_point(alpha=0.4)

# add linear smooth curves:
gdp_life_plotbase +
  geom_smooth(method = glm)

# both points and smooth curves:
gdp_life_plotbase +
  geom_smooth(method = glm) +
  geom_point(alpha=0.4)


# We can turn off confidence intervals in geom_smooth layer by setting se to FALSE.
# Here below is the same plot as the last one without the standard error ribbons (confidence intervals)
gdp_life_plotbase +
  geom_point(alpha=0.4) +
  geom_smooth(method = glm, se = FALSE)


## Multiple layers with varying aesthetics:

# Without a color grouping the smooth line is added for the whole data points:
ggplot(world_data, aes(gdp_cap_est, life_exp)) +
  geom_point() +
  geom_smooth( method = lm )

# We can set color inside the geom_point layer to continents, which does not affect the smooth layer:
ggplot(world_data, aes(gdp_cap_est, life_exp)) +
  geom_point(aes(color = continent)) +
  geom_smooth( method = lm )

# We can get additional smooth curves for each continent group by assigning color aesthetic in the smooth layer:
ggplot(world_data, aes(gdp_cap_est, life_exp)) +
  geom_point() +
  geom_smooth(aes(color = continent), method = glm )

# Lets color both points and add group smooths:
ggplot(world_data, aes(gdp_cap_est, life_exp)) +
  geom_point(aes(color = continent)) +
  geom_smooth(aes(color = continent), method = glm )

# Finally along with the group smooth lines we add a major smooth line for the whole data
# Here I turn off confidence intervals of group smooths for clarity
ggplot(world_data, aes(gdp_cap_est, life_exp)) +
  geom_point(aes(color = continent)) +
  geom_smooth(aes(color = continent), method = glm, se = FALSE) +
  geom_smooth(method = glm)


# A final note on setting aesthetics for multiple layers

# NOTICE THAT:
# When we include the color aesthetic in the main plot line it affects all the layers
ggplot(world_data, aes(gdp_cap_est, life_exp, color = continent, size = pop_est)) +
  geom_point(alpha=0.4) +
  geom_smooth(method = "glm", se = FALSE)

# in this case, setting aesthetics or arguments in each layer overrides the main aesthetics set in the base layer:
ggplot(world_data, aes(gdp_cap_est, life_exp, color = continent, size = pop_est)) +
  geom_point( color = "purple", size = 2, alpha=0.4) +  # notice that here color is an argument and not aesthetic
  geom_smooth(method = "glm", se = FALSE)

# and we can take advantage of that, for example, while adding a main smooth layer for the whole data:
ggplot(world_data, aes(gdp_cap_est, life_exp, color = continent, size = pop_est)) +
  geom_point(alpha=0.4) +
  geom_smooth(method = "glm", se = FALSE) +   # this smooth layer adds smooth lines for each continent.
  geom_smooth(color="cyan")                   # Whereas, this one has its own color argument, which overrides the
                                              # base color set to continents, resulting in one smooth curve for the whole data.



##               ##
## PRACTICE TIME ##
##               ##

# Create a scatter plot of inequality (y-axis) by gdp_cap_est (x-axis),
# (1) add a point layer where color aesthetic set to continent and size aesthetic set to pop_est
# (2) add a smooth layer with glm method where color set to continent without confidence intervals
# (3) add a second smooth layer where color argument (not aesthetic!) is set to "brown"

# ggplot(world_data, aes( ??? , ??? )) +
#   geom_point(aes(color = ??? , size = ???)) +
#   geom_smooth(aes(color = ???), method = ???, se = ???) +
#   geom_???(color = ???)

# Play with different parameters of this multilayered plot to make yourself comfortable with them.




####################  PART - 4 OPTIONS  ####################

### Position Options: Jitter and Dodge

# Sometimes data points in plots overlap, which reduces visibility.
# This usually happens when the x variable in a scatter graph (geom_point) is discrete or categorical.

# In the below graph some data points in income group categories are overlapping.
ggplot(world_data, aes(income_grp, gdp_cap_est)) +
  geom_point()

# We can set position argument in the geom_point layer to 'jitter' so that no data points overlap.
ggplot(world_data, aes(income_grp, gdp_cap_est)) +
  geom_point(position = "jitter")

# we can also do this directly by using geom_jitter function:
ggplot(world_data, aes(income_grp, gdp_cap_est)) +
  # geom_point(position = 'jitter')
  geom_jitter()

# if you think the default jitter is too much spread out,
# then you may assign a specific jittering distance:
ggplot(world_data, aes(income_grp, gdp_cap_est)) +
  geom_point(position = position_jitter(0.2))

# still not clear? Lets change the shape of points in the geom layer:
ggplot(world_data, aes(income_grp, gdp_cap_est)) +
  geom_point(position = position_jitter(0.2), shape=1)

# still not clear? Lets try another shape:
ggplot(world_data, aes(income_grp, gdp_cap_est)) +
  geom_point(position = position_jitter(0.2), shape=2)



### Text layer nudging:

# Now lets recall our scatter plot of life expectancy by gdp per capita, colored by continent:
ggplot(world_data, aes(gdp_cap_est, life_exp)) +
  geom_point()

# and add a text layer with country names as labels:
ggplot(world_data, aes(gdp_cap_est, life_exp)) +
  geom_point() +
  geom_text(aes(label = name))
# the resulting plot looks very messy. Country names are on the top of points and they overlap each other.
# How can we resolve this?

# First, we can nudge the text labels up by a certain number of y axis units, and right by x axis units:
ggplot(world_data, aes(gdp_cap_est, life_exp)) +
  geom_point() +
  geom_text(aes(label = name), nudge_y = 1, nudge_x = 2000)

# Lets also reduce text size:
ggplot(world_data, aes(gdp_cap_est, life_exp)) +
  geom_point() +
  geom_text(aes(label = name), size = 3, nudge_y = 1, nudge_x = 2000)

# and finally eliminate overlapping layers (Yes, we lose some information by doing that):
ggplot(world_data, aes(gdp_cap_est, life_exp)) +
  geom_point() +
  geom_text(aes(label = name), size = 3, nudge_y = 1, nudge_x = 2000, check_overlap = TRUE)



### Histograms options bins, binwidth, position:

# Inspect the options available for geom_function(...)
?geom_histogram

# Modify geom_histogram(...) to change the width of the bins used to visualize the data

# a histogram of gdp per capita with default settings (number of bins = 30):
ggplot(world_data, aes(gdp_cap_est)) +
  geom_histogram(alpha=0.4)

# We can set bins = NUMBER to set a fixed number of bins whose width is automatically calculated
ggplot(world_data, aes(gdp_cap_est)) +
  geom_histogram(alpha=0.4, bins = 45)

# Alternatively, we can set binwidths to change the distribution of elements into bins of fixed width.
# IMPORTANT: binwidth is directly related to your x-axis measure, so take a note of that!
# set gdp per capita binwidht to intervals of $2000:
ggplot(world_data, aes(gdp_cap_est)) +
  geom_histogram(alpha=0.4, binwidth = 2000)

# how about we want to add continent as a fill aesthetic:
ggplot(world_data, aes(gdp_cap_est, fill = continent)) +
  geom_histogram(alpha=0.4, binwidth = 2000)

# continent categories doesn't look good on the top of each other, lets draw them side by side using dodge position,
# and also readjust binwidth for clarity:
ggplot(world_data, aes(gdp_cap_est, fill = continent)) +
  geom_histogram(binwidth = 10000, position = 'dodge')



### Changing variable scales (scale transformation):

# Scales of individual variables can be transformed inside the ggplot without changing the original variable.

# Below is an example of logarithmic transformation.

# Revisit life expectancy vs gdp per capita scatter plot with smooth curve:
ggplot(world_data, aes(gdp_cap_est, life_exp)) +
  geom_point() +
  geom_smooth()

# Here we observe that there is an exponential relationship between gdp per capita and life expectancy.
# We can linearize this relationship by putting the gdp per capita x-axis in a logarithmic scale.
# All we need to do is simply apply log function to gdp_cap_est:
ggplot(world_data, aes(log(gdp_cap_est), life_exp)) +
  geom_point() +
  geom_smooth()

# Resulting plot shows a closer to linear relationship. (The smooth curve is not linear,
#because the default smooth function is loess. You can set smooth method to lm to have a linear fit.)



### Coordinate changes:

## Coord_flip():
# In some cases flipping x and y axes provide a better visualization of data.
# This is done by using coord_flip() function added like a layer to the plot.

# Check this example:
# We want to have box plot of gdp per capita within each economy group:
ggplot(world_data, aes(economy, gdp_cap_est)) +
  geom_boxplot()

# The box plots look fine, but economy group names in the x axis is unreadable.
# Lets have the same box plot with flipped axes:
ggplot(world_data, aes(economy, gdp_cap_est)) +
  geom_boxplot() +
  coord_flip()
# Better!


## Coord_polar():
# We can transform the coordinate system to polar coordinates to have interesting visuals.

# Here is the previous column graph we had, showing total population in continents:
ggplot(world_data, aes(continent, pop_est, fill = continent)) +
  geom_col()

# Now lets change it to polar coordinates:
ggplot(world_data, aes(continent, pop_est, fill = continent)) +
  geom_col() +
  coord_polar()

# A more colorful example:
ggplot(world_data, aes(continent, fill=income_grp)) +
  geom_bar() +
  coord_polar()




####################  PART - 5  FACETS  ####################

# What to do when a graph with multiple groups looks too complex and ambigious?
# An easy solution is to draw separate plots in a box.

# Check this scatter graph with smooth layers over continents we draw before:
continent_plots <-
  ggplot(world_data, aes(gdp_cap_est, life_exp, color = continent)) +
  geom_point(alpha=0.4) +
  geom_smooth(method = "glm")

continent_plots

# Although this graph is readable, is somewhat complex with overlapping parts.
# Lets draw a separate plot for each continent instead of one plot for all.
# We can do this by using facet_grid function layer.

# facet_grid is used when we have a small number of categories in our factor variable that we separate plots.
# Here we separate plots across columns:
continent_plots +
  facet_grid(cols = vars(continent))

# it might work better to separate plots across rows:
continent_plots +
  facet_grid(rows = vars(continent))

# facet_wrap can also be used, especially when we have many categories in a variable:
continent_plots +
  facet_wrap(vars(continent))

#  Even though this looks easier to see compared to the single plot with every continent,
# we still have room for improvement.

#  We observe that facets have the same axes measures, which is unnecessary as not all continents have
# data points for the same values over axes.

# We can free axis measures for each subplot in the facets using scales parameter:
continent_plots +
  facet_grid(cols = vars(continent), scales = "free")

continent_plots +
  facet_wrap(vars(continent), scales = "free")
# Good work!



##               ##
## PRACTICE TIME ##
##               ##

# Complete the following code to have a column graph of total population (pop_est) in each continent,
# where the fill is set to income_grp and position argument set to 'dodge':

#
# ggplot(world_data, aes( continent , ??? , fill = ??? )) +
#   geom_col( position = ??? )

# Now instead of having continents side by side in the same plot, have them in their own subplots using
# first facet_grid and then facet_wrap. Also set axis scales to free!

# Subplots with facet_grid in cols:
# ggplot(world_data, aes( ??? , ??? , fill = ??? )) +
#   geom_col( position = ??? ) +
#   facet_grid( ??? , scales = ??? )

# Subplots with facet_wrap:
# ggplot(world_data, aes( ??? , ??? , fill = ??? )) +
#   geom_col( position = ??? ) +
#   facet_wrap( ??? , scales = ??? )

# Which one do you like more?




####################  PART - 6 LABELS, COLORS AND STYLING ####################

# To add new labels, colors and information to the plot, it is as simply as adding a "+" and the desired
# ggplot function.

# Example:
# plot_object <-
#   ggplot(...) +
#   geom_histogram(...) +
#   stuff_function(...) +
#   more_things(...) +
#   new_labels(...)

# For example, the labs(...) function lets you modify the labels on a plot object. The example below explicitly
# labels the x-axis.
ggplot(data = world_data, mapping = aes(x=gdp_cap_est)) +
  geom_histogram(bins = 40) +
  labs( x = "GDP per capita" )


### LABELS & TITLES:

# Adding label and titles can be managed easily by using labs function:
#
# ggplot() + labs(x=,y=,title=)
#
# Check all label options:
?labs()

# We use the last facet wrap as an example plot:
continent_plots +
  facet_wrap(vars(continent), scales = "free") +
  labs( x = "GDP per capita" ) +
  labs( y = "Life Expectancy") +
  labs( title = "GDP per cap. vs Life expectancy by Continent")

# Alternatively, all of the labs(...) options can be consolidated into a single instance of the labs(...) function.
continent_plots +
  facet_wrap(vars(continent), scales = "free") +
  labs( x = "GDP per capita",
        y = "Life Expectancy",
        title = "GDP per cap. vs Life expectancy by Continent"
      )

# How can we change axis labels?
# Check the previous plot:
ggplot(world_data, aes(continent, pop_est)) +
  geom_col(aes(fill = continent)) +
  # First notice that I make x axis label disappear by entering empty string: (I also could set it to NULL)
  labs( x = "", y = "Estimated population", title = "Population by Continent")

# For the sake of example, say we want continent names in x-axis all in CAPS!
# We can only do this using scale_x_discrete function by setting x-axis labels:
ggplot(world_data, aes(continent, pop_est)) +
  geom_col(aes(fill = continent)) +
  labs( x = "", y = "Estimated population", title = "Population by Continent") +
  scale_x_discrete(labels = c("AFRICA","ASIA", "EUROPE", "NORTH AMERICA",
                              "OCEANIA", "SOUTH AMERICA"))


## theme() function

# Ggplot2 provides a lot of freedom in setting non-data aspects of your plots.
# If you want to go more advanced and fine tune visual aspects of your plot,
#then you may find theme() function useful.

# theme() function allows you to adjust details of the non-data components,
#including font and position of title and label changes we have done so far.
# But it requires mode coding. Check help menu for options:
?theme()

# theme function uses the element_ functions below:
element_text()
element_line()
element_rect()
element_blank()


# Example: use theme to remove legend, axis ticks and panel grid lines:
ggplot(world_data, aes(continent, pop_est)) +
  geom_col(aes(fill = continent)) +
  labs(x=NULL, y="Estimated population", title = "Population by Continent") +
  theme(
    legend.position = 'none',
    axis.ticks = element_blank(),
    panel.grid = element_blank(),
  )


# Another example with theme():
ggplot(world_data, aes(continent, pop_est)) +
  geom_col(aes(fill = continent)) +
  ggtitle("Population by Continent") +
  xlab(NULL) +
  ylab("Population") +
  theme(
    # title font and position
    plot.title = element_text(size = 20, hjust = 0.5),
    # legend position
    legend.position = c(0.9,0.7),
    # remove x grid
    panel.grid.major.x=element_blank(),
    # add background color
    plot.background = element_rect(fill = "lightcyan1")
  )



### COLOR OPTIONS: Colors, colors, more colors

# Changing colors in the plot is a useful way to make some information more explicit and presentation more clear.

# check all available colors:
colors()

# Many plot types allow color and fill aesthetics to be used to display aspects of data.

# color argument and palette parameter are used to specify color options.

# For more info on how to customize colors in ggplot, I highly recommend starting with this blog post:
# http://www.sthda.com/english/wiki/ggplot2-colors-how-to-change-colors-automatically-and-manually


# The documentation for geom_histogram and other similar functions shows that you can use the "color" parameter
# to define the outline of each of the bins, and the "fill" parameter to change the shading color for each bin.
ggplot(data = world_data, mapping = aes(x=gdp_cap_est)) +
  geom_histogram(bins = 40, color = "black" , fill = "orange" ) +
  labs( x = "GDP per capita" )

# Same as above, but with new color choices...
ggplot(data = world_data, mapping = aes(x=gdp_cap_est)) +
  geom_histogram(bins = 40, color = "blue" , fill = "pink" ) +
  labs( x = "GDP per capita" )

# You may also assign colors by using  the "#RRGGBB" RGB colour strings:
ggplot(data = world_data, mapping = aes(x=gdp_cap_est)) +
  geom_histogram(bins = 40, color = "#377EB8" , fill = "#E41A1C" ) +
  labs( x = "GDP per capita" )

# You can use colors to have detailed touches on your plot.
# Lets highlight just one country in the life expectancy by GDP plot with a specific color:
ggplot(world_data, aes(gdp_cap_est, life_exp)) +
  geom_point(color=ifelse(world_data$name=="Costa Rica","red","black")) +
  geom_text(aes(label = name),
            color=ifelse(world_data$name=="Costa Rica","red","black"),
            size = 3, nudge_y = 1, nudge_x = 2000, check_overlap = TRUE)


## scale_fill_manual, scale_color_manual functions and palette argument:

# scale_color_manual can be used to change colors of a layer with color aesthetic.
# Similarly, scale_fill_manual can be used to change fill colors of a layer with fill aesthetic.


# lets change the default colors of the last Population by Continent plot:
ggplot(world_data, aes(continent, pop_est)) +
  geom_col(aes(fill = continent)) +
  labs( x = "", y = "Estimated population", title = "Population by Continent") +
  scale_fill_manual(values = c("red", "yellow", "pink", "green", "blue", "purple"))


# palette argument help us assign multiple colors easily.
# Manually defined color palette:
personal_palette <- c("red", "green", "orange", "cyan", "black", "pink")

ggplot(world_data, aes(continent, pop_est)) +
  geom_col(aes(fill = continent)) +
  labs( x = "", y = "Estimated population", title = "Population by Continent") +
  scale_fill_manual(values = personal_palette)


# Possible color blind palette:
cbPalette <- c("#999999", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")

ggplot(world_data, aes(continent, pop_est)) +
  geom_col(aes(fill = continent)) +
  labs( x = "", y = "Estimated population", title = "Population by Continent") +
  scale_fill_manual(values = cbPalette)

# or you can use a preset scale_fill:
ggplot(world_data, aes(continent, pop_est)) +
  geom_col(aes(fill = continent)) +
  labs( x = "", y = "Estimated population", title = "Population by Continent") +
  scale_fill_colorblind( )

ggplot(world_data, aes(continent, pop_est)) +
  geom_col(aes(fill = continent)) +
  labs( x = "", y = "Estimated population", title = "Population by Continent") +
  scale_fill_tableau( )


# There are many ways to control the size, colors, and shape parameters.  Honestly, there are too many
# ways to control these parameters than what is feasible to teach in a workshop! The example below is just
# one method of controlling these options by adding the scale_color_brewer(...) and scale_size(...) functions
# to the ggplot object.
ggplot(world_data, aes(continent, pop_est)) +
  geom_col(aes(fill = continent)) +
  labs( x = "", y = "Estimated population", title = "Population by Continent") +
  scale_fill_brewer(palette="Accent") +
  scale_size( range = c(1,3) )

ggplot(world_data, aes(continent, pop_est)) +
  geom_col(aes(fill = continent)) +
  labs( x = "", y = "Estimated population", title = "Population by Continent") +
  scale_fill_brewer(palette="Dark2") +
  scale_size( range = c(1,3) )

# Check out other palette options: https://www.r-graph-gallery.com/38-rcolorbrewers-palettes.html
display.brewer.all()



### GGTHEMES:

# ggthemes package provides a set of ready-to-use theme formats for our plots.
# we already installed and loaded the ggthemes package in the beginning.
# If you have not, then use:
# install.packages('ggthemes')
# library(ggthemes)

# Check some of the available ggthemes here: https://yutannihilation.github.io/allYourFigureAreBelongToUs/ggthemes/

# Some examples:

# The default view:
continent_wraps <- continent_plots +
  facet_wrap(vars(continent), scales = "free") +
  labs( x = "GDP per capita",
        y = "Life Expectancy",
        title = "GDP per cap. vs Life expectancy by Continent"
  )
continent_wraps

# Classic Theme:
continent_wraps +
  theme_classic()

# Minimalist:
continent_wraps +
  theme_minimal()

# the WSJ or FT theme:
continent_wraps +
  theme_wsj()

# economist theme:
continent_wraps +
  theme_economist()



##               ##
## PRACTICE TIME ##
##               ##

# Create a box plot of well_being (y) vs gdp_cap_est (x) variable, along with continents set to color aesthetics
# and include the following parameters and labels:
# (1) Label the x-axis: "GDP per capita"
# (2) Label the y-axis: "Well Being Index"
# (3) Add title: "GDP per capita vs Well Being by Continent"
# (4) Fill color for the boxes: "lightcyan"
# (5) Change coloring of continent boxes using scale_color_brewer with palette: "Dark2"

#
# ggplot(data = ???, mapping = aes(x=???, y=???)) +
#   geom_boxplot( aes(color = "???") , fill = "???") +
#   labs( ??? = "???" ) +
#   labs( ??? = "???" ) +
#   labs( ??? = "???" ) +
#   scale_color_brewer((palette = ))
#



##################### SAVING YOUR PLOTS ##################

# LASTLY we want to save out plot, which we can do by using ggsave() function of ggplot package.

# Recall continent wraps graph
continent_wraps

# Add minimalist theme to it and save:
continent_wraps +
  theme_minimal()

# Its usually a good idea to set working directory before saving:
# change the file path for your PC:
setwd("C:/Users/your_PC_user_name_goes_here/Downloads")

# the default option is to save the last plot, so we only specify filename:
ggsave("Minimalist_continent_wrap.png")

# or we can also specify the plot to be saved:
ggsave("Continent_wraps.png", plot = continent_wraps)



### CONGRATULATIONS! YOU REACHED THE END OF THIS CODE SCRIPT!
### NOW YOU MAY CONTINUE TO MAPPING IN R SCRIPT!
