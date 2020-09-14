data("precip")

mean = mean(precip)

sort(precip)

difference = abs(precip - mean)



which.min(difference)

sort(abs(precip - mean))[1]
