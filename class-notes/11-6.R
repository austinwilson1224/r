# Simulate data
n = 200
d = data.frame(x = runif(n))
d$y = 10 * d$x + 2 + rnorm(n)
# Test / train split
test_index = sample(n, size = round(n/2))
dtrain = d[test_index, ]
dtest = d[-test_index, ]
fit = lm(y ~ x, data = dtrain)


dtrain


predictions = predict(fit,dtrain)
predictions


mse = function(model, test_data) {
  predictions = predict(model,test_data)
  error = predictions - test_data$y
  squared = error ** 2
  mean = mean(squared)
  mean
}

mse(fit, dtest)




# rpart stuff
library(rpart)
n = 100
x = seq(0,3, length.out=n)
y = rep(2,n)
x
y
length(x)
length(y)
y[x<1] = 1
y
y[2<x] = 3
y
noise = rnorm(n, sd=.2)
noise
y = y + noise
d = data.frame(x,y)
plot(x,y)


fit1 = rpart(y ~ x, data = d)
plot(x,y)
lines(x,predict(fit1))




n = 101
x = seq(n)
y = x 
fit = rpart(y ~ x, minsplit = 51)
plot(x,y)
lines(x,predict(fit))
