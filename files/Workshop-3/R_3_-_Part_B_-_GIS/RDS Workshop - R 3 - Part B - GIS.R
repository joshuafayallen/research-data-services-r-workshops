##########  GEO-SPATIAL VISUALIZATION IN R  #################

# The content in this notebook was developed by Muhammet Emre Coskun and Jeremy Walker.
# All sample code and notes are provided under a Creative Commons ShareAlike license.

# Official Copyright Rules / Restrictions / Privileges
# Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)
# https://creativecommons.org/licenses/by-sa/4.0/

# Supplemental resources and tools for MAPPING, GIS AND SPATIAL DATA IN R:
# https://bookdown.org/robinlovelace/geocompr/adv-map.html
# https://r-spatial.org/r/2018/10/25/ggplot2-sf.html
# https://socviz.co/maps.html
# https://journal.r-project.org/archive/2016-2/walker.pdf


# Install necessary packages
install.packages(c("tidyverse", "ggmap", "sp", "sf", "tmap", 
                   "tmaptools", "RColorBrewer", "viridisLite", 
                   "rgdal", "rgeos", "tigris", "RSocrata"))

# Load the necessary packages we installed:
# tidyverse package is a collection of packages used for managing data frames (includes ggplot2!):
library(tidyverse)
# ggmap package is provided by Google, and used to import map layers
# see Google's Terms of Service: https://cloud.google.com/maps-platform/terms/.
library(ggmap)
# sp package provide classes for storing different types of spatial data and related methods
library(sp)
# sf provides simplified spatial data tools
library(sf)
# tmap package help us create nice maps
library(tmap)
# tmaptools package provides many tools to work with maps 
library(tmaptools)
# RColorBrewer is used for generating color scales
library(RColorBrewer)
# viridisLite is used to create color palettes
library(viridisLite)
# rgdal is used to import shapefiles and more
library(rgdal)
library(rgeos)
# tigris is used to pull Census spatial data
library(tigris)
# tidycensus is used to download geographic and tabular Census data
# library(tidycensus)
# RSocrata package is used to retrieve CDC's COVID data from Socrata:
library(RSocrata)


# Set working directory to Downloads/R3
# ********** MAKE SURE YOU UPDATE THIS COMMAND WITH YOUR OWN DIRECTORY PATH ***********
setwd("C:/Users/Emre/Downloads/R3")

# Check working directory to make sure it is set correctly:
getwd()

# Check all files in the current working directory:
dir()




############### PART I - WORKING WITH GENERAL SPATIAL DATA ######################

# We start with a ready to use World map to cover some basics

# Import World map data which comes with tmap package:
data(World)
# World is an sf object:
class(World)
summary(World)

# a simple plot() call shows maps of first 16 columns in the World map data
plot(World)

# we can obtain a simple map of life expectancy using plot() function:
plot(World["life_exp"])


# These simple plots are nice. But, what if we want to add more layers, change projection and layout?
# Lets delve into map dynamics! We will use tm_shape from the tmap package:



### Layers, layers, layers:

# tmap package is similar to ggplot2 but for maps.
tm_shape(World) # similar to ggplot(data)
                # without a layer it does not work
# but similar to ggplot tm_shape can be saved as an object
world_object <- tm_shape(World) 

# Lets add a borders layer:
# tmap::tm_shape function works with layers:
tm_shape(World) + 
  tm_borders()

# using the object we saved:
world_object + 
  tm_borders(col = "green")

# add a fill layer in purple color with 50% transparancy:
tm_shape(World) + 
  tm_fill(col = "purple", alpha = 0.5)

# both borders and fill layers together:
tm_shape(World) + 
  tm_borders(col = "white") +
  tm_fill(col = "purple", alpha = 0.5)

# Title and margins:
# add a layout layer with title and margins set:
tm_shape(World) + 
  tm_borders(col = "white") +
  tm_fill(col = "purple", alpha = 0.5) +
  tm_layout(title = "A Simple Map of the World", inner.margins = c(0.01, 0.01, 0.1, 0.01))



