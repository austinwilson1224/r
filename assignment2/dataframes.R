# 1. Load the data with air = read.csv("http://webpages.csus.edu/fitzgerald/files/stat128/fall20/ad_viz_plotval_data.csv")
air = read.csv("http://webpages.csus.edu/fitzgerald/files/stat128/fall20/ad_viz_plotval_data.csv")
View(air)

# 2. Pick a site from the column "Site.Name" in the data that you find personally interesting, 
#    and select the rows in the data frame that correspond to that site. 
#    Use this subset for the remainder of the analysis. Mention why this site interests you.

#    I picked Davis because I live there. 
unique(air$Site.Name)

data = air[which(air$Site.Name == "Davis-UCD Campus"),]
data = air[air$Site.Name == 'Davis-UCD Campus',]
View(data)


# 3. Plot a line plot of the columns "Daily.Mean.PM2.5.Concentration" as a function of "Date". 
#    Start one month before the fire and go to the end of the data set. Comment on what the graph shows.
with(data, plot(as.Date(Date, "%m/%d/%y"), Daily.Mean.PM2.5.Concentration, xlab="Date", ylab="Conecntration"))
# plot(as.Date(data$Date, "%m/%d/%y"), data$Daily.Mean.PM2.5.Concentration, )


# 4. Create a comparative boxplot of "Daily.Mean.PM2.5.Concentration" in the month before the fire and the month after the fire. 
#    Comment on what the boxplots show.
# Hint: create a new column that indicates if the observation happened before or after the fire.
# Use your work above to implement the function below, and verify that it works for n = 100 and n = 50.
before = data[1883:1909,c("Daily.Mean.PM2.5.Concentration", "Date")]
after = data[1909:1935,c("Daily.Mean.PM2.5.Concentration", "Date")]
boxplot(split(before$Daily.Mean.PM2.5.Concentration, after$Daily.Mean.PM2.5.Concentration))

