## be sure you have done
## install.packages("gapminder")
library(gapminder)
library(tidyverse)
gapminder = gapminder


# Alternatively Use read_csv

ggplot(gapminder) +
  geom_point(mapping = aes(x = gdpPercap, y = lifeExp))



## Change the Dot Plot to a boxplot


ggplot(gapminer) +
  geom_point(mapping = aes(x = continent, y = lifeExp))


## Make a histogram of lifExp


## Make a Density plot of lifeExp


## Facet this line plot by continent and make it personalized
## add different colors


ggplot(gapminder, aes(x = year, y = gdpPercap, group = country, color = continent)) +
  geom_line()