### Projection systems:

# Projections help us map the elliptic surface of the world on a flat surface

# We can check current projection system of a spatial object by using st_crs() call on a sf object,
# or proj4string() call on sp object (more on that later!)

# Current projection of World map object is 'World Geodetic System 1984 (WGS 1984)':
st_crs(World)

# There are so many coordinate systems and your choice will depend on the location and purpose of your map.

# Projections can be referred in R with various way: PROJ.4 strings, EPSG codes or  CRS objects.

# proj4 string examples:
# PROJ.4 strings are the primary output from many of the spatial data R packages (e.g. raster, rgdal).

# We can assign a new projection to our map by using projection argument inside the tm_shape function:

# Winkel-Tripel (used by the Natural Georgraphic) projection:
tm_shape(World, projection="+proj=robin") + 
  tm_polygons() +
  tm_layout("Winkel-Tripel projection, adapted as default by the National Geographic Society for world maps.",
            inner.margins=c(0,0,.1,0), title.size=.8)

# Eckart IV:
tm_shape(World, projection="+proj=eck4") +
  tm_polygons() + 
  tm_layout("Eckhart IV projection. Recommended in statistical maps for its equal-area property.",
            inner.margins=c(0,0,.1,0), title.size=.8)

# proj4 strings allow us to specify not only projection but also zone, datum, units, ellipsoid etc:
tm_shape(World, projection = "+proj=laea +lat_0=52 +lon_0=10 +x_0=4321000 +y_0=3210000 +ellps=GRS80 +units=m +no_defs ") + 
  tm_polygons() + 
  tm_layout("the ETRS89 Lambert Azimuthal Equal-Area projection", inner.margins=c(0,0,.02,0), title.size=.8)


# European Petroleum Survey Group (EPSG) Coordinate Systems Worldwide:

# EPSG Coordinate systems assign codes to projections to standardize usage.
# Check the following links to look up EPSG codes of specific coordinate systems you work with:
# https://epsg.io/
# https://spatialreference.org/ref/epsg/
# 
# We can refer to the same projection system in the last example by its EPSG code 3035:
tm_shape(World, projection = 3035) + 
  tm_polygons() + 
  tm_layout("the ETRS89 Lambert Azimuthal Equal-Area projection (code 3035)", inner.margins=c(0,0,.02,0), title.size=.8)


# Highlight Australia and Greenland as "gold" and other countries as "gray75"
World$highlighted <- ifelse(World$iso_a3 %in% c("GRL", "AUS"), "gold", "gray75")

# How about we try 'Web Mercator' projection:
tm_shape(World, projection=3857, ylim=c(.1, 1), relative = TRUE) + 
  tm_polygons("highlighted") + 
  tm_layout("Web Mercator projection. Although widely used, it is discouraged for
statistical purposes. In reality, Australia is 3 times larger than Greenland!",
            inner.margins=c(0,0,.1,0), title.size=.6) +
  tm_credits("Retrieved from tm_shape help file.")



### Arrange maps: Map plot facets

# We can use tmap_arrange to see these maps with different projections side by side:
# Save four of above maps with varying projections: 
tm1 <- tm_shape(World) + tm_polygons() + 
  tm_layout("Default projection: WGS'84")

tm2 <- tm_shape(World, projection=3035) + tm_polygons() + 
  tm_layout("the ETRS89 Lambert Azimuthal Equal-Area ")

tm3 <- tm_shape(World, projection=3857) + tm_polygons() + 
  tm_layout("Web Mercator")

tm4 <- tm_shape(World, projection="+proj=robin") + tm_polygons() + 
  tm_layout("Winkel-Tripel")

# Plot them side by side:
tmap_arrange(tm1, tm2, tm3, tm4)



### Zoom in:

