# install.packages ( "tidyverse" )
# install.packages( "e1071" ) 
  library ( tidyverse )
  library( e1071 )

covxy <- function(x,y) {return ( sum((x-mean(x))*(y-mean(y))) / (length(x)-1) )}
corxy <- function(x,y) {return ( cov(x,y) / (sd(x)*sd(y)) )}

saved <- as_tibble (
    read.table (
        "landdata-states.csv" ,
        sep = "," , header = T ,
        stringsAsFactors = T ,
        dec = "."
    )
)

# saved
covxy ( saved $ Structure.Cost , saved $ Land.Value )
corxy ( saved $ Structure.Cost , saved $ Land.Value )

# ----------------------------------------------------

saved1 <- as_tibble (
    read.csv (
        "practical_product.csv" ,
        header = T ,
        stringsAsFactors = T
    )
)

saved2 <- as_tibble (
    read.table (
        "practical_customer.csv" ,
        sep = "," , header = T ,
        stringsAsFactors = T ,
        dec = "."
    )
)

colnames ( saved1 )
print ( '----------------------------------------' )
colnames ( saved2 )

print ( '----------------------------------------' )

paste ( 'levels : ' , levels ( saved1 ) )
print ( '----------------------------------------' )
paste ( 'levels : ' , levels ( saved2 ) )

print ( '----------------------------------------' )

typeof ( saved2 $ Customer.ID )
typeof ( saved2 $ Mortgage )
typeof ( saved2 $ Y )

print ( '----------------------------------------' )

colnames ( saved1 ) <- ( c (
    'id' , 'building' , 'year' , 'month' , 'type' ,
    'property' , 'area' , 'price' , 'status'
    )
)

selected <-
saved1 %>%
    filter ( type == 'Apartment' ,
             price >= 0 ) %>%
    select ( type , price , area )
    
summary ( selected [ , 2 ] )

modex <- function(x) {return ( sort(unique(x))[ which.max( table(x) ) ] )}

paste ( 'mode : ' , modex ( selected $ price ) )

paste ( 'result : positive skewed , is it correct ?' )

varx <- function(x) {return (sum((x-mean(x))^2) / (length(x)-1))}
sdx <- function(x) {return ( sqrt( varx(x) ) )}
skewnessx <- function(x) {
return ( sum( (x-mean(x))^3 ) / ( length(x) * sd(x)^3 ) )}

var1 <- varx ( selected $ price )
var1

var2 <- var ( selected $ price )
var2

sd1 <- sdx ( selected $ price )
sd1

sd2 <- sd ( selected $ price )
sd2

skew1 <- skewnessx ( selected $ price )
skew1

skew2 <- skewness ( selected $ price )
skew2

for_cor <- selected [ , c ( 'price' , 'area' ) ]

prices <- selected $ price
areas <- selected $ area

cor1 <- cor ( for_cor [[ 1 ]] , for_cor [[ 2 ]]  )
cor1
cor2 <- corxy ( prices , areas )
cor2

write.table ( selected ,
    file = 'practical_product_solved.csv' ,
    sep = ',' , dec = '.' ,
    eol = "\n" , col.names = T , row.names = F
)