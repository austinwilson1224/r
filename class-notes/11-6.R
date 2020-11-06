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