# We can zoom into a specific region in a map by setting xlim and ylim arguments in tm_shape:
# In the current coordinate system of World map data we have x are longitudes and y are latitudes.

# Zoom into USA:
tm_shape(World, xlim = c(-172, -55), ylim=c(18, 73)) + 
  tm_polygons()



### Groups of layers:

# We can have several tm_shape maps and have them layered on the top of each other

#Extract USA from World data:
USA <- World[World$name == "United States",]

# import 'rivers' spatial data which contains 141 major rivers in North America :
data(rivers)

# Start with World map zoomed into North America:
tm_shape(World, xlim = c(-175, -50), ylim=c(14, 75)) + 
  tm_polygons() 

# Now draw USA map on it with red color fill:
tm_shape(World, xlim = c(-175, -50), ylim=c(14, 75)) + 
  tm_polygons() +
  tm_shape(USA) +
  tm_fill("red")

# and add rivers with cyan color lines:
tm_shape(World, xlim = c(-175, -50), ylim=c(14, 75)) + 
  tm_polygons() +
  tm_shape(USA) +
  tm_fill("red") +
  tm_shape(rivers) +
  tm_lines("lightcyan1") 

# set background color and margins with layout command:
tm_shape(World, xlim = c(-175, -50), ylim=c(14, 75)) + 
  tm_polygons() +
  tm_shape(USA) +
  tm_fill("red") +
  tm_shape(rivers) +
  tm_lines("lightcyan1") +
  tm_layout(bg.color="lightcyan1", 
            inner.margins=c(0,0,.02,0), 
            legend.show = FALSE)
 


### Choropleth Maps:

# A choropleth map assign colors to map areas according to a variable selected:

# recall that we did an example with plot before:
plot(World["life_exp"]) # a simple plot of life expectancy around the world

# we can do a similar choropleth map using tmap package:
tm_shape(World) + 
  tm_borders() +
  tm_fill(col = "life_exp")

# a second example: map of inequality (Gini index): 
tm_shape(World) + 
  tm_borders() +
  tm_fill(col = "inequality")

# This is nice. However, we may express our message better by choosing tones
# of red to represent inequality, which is done by setting a color 'palette' 
# attribute inside fill:
tm_shape(World) + 
  tm_borders() +
  tm_fill(col = "inequality", palette = "Reds") #Much better!

# another useful layer function is tm_bubbles()
# lets add population bubbles layer on the top of inequality coropleth map:
tm_shape(World) + 
  tm_borders() +
  tm_fill(col = "inequality", palette = "Reds") + 
  tm_bubbles(size = "pop_est", col = "purple")



### Colors: now lets add some more colors to our world

## Color palettes
# Lets check some available color palettes:
library(RColorBrewer)
display.brewer.all()    #Zoom to the plot!

# Check that the first group of palettes are sequential, which are better for representing increasing measures;
# The middle group are qualitative palettes, which are best for values without a specific order;
# The bottom group are divergent palettes, which are best for values diverging around a mean value.

# Seems like "YlOrRd" palette is a good fit for inequality map:
tm_shape(World) + 
  tm_borders() +
  tm_fill(col = "inequality", palette = "YlOrRd")



##               ##
## PRACTICE TIME ##
##               ##

# Plot a coropleth map of life expectancy (life_exp) using "Blues" palette:
#
# tm_shape(World) + 
#   tm_borders() +
#   tm_fill(col = ..., palette = ...)
#


# We can create other color palettes using other packages.
# here we use viridisLite package: already loaded in the beginning
# library(viridisLite)
vir <- viridis(9)
mag <- magma(9)

# World inequality map with vir palette created above:
tm_shape(World) + 
  tm_borders() +
  tm_fill(col = "inequality", palette = vir) 
# Do you think this is useful?

# How about mag palette:
tm_shape(World) + 
  tm_borders() +
  tm_fill(col = "inequality", palette = mag) 
# still not that good!

# the mag palette but reverse the order:
tm_shape(World) + 
  tm_borders() +
  tm_fill(col = "inequality", palette = rev(mag)) # better!



### Color scales & break values:

# tmap uses a discrete set of colors in mapping (unlike ggplot2 which uses a continuous color gradient)

# lets map out population estimates around the world:
tm_shape(World) + 
  tm_borders() +
  tm_fill(col = "pop_est")
# This map does not say much, because the default value breaks are divided in equal intervals and 
#population of most of countries fell between 0 to 200 million.

# We can have a more meaningful map by using quantile value breaks:
tm_shape(World) + 
  tm_borders() +
  tm_fill(col = "pop_est", style = "quantile")

# equal scales is the default option:
tm_shape(World) + 
  tm_borders() +
  tm_fill(col = "pop_est", style = "equal")

# jenks is another option which optimizes the differences between categories (so far best):
tm_shape(World) + 
  tm_borders() +
  tm_fill(col = "pop_est", style = "jenks")

# how about we Use 7 "jenks" breaks instead of the default 5:
tm_shape(World) + 
  tm_borders() +
  tm_fill(col = "pop_est", n = 7, style = "jenks")

# or we can manually set fixed cut values:
tm_shape(World) + 
  tm_borders() +
  tm_fill(col = "pop_est", style = "fixed", breaks = c(0, 5000000, 1e7, 3e7, 5e7, 1e8, 2e8, 5e8, 1e11))

# but the legend is not clear, we need to fix value labels:
tm_shape(World) + 
  tm_borders() +
  tm_fill(col = "pop_est", 
          style = "fixed",
          breaks = c(0, 5000000, 1e7, 3e7, 5e7, 1e8, 2e8, 5e8, 1e11),
          # note that we set legend labels inside tm_fill function:
          labels = c("0 to 5 mil","5 mil to 10 mil","10 mil to 30 mil","30 mil to 50 mil","50 mil to 100 mil","100 mil to 200 mil","200 mil to 500 mil","above 500 mil")
          )

# lets also make the legend more visible by moving it and adding a background color to it:
tm_shape(World) + 
  tm_borders() +
  tm_fill(col = "pop_est", 
          style = "fixed",
          breaks = c(0, 5000000, 1e7, 3e7, 5e7, 1e8, 2e8, 5e8, 1e11),
          title = "Population estm.", 
          labels = c("0 to 5 mil","5 mil to 10 mil","10 mil to 30 mil","30 mil to 50 mil","50 mil to 100 mil","100 mil to 200 mil","200 mil to 500 mil","above 500 mil")
          ) +
  tm_legend(position = c(0.05, 0.2), bg.color = "lightyellow", 
            #Lets also modify legend title color and text color:
            title.color = "black", text.color = "black")
            #NOTICE that "Titles for the legend items are specified at the layer functions"!



### Other map elements to finalize your map:

# continuing from the last example we have:
# assign it to an object
population_map <- tm_shape(World) + 
  tm_borders() +
  tm_fill(col = "pop_est", 
          style = "fixed", 
          breaks = c(0, 5000000, 1e7, 3e7, 5e7, 1e8, 2e8, 5e8, 1e11), 
          title = "Population estm.", 
          labels = c("0 to 5 mil","5 mil to 10 mil","10 mil to 30 mil","30 mil to 50 mil","50 mil to 100 mil","100 mil to 200 mil","200 mil to 500 mil","above 500 mil")
          ) +
  tm_legend(position = c(0.05, 0.2), 
            bg.color = "lightyellow", 
            title.color = "black", 
            text.color = "black"
            )


# using tm_layout add a title and set inner margins:
population_map +
  tm_layout(title = "Population of Countries",
            title.position = c("center","TOP"),
            title.color = "Black",
            inner.margins = c(0,0,0.1,0),
            bg.color = "lightcyan"
            )

# add a compass and scale bar:
population_map +
  tm_layout(title = "Population of Countries", 
            title.position = c("center","TOP"), 
            title.color = "Black",
            inner.margins = c(0,0,0.1,0), 
            bg.color = "lightcyan"
            ) +
  tm_compass(type = "8star", position = c("left", "top")) +
  tm_scale_bar(breaks = c(0, 1000, 2000), text.color = "black")
  

# Styles: we can add a built-in style to our map
# tmap package provides some ready to use themes for our maps.
# some available styles are: 
# "white", "gray", "natural", "cobalt", "col_blind", "albatross", "beaver", "bw", "classic", "watercolor" 

# Here I use watercolor style:
population_map +
  tm_layout(title = "Population of Countries", 
            title.position = c("center","TOP"),
            title.color = "Black",
            inner.margins = c(0,0,0.1,0),
            bg.color = "lightcyan"
            ) +
  tm_compass(type = "8star", position = c("left", "top")) +
  tm_scale_bar(breaks = c(0, 1000, 2000), text.color = "black") +
  tmap_style("watercolor")



### Save and Export:
# Final step of a map production is to save and export it to an image file:
pop_map_final <- population_map +
  tm_layout(title = "Population of Countries",
            title.position = c("center","TOP"),
            title.color = "Black",
            inner.margins = c(0,0,0.1,0),
            bg.color = "lightcyan"
            ) +
  tm_compass(type = "8star", position = c("left", "top")) +
  tm_scale_bar(breaks = c(0, 1000, 2000), text.color = "black") +
  tmap_style("watercolor")

# save with tmap_save function:
tmap_save(pop_map_final, "Population_map.png")




###################### PART II - TIGRIS AND CENSUS DATA ######################

# This section requires 'tigris' and 'tidycensus' packages, which we already installed and loaded in the beginning of this script.
# install.packages("tigris")
# install.packages("tidycensus")
# library(tigris, tidycensus)

# Tigris package is used to download and use TIGER/Line shapefiles from the United States Census Bureau.
# These shapefiles include all statistical measurement areas in the US, such as states, counties, zip codes, MSAs etc.

# Example: Fulton County Census tracts
# Call tracts(): lets import census tract geospatial data for the Fulton Country:
fulton_tracts <- tracts(state = "GA", county = "Fulton", cb = TRUE)

# Note that by default the spafiles imported by tigris are 'sf' dataframes.
class(fulton_tracts)
# We can also set class option inside tigris call to 'sp' to get the output as a spatial data object.
fulton_tracts_sp <- tracts(state = "GA", county = "Fulton", cb = TRUE, class = "sp")
class(fulton_tracts_sp)

# Call summary() on fulton_tracts
summary(fulton_tracts)

# Inspect the data:
head(fulton_tracts)

# Plot fulton_tracts:
tm_shape(fulton_tracts) +
  tm_polygons(col = "lightskyblue1") +
  tm_compass(position = c(0.05,0.8))


# We use tigris package's states function to import states shapefile:
US_states <- tigris::states(cb = TRUE)
summary(US_states)
head(US_states)
class(US_states)

# Plot States' names from the US_states shapefile 
plot(US_states["NAME"]) #  We observe that the US_states shapefile covers the 50 states along with 
                        # other US territories across the world, which is why it looks off.


# To have a focused view on the mainland US we can set a bbox (boundary box) in our map using tmap:
tm_shape(US_states, bbox = tmaptools::bb(xlim=c(-124.76, -66.95), ylim=c(24.52, 49.39))) +
  tm_fill(col = "blue") +
  tm_borders(col="white")


## Instead of zooming into a specific region we can filter only contiguous states from the US_states data:

#check included states and islands:
st_drop_geometry(US_states)[c("NAME","STUSPS")]

## Focus only on contiguous US states, while separating Alaska:
non_contiguous <- c("VI", "HI", "MP", "PR", "AK", "GU", "AS")

contiguous_states <- US_states[!(US_states[["STUSPS"]] %in% non_contiguous), ]

tm_shape(contiguous_states) +
  tm_borders(col="white") +
  tm_fill(col = "red")



### Downloading COVID-19 State level data from CDC website using API:

# install RSocrata if you have not already done so:
#library("RSocrata")

# Read Covid data from CDC wesite using Socrata:
covid_states_df <- read.socrata("https://data.cdc.gov/resource/9mfq-cb36.json")

# Check summary stats of Covid data:
colnames(covid_states_df)
summary(covid_states_df)
head(covid_states_df)

# Filter columns and change number columns' types into numeric:
covid_states_df <- covid_states_df %>% 
  select("submission_date", "state", "tot_cases", "tot_death") %>%
  mutate(tot_cases = as.numeric(tot_cases),
         tot_death = as.numeric(tot_death)
         )

# Check the last submission dates of data:
tail(sort(covid_states_df$submission_date))

# Assign the most recent date to an object:
last_submission <- tail(sort(covid_states_df$submission_date))[1]

# Get data for the last date available:
covid_states_recent <- covid_states_df[covid_states_df$submission_date == last_submission , ]

# Summary and first rows of recent date:
summary(covid_states_recent)
head(covid_states_recent)


## Merge states shapefile with covid data:
head(US_states) # STUSPS column has State codes we will use to merge

# merged data
merged_states_covid <- merge(US_states, covid_states_recent, by.x = "STUSPS", by.y = "state")

# explore merged data
summary(merged_states_covid)



## Lets plot Covid Total case map of States:
tm_shape(merged_states_covid) +
  tm_fill("tot_cases", palette = "YlOrRd", style = "quantile")

# again remote islands distort the focus of our map, so lets remove them:
tm_shape(merged_states_covid[!(merged_states_covid[["STUSPS"]] %in% non_contiguous), ]) +
  tm_fill("tot_cases", palette = "YlOrRd", style = "quantile", n = 7) +
  tm_borders(col = "white") 

# add additional details and map elements to finalize our total case map:
tm_shape(merged_states_covid[!(merged_states_covid[["STUSPS"]] %in% non_contiguous), ]) +
  tm_borders(col = "white") +
  tm_fill("tot_cases", palette = "YlOrRd", style = "quantile", n = 7) +
  #add title and margins in layout:
  tm_layout(title = "Covid-19 Total Cases in the United States, July 2021", inner.margins = c(0.05,0,0.08,0),
            title.position = c("center","top")) +
  #add label with State Codes:
  tm_text("STUSPS", col = "black", size = 0.8, fontface = 2) +
  tm_credits("Data source: COVID-19 Data Tracker by CDC, as of July 8th 2021")

# Save this total case map as an object:
covid_totalcase_map <- tm_shape(merged_states_covid[!(merged_states_covid[["STUSPS"]] %in% non_contiguous), ]) +
  tm_borders(col = "white") +
  tm_fill("tot_cases", palette = "YlOrRd", style = "quantile", n = 7) +
  #add title and margins in layout:
  tm_layout(title = "Covid-19 Total Cases in the United States, July 2021", inner.margins = c(0.05,0,0.08,0),
            title.position = c("center","top")) +
  #add label with State Codes:
  tm_text("STUSPS", col = "black", size = 0.8, fontface = 2) +
  tm_credits("Data source: COVID-19 Data Tracker by CDC, as of July 8th 2021")

# Lets save this map:
tmap_save(covid_totalcase_map ,"US_Covid_totalcase_map.png")




###################### PART III - READING IN SPATIAL DATA FROM EXTERNAL FILES ######################

# Set working directory to the folder where you have put workshop files:
# Here I set it to R3 folder in my downloads folder, 
#!# YOU NEED TO CHANGE THIS ACCORDING TO YOUR COMPUTER:

setwd("C:/Users/Emre/Downloads/R3")


