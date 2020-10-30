View(mtcars)


cars = split(x = mtcars$mpg, f = mtcars$cyl)
# View(cars)


mean1 = sapply(cars, FUN = mean)
mean1
# View(mean1)


vector = sapply(split(mtcars$mpg, mtcars$cyl), mean, simplify = "array")
list = lapply(split(mtcars$mpg, mtcars$cyl), mean)
class(vector)
class(list)


test = data.frame(x = c(1,2,3,4,5))
test$trash = c("austin","john","wilson","is","cool")
test
