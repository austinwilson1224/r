# 1. Load the data with air = read.csv("http://webpages.csus.edu/fitzgerald/files/stat128/fall20/ad_viz_plotval_data.csv")
air = read.csv("http://webpages.csus.edu/fitzgerald/files/stat128/fall20/ad_viz_plotval_data.csv")
table(air)
View(air)

# 2. Pick a site from the column "Site.Name" in the data that you find personally interesting, 
#    and select the rows in the data frame that correspond to that site. 
#    Use this subset for the remainder of the analysis. Mention why this site interests you.

#    I picked Davis because I live there. 
unique(air$Site.Name)

# data = air[which(air$Site.Name == "Davis-UCD Campus"),]
data = air[air$Site.Name == 'Davis-UCD Campus',c("Date", "Daily.Mean.PM2.5.Concentration")]
data$Date = as.Date(x = data$Date, format = "%m/%d/%Y")
View(data)


# 3. Plot a line plot of the columns "Daily.Mean.PM2.5.Concentration" as a function of "Date". 
#    Start one month before the fire and go to the end of the data set. Comment on what the graph shows.
# with(data, plot(as.Date(Date, "%m/%d/%y"), Daily.Mean.PM2.5.Concentration, xlab="Date", ylab="Conecntration", type = "l"))
# plot(as.Date(data$Date, "%m/%d/%y"), data$Daily.Mean.PM2.5.Concentration, )
plot(Daily.Mean.PM2.5.Concentration~Date, type = "l", data = data)


# 4. Create a comparative boxplot of "Daily.Mean.PM2.5.Concentration" in the month before the fire and the month after the fire. 
#    Comment on what the boxplots show.
#    before and after august 15
# Hint: create a new column that indicates if the observation happened before or after the fire.
# Use your work above to implement the function below, and verify that it works for n = 100 and n = 50.
before_boolean_mask = data[,"Date"] < "2020-08-15" & data[,"Date"] > "2020-07-15"
after_boolean_mask = data[,"Date"] >= "2020-08-15"

dim(data)


before = data[before_boolean_mask,]
after = data[after_boolean_mask,]
 
dim(before)[1]
dim(after)[1]

# dim(data)[1] == dim(before)[1] + dim(after)[1]
# View(data)
View(before)
View(after)





# before = data[1883:1909,c("Daily.Mean.PM2.5.Concentration", "Date")]
# after = data[1909:1935,c("Daily.Mean.PM2.5.Concentration", "Date")]
boxplot(before$Daily.Mean.PM2.5.Concentration, after$Daily.Mean.PM2.5.Concentration)













# JACKASS CREW! 
air = read.csv("http://webpages.csus.edu/fitzgerald/files/stat128/fall20/ad_viz_plotval_data.csv")


# 1
air2 = air[air$Site.Name == "Sloughhouse",]


# 2
date = air2[,"Date"]
date_2 = as.Date(date, "%m/%d/%Y")



# logical vector 
date_at = as.Date(air2[,"Date"],"%m/%d/%Y") > as.Date("2020-06-30")

air3 = air2[date_at,]


plot(x = as.Date(air3[,"Date"],"%m/%d/%Y"), y = air3[,"Daily.Mean.PM2.5.Concentration"], type="l")



# 3 
air3[,"before_fire"] = as.Date(air3[,"Date"], "%m/%d/%Y") < as.Date("2020-08-15") 

boxplot(air3[,"Daily.Mean.PM2.5.Concentration"] ~ air3[,"before_fire"])



# 4

plot_pm2.5 = function(d, n = 100) {

  # TODO: Make sure data is in order by date column
  d[,"Date"] = as.Date(d[,"Date"], "%m/%d/%Y")
  # to ensure data is sorted
  # d = d[order(d$Date, decreasing = FALSE),] 
  dn = tail(d, n)
  pm2_n = dn[, "Daily.Mean.PM2.5.Concentration"]
  date_n = dn[, "Date"]
  plot(date_n, pm2_n, type = "l", xlab = "Date", ylab = "Daily Mean PM2 Concentration")
  
}






plot_pm2.5(d = air, n = 50)

















