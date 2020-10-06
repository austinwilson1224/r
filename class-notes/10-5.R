airquality
airquality$Ozone

a = airquality
head(a)
a[is.na(a$Ozone)]
is.na(a)

View(a)
a$Ozone[is.na(a$Ozone)]




x = c(NA,1,2,3)

x[1] == 1
x == NA
is.na(x)

s = c("","abc","hello")
s
