
data("precip")
# find a data point closest to the mean
closest_to_mean = function(x) { 
  mean = mean(x)
  x[which.min(abs(x-mean))] # no return keyword 
}

test = closest_to_mean(precip)
test
test = closest_to_mean(c(0,2.1,4))
test


boxplot(air[,'DAILY_AQI_VALUE'])

boxplot(DAILY_AQI_VALUE ~ COUNTY, data = air)

# suppose I want to have 2 boxplots. One for Sacramento County and one for everything else

air[,"sac"] = air[,'COUNTY'] == "Sacramento"
boxplot(DAILY_AQI_VALUE ~ sac, data = air, names = c('other', 'sac'))


# selecting rows by index 

air[1:10, c("sac", "COUNTY")]
table(air[, c("sac", "COUNTY")])

r = sample(length(letters))
r

letters[r]

d2  = air[order(air[,"DAILY_AQI_VALUE"]),]
plot(d2[,"DAILY_AQI_VALUE"],type="l")






