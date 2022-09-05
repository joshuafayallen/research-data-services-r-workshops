
# install.packages(tidyverse)
library(tidyverse)

## Load the dataset in using read_csv()

penguins <-  
  
starwars <- 


#----Filter Portion----

#   Using the sample code from the last slide filter out the NA values. Hint use !
  
#  Using either the star wars or penguins data use `%in%` to get a set of home worlds or islands

#   Subset the penguin data where body mass is less than `4202` and not on the Dream Island.

#----Mutate Portion----

# Write code to: 


#Add a column in your dataset that is TRUE if a penguin is an Adelie penguin


#Add a column in the `starwars` dataset that says Naboo or Tatooine, and Not Naboo or Tatooine if it is not
 

#Add a column in your dataset for logged body_mass_g (hint: use `log()`)


#----Summarise and Group_by portion----



#   Calculate the minimum, maximum, and median `body_mass_g` for each species of penguin

#What happens if you remove `group_by()`?

# Calculate the number of distinct penguin species per island


