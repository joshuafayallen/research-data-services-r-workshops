#-------






getwd()## The working directory where all the materials for the workshops live



## setwd("your/working/directory/here") ## sets the working directory on mac
## setwd("your\working\directory\here") ## sets the working directory on windows

## 
##

## library(Package)
## library(I)
## library(JustInstalled)

## ----basic-math, echo = TRUE-----------------------------------------------------
2+2 ## addition
4-2
600*100 ##multiplication
100/10 ##division
10*10/(3^4*2)-2 ## Pemdas 
log(100)
sqrt(100)



## ----echo = TRUE-----------------------------------------------------------------
100 %/% 60 # How many whole hours in 100 minutes?
100 %% 60 # How many minutes are left over?


## ----echo = TRUE-----------------------------------------------------------------
a = matrix(c(1,3,5,7), ncol=2, nrow=2)

b = matrix(c(2,4,6,8), ncol=2, nrow=2)

 c_mat <- matrix(c(1,2,4,7), ncol = 3, nrow =2)

a %*% b # Matrix multiplication

t(c_mat) # transpose a matrix



## ----echo = TRUE-----------------------------------------------------------------
1>2 
1<2
1 == 2
1 < 2 | 3 > 4 ## only one test needs to true to return true
1 < 2 & 3>4 ## both tests must be true to return true



## ----unexpected-results, echo = TRUE---------------------------------------------
1 > 0.5 & 2


## ----echo = TRUE-----------------------------------------------------------------
1 > 0.5 & 1 > 2


## ----echo = TRUE-----------------------------------------------------------------
4 %in% 1:10
4 %in% 5:10


## ----echo = FALSE----------------------------------------------------------------
old_width = options(width = 80)

lsf.str("package:base") %>%  grep("^is.", ., value = TRUE)


## ----echo = TRUE-----------------------------------------------------------------
f = cbind(a,b) ## this will just create a matrix 
class(f)## lets us check the class of something 
g = as.data.frame(f) ## converts to a different class
str(g) ## shows some info about the structure of the object
typeof(g) ## shows how r is storing the object object


## ----echo = TRUE-----------------------------------------------------------------
a <- 2 + 2

a * 2



## ----echo = TRUE-----------------------------------------------------------------
 a^2 -> b


## ----echo = TRUE-----------------------------------------------------------------
b = b * 2

d = b/3


## ----echo = TRUE-----------------------------------------------------------------

e = data.frame(x = 1:22,
               y = 20:41)


## ----error = TRUE, echo = TRUE---------------------------------------------------
mean(y)


## ----echo=FALSE, error=TRUE------------------------------------------------------
mean(y)


## ----echo = TRUE-----------------------------------------------------------------
mean(e$y)


#


 penguins[1,1]



penguins[1,1:2]




## ----echo = TRUE-----------------------------------------------------------------
my_list = list(a = 1:4, b = "Hello World", c = data.frame(x = 1:3, y = 4:6))



## ----echo = TRUE-----------------------------------------------------------------
my_list[[1]][2] ## get the first item in the list and the second element of that item
my_list[[2]]
my_list[[3]][1]


 penguins[,-1]


 penguins[,-(1:4)]




penguins[,-(1:4)] |> 
  head(6) |> 
  knitr::kable(format = "html")


 
penguins[,-c(2,3,5,8)]


penguins[penguins["sex"] == "female", c("species", "sex")]






my_list$a

my_list$b

my_list$c




my_list$c[2] ## these are just returning the same thing 
my_list$c$y


 penguins[penguins$species == "Gentoo", c("species", "island", "bill_length_mm")]





summary(penguins)




mean(penguins$bill_depth_mm)





?mean






table(penguins$species)




table(penguins$sex)

anyNA(penguins$sex)



tapply(penguins$species,penguins$island, table)




tapply(penguins$bill_depth_mm, penguins$species, mean, na.rm = TRUE)


 



plot(penguins$bill_length_mm, penguins$body_mass_g,
     xlab = "Bill Length(mm)",
     ylab = "Body Mass(g)")






hist(penguins$bill_length_mm,
 xlim = c(30, 60))

