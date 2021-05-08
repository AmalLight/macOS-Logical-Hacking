library ( e1071     )
library ( WriteXLS  )
library ( tidyverse )

data ( iris )

sub  ( "Se" , "Ab" , names( iris ) ) # Substrings -> replaceAll

gsub ( "Se" , "Ab" , names( iris ) ) # Substrings -> replaceAll

class ( iris )


# SCIENTIST

paste ( 'mean     : ' , mean     ( iris $ Sepal.Length ) [ 1 ] )
paste ( 'sd       : ' , sd       ( iris $ Sepal.Length ) [ 1 ] )
paste ( 'var      : ' , var      ( iris $ Sepal.Length ) [ 1 ] )
paste ( 'min      : ' , min      ( iris $ Sepal.Length ) [ 1 ] )
paste ( 'max      : ' , max      ( iris $ Sepal.Length ) [ 1 ] )
paste ( 'median   : ' , median   ( iris $ Sepal.Length ) [ 1 ] )
paste ( 'range    : ' , range    ( iris $ Sepal.Length ) [ 1 ] )
print ( 'quantile : '                                          )
quantile                         ( iris $ Sepal.Length )
print ( 'summary  : '                                          )
summary                          ( iris $ Sepal.Length )

# select columns iris [ 1:4 ]

sapply  ( iris [ 1:4 ] , mean, na.rm = TRUE )
summary ( iris )

print ( 'Correlation' )
cor ( iris [ , 1:4 ]  )
print ( 'Covariante'  )
cov ( iris [ , 1:4 ]  )

#f,,,cov2,,,cov2 <- function(x,y) {return ( sum((x-mean(x))*(y-mean(y))) / (length(x)-1) )},,,,,,,,,darkblue,,,
#f,,,cov2,,,,,,Covariance from list_x list_y,,,,,,,,,
#f,,,cor2,,,cor2 <- function(x,y) {return ( cov(x,y) / (sds(x)*sds(y)) )},,,,,,,,,darkblue,,,
#f,,,cor2,,,,,,Correlation of Covariance from list_x list_y,,,,,,,,,

corre <- cor ( iris [ , 1:4 ] )
covar <- cov ( iris [ , 1:4 ] )

print ( 'Rules' )
covar > corre

paste ( 'mean setosa : '     , mean ( iris $ Petal.Width [ iris $ Species == "setosa"     ] ) )
paste ( 'mean versicolor : ' , mean ( iris $ Petal.Width [ iris $ Species == "versicolor" ] ) )

t.test ( iris $ Petal.Width [ iris $ Species == "setosa"     ] )
t.test ( iris $ Petal.Width [ iris $ Species == "versicolor" ] )

t.test ( iris $ Petal.Width [ iris $ Species == "setosa"     ] ,
         iris $ Petal.Width [ iris $ Species == "versicolor" ] ) # conf.level = ?

# ? t.test less (<) greater (>) two.sided" (+-alpha(/2))

cor.test ( iris $ Sepal.Length , iris $ Sepal.Width )

# 49 of 442
