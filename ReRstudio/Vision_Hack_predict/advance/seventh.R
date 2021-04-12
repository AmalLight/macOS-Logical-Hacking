# install.packages ( "tidyverse" )
# install.packages ( "e1071" )
# install.packages ( "psych" )
# install.packages ( "pastecs" ) 
  library ( pastecs )
  library ( psych )
  library ( tidyverse )
  library( e1071 )

saved <- read.csv (
    "independent-samples.csv" ,
    header = T ,
)

newData <-
saved %>%
    gather ( Engineering , Management ,
             key = 'course' ,
             value = 'grades' ,
             na.rm = T )
newData

t.test ( grades~course , data=newData , mu=-4 )

x <- newData %>%
    filter ( course == 'Engineering' ) %>%
    select ( grades )
x <- x [[ 1 ]]

y <- newData %>%
    filter ( course == 'Management' ) %>%
    select ( grades )
y <- y [[ 1 ]]

paste ( 'my mean in x:' , mx <-  mean ( x ) )
paste ( 'my mean in y:' , my <-  mean ( y ) )
paste ( 'my size in x:' , lx <- length( x ) )
paste ( 'my size in y:' , ly <- length( y ) )

vars <- function(x) {return (  sum( (x-mean(x))^2) / (length(x)-1) )}
sds  <- function(x) {return ( sqrt(    vars(x)) )}

different <- function(x,y,mu) {
mx <-   mean ( x )
my <-   mean ( y )
lx <- length ( x )
ly <- length ( y )
return ( (mx-my-mu) / 
sqrt( sds(x)^2/lx + sds(y)^2/ly )
)}

different ( x , y , -4 )