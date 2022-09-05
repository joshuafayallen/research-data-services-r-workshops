gapminder = gapminder::gapminder


readr::write_csv(gapminder, here::here("files", "Workshop-3", "gapminder.csv"))


data("starwars", package = "dplyr")


readr::write_csv(starwars, here::here("files", "Workshop-2", "starwars.csv"))



data("penguins", package = "palmerpenguins")


readr::write_csv(penguins, here::here("files", "Workshop-2", "penguins.csv"))