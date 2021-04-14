# install.packages ( "tidyverse" ) 
  library ( tidyverse )

save <-
read.csv ( 'regression_example.csv' , 
            header = T ,
            stringsAsFactors = T )
              
as_tibble ( save )

vars <- function(x) {return ( sum( (x-mean(x))^2) / (length(x)-1) )}
sds <- function(x) {return ( sqrt( vars(x) ) )}
cvs <- function(x) {return ( sds(x) / mean(x) )}
cov2 <- function(x,y) {return ( sum((x-mean(x))*(y-mean(y))) / (length(x)-1) )}
cor2 <- function(x,y) {return ( cov(x,y) / (sds(x)*sds(y)) )}

paste ( 'variance x:' , varx <- vars ( x <- save [[ 1 ]] ) )
paste ( 'variance x:' , vary <- vars ( y <- save [[ 2 ]] ) )

paste ( 'standard deviation x:' , sdx <- sds ( x ) )
paste ( 'standard deviation y:' , sdy <- sds ( y ) )

paste ( 'coeficent of variation x:' , cvx  <- cvs ( x ) )
paste ( 'coeficent of variation y:' , cvy  <- cvs ( y ) )

paste ( 'covariance  of xy:' , cov <- cov2 ( x , y ) )
paste ( 'correlation of xy:' , cor <- cor2 ( x , y ) )

x~y
paste ( 'x~y' ,
        'like space from x and y' ,
        'for independent variables' )

summary ( val_lm <- lm ( y~x ) )
