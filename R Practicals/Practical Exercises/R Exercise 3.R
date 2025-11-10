# 1
sum(is.na(airquality))

# 2
airquality$Ozone[is.na(airquality$Ozone)] <- median(airquality$Ozone, na.rm = TRUE)
airquality

# 3
mtcars_dup <- rbind(mtcars, mtcars)
mtcars_dup <- unique(mtcars_dup)
mtcars_dup

# 4
rownames(mtcars) <- toupper(rownames(mtcars))
mtcars

# 5
iris$Species <- as.numeric(factor(iris$Species))
iris
