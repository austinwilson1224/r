
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

air[,"Date"] = as.Date(air[,"Date"],format="")
data[,"test"] = data[,"Date"] >= as.Date("2020-07-01") & data[,"Date"] <= as.Date("2020-07-31")



temp = data[,c("Date","Daily.Mean.PM2.5.Concentration")]

dim(temp)[1]

dim(temp)[1] - 100
dim(temp)[1]
temp2 = temp[dim(temp)[1]:dim(temp)[1]-100,]
dim(temp2)
(dim(temp)[1]-100):dim(temp)[1]





plot_pm2.5 = function(d, n = 100)
{
  d = d[order(d$Date, decreasing = FALSE),] # to ensure data is sorted
  n_most_recent = tail(x = d, n = n)
  n_most_recent2 = d[dim(d)[1]-100:dim(d),]
  print(n_most_recent2)
  
  plot(Daily.Mean.PM2.5.Concentration ~ Date, data = n_most_recent, type="l")
}

