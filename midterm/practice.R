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


table(mtcars[, c("cyl", "gear")])

table(mtcars[(mtcars$cyl == 6) & (mtcars$gear %in% c(3,4)),])


find1 = function(x){
  x = 1
}

test = find1(1232132)
test

x = 1:5
seq_along(x, by = 2)

seq_along(along.with=1:5, by = 2)

seq_along(x)


