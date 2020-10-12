



# import functions
source("https://raw.githubusercontent.com/clarkfitzg/stat128/master/roulette.R")


# designing functions 


#' @param dt data frame with only one distinct value 
#' @return data  frame with just mean and std dev 

summary_at_time = function(dt) { # dt is data at a particular time 
  data.frame(time = unique(dt$time), mean = mean(dt$winnings), sd = sqrt(var(dt$winnings)))
}



#' @param dt data frame with only one distinct value 
#' @return data  frame with just mean and std dev 

summary_at_time2 = function(dt, col = "winnings") { # dt is data at a particular time 
  col_of_interest = df[,col]
  data.frame(time = unique(col_of_interest), mean = mean(col_of_interest), sd = sqrt(var(col_of_interest)))
}