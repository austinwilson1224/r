
# use cases for R

# load data
data(cars)
data(iris)


# eda
View(cars)
View(iris)

head(cars)
head(iris)

summary(cars)

# unique values of categorical variable 
unique(iris$Species)


# vizualization 
plot(cars$speed, cars$dist)
boxplot(cars$speed,  cars$dist)



# data analysis
cor(cars$speed, cars$dist)
# positive high correlation -- make a linear model 


cars_lm = lm(cars$dist ~  cars$speed)


summary(cars_lm)