## Reading in a shape file
# rgdal library has readOGR() function that reads in vector formats
library(rgdal)

# the format for readOGR(): sp_object1 <- readORG("directory name", "file name without extension")
# the output of readOGR() is always an sp object

# Use dir() to find directory name:
dir()

# Call dir() with the folder name 'states' to see shapefile files:
# this command should show 5 state shapefile files!
dir("states")

# Read in shapefile with readOGR():
?readOGR

# Inside the readOGR function the first argument (dsn) is the folder name where the shapefile is,
#and the second argument (layer) is the name of the shapefile without the extension.
States <- readOGR(dsn = "states", layer = "States_shapefile")

# summary() of States:
summary(States)

# Class of the readOGR output object is 'sp' (spatial dataframe):
class(States)

# Check the current coordinate and projection system of States (also shown in summary):
proj4string(States) #it is WGS 1984

#or we can access same info by checking the coordinate slot of sp object using @
States@proj4string

# Plot States (notice no remote islands in this shapefile)
plot(States)


## Read Covid-19 data downloaded from CDC website as a csv file:
covid_states <- read.csv("United_States_COVID-19_Cases_and_Deaths_by_State.csv")

#check data rows
head(covid_states)

#check head rows of States spatial data
head(States)

#check State_codes in States sp
head(States$State_Code)

# check that all state codes in covid_sates and States data match:
all(covid_states$Row.Labels %in% States$State_Code)
all(States$State_Code %in% covid_states$Row.Labels)

# merge covid data with States shapefile
states_covid_merged <- merge(States, covid_states, by.x = "State_Code", by.y = "Row.Labels")

view(states_covid_merged)
summary(states_covid_merged)

# see first rows of table data in the states_covid_merged dataframe:
head(states_covid_merged@data)

# Check first rows of State code and case rate (per 100000) columns:
head(states_covid_merged@data[c("State_Code","caserates")])


# A simple choropleth map with color mapped to case rates:
tm_shape(states_covid_merged) +
  tm_fill("caserates")

# Use Quantile style with 7 categories for the fill:
tm_shape(states_covid_merged) +
  tm_fill(col = "caserates", n = 7, style = "quantile", palette = "Reds") +
  # Add borders of the states layer, tm_borders()
  tm_borders() +
  # Add State codes with a tm_text() layer
  tm_text(text="State_Code", size = 0.5)  


# Finalize Case rate map and assign to an object:
covid_caserate_map <- tm_shape(states_covid_merged) +
  tm_fill(col = "caserates", n = 7, style = "quantile", palette = "Reds") +
  # Add borders of the states layer, tm_borders()
  tm_borders(col = "grey40", lwd=1) +
  # Add a tm_text() layer
  tm_text(text="State_Code", size = 0.5) +
  tm_layout(title = "COVID-19 Case Rates per 100,000 in the US", title.position = c("center","top"),
            inner.margins = c(0,0,0.1,0), legend.position = c(0.1,0.2)) +
  # Add tm_credits()
  tm_credits("Source: CDC Covid Data Project, \n accessed in March, 2021 via cdc.org", position = c("right","bottom"))

# Save our map
tmap_save(covid_caserate_map, filename="US_covid_caserate.png")

# We can also set the image size (may need to rescale text sizes and positions):
tmap_save(covid_caserate_map, filename="US_covid_caserate_large.png", width=12, height=9)


### Lets put our total case and case rate map creations together side by side:
tmap_arrange(covid_totalcase_map, covid_caserate_map)

# tmap_arrange does not return an object, so we cannot use tmap_save to save the output.
# Instead, we can use classic png function to save what we see in the plot area:

# save it using png function:
png(file = "Arranged_covid_maps.png", width = 900, height = 600)
tmap_arrange(covid_totalcase_map, covid_caserate_map)
dev.off()

###                T H E    E N D              ###
###   CONGRATULATIONS! YOU REACHED THE END OF THE R3 CODE SCRIPT! ###
