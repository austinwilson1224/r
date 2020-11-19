# load "tidyverse" plotting package
library(tidyverse)
library(ggplot2)
# load data frame enhancement package
library(tibble)
# make results reproducible
set.seed(42)
x <- 1000
# create the random distribution and convert to a tibble
distrib <- enframe(rchisq(x,3))
# crease the base plot object
p <- ggplot(distrib, aes(x = value))
# add command to produce a "faded" histogram and select the number of bins
# then overlay density curve (converted to common axis of count)
p + geom_histogram(fill="black", colour="black", alpha = 0.25, binwidth=0.5) + geom_density(aes(y=0.5*..count..), colour="black", adjust=4) 

