setdiff(B, A)
example(setdiff)
x <- c(sort(sample(1:20, 9)), NA)
y <- c(sort(sample(3:23, 7)), NA)
x
y
identical(x,y)
union(x, y)
setdiff(x, y)
setdiff(y, x)
setequal(x, y)
