library ( e1071     )
library ( tidyverse )
library ( reshape2  )
library ( stringr   )
library ( party     )
library ( ggplot2   )

data ( mtcars )
mode = function ( x ) {
   temp = table ( x )
   names ( temp ) [ temp == max ( temp ) ]
}

# Kolmogorov-Smirnov test used to compare a sample with
# a reference probability distribution (a one sample K-S test),
# or it can directly compare two samples (a two sample K-S test).

# ----------------------------------------------------------------------------------------------------
# ----------------------------------------------------------------------------------------------------

empirical_function <- function( set ) {

    vector <- c () ; size <- length ( set )
    
    for ( i1 in 1:size ) {
    
        now <- 0
        
        for ( i2 in 1:size )
        
            if ( set [ i2 ] <= set [ i1 ] ) { now <- now + 1 }
            
        vector <- c ( vector , now / size )
    }
    
    return ( vector )
}

absolute_difference_xy <- function ( setx , sety ) {
   
    vector <- c ( ) ; size <- length ( setx )
    
    for ( i in 1:size ) {
    
       tmp <- ( setx [ i ] - sety [ i ] )
       
       if ( tmp < 0 ) { tmp <- ( tmp * -1 ) }
       
       vector <- c ( vector , tmp )
    }
       
    return ( vector )
}

vector_with_ecdf <- function ( set ) {

    ecdf_vect <- empirical_function ( set )
    
    vector <- c () ; size <- length ( set )
    
    for ( i in 1:size )

        vector <- c ( vector , set [ i ] * ecdf_vect [ i ] )
    
    return ( vector )
}

# ----------------------------------------------------------------------------------------------------
# ----------------------------------------------------------------------------------------------------

set.seed ( 50 )

x1 = rnorm ( 50 )
y1 = pnorm ( x1 )

ks.test ( x1 , 'pnorm' )

paste ( 'D =' , d <- max ( absolute_difference_xy ( empirical_function ( x1 ) , y1 ) ) )

# ----------------------------------------------------------------------------------------------------

set.seed ( 60 )

x2 = runif ( n=20 , min=0 , max=20 ) ; x2 <- sort ( x2 )
x3 = runif ( n=20 , min=0 , max=20 ) ; x3 <- sort ( x3 )

cat ( '\n X2 and X3: \n' ) ; x2
cat ( '\n'               ) ; x3

ks.test ( x2 , x3 )

paste ( 'D1 using ecdf for both  =' , d <- max ( absolute_difference_xy ( empirical_function ( x2 ) , empirical_function ( x3 ) ) ) )
paste ( 'D2 using vector + ecdf  =' , d <- max ( absolute_difference_xy ( vector_with_ecdf   ( x2 ) , vector_with_ecdf   ( x3 ) ) ) )
paste ( 'D3 using ecdf  and x3   =' , d <- max ( absolute_difference_xy ( empirical_function ( x2 ) , x3                        ) ) )
paste ( 'D4 using pnorm for x3   =' , d <- max ( absolute_difference_xy ( empirical_function ( x2 ) , pnorm ( x3 )              ) ) )
paste ( 'D5 using pnorm for both =' , d <- max ( absolute_difference_xy (              pnorm ( x2 ) , pnorm ( x3 )              ) ) )

plot  ( ecdf ( x2 )           , do.points = FALSE , verticals = T , xlim = c ( 0 , 20 ) )
lines ( ecdf ( x3 ) , lty = 3 , do.points = FALSE , verticals = T )

# ----------------------------------------------------------------------------------------------------
# ------- Funzione di ripartizione empirica - Wikipedia --> ECDF -------------------------------------
# ----------------------------------------------------------------------------------------------------

cat ( '\n see my empirical function D1 for x2 =' ) ; empirical_function ( x2 )
cat ( '\n see my empirical function D1 for x3 =' ) ; empirical_function ( x3 )
cat ( '\n see my empirical function D2 for x2 =' ) ;   vector_with_ecdf ( x2 )
cat ( '\n see my empirical function D2 for x3 =' ) ;   vector_with_ecdf ( x3 )
cat ( '\n'                                       ) ;

plot  ( x2 , empirical_function ( x2 ) , main = 'my ecdf' , xlim = c ( 0 , 20 ) , ylim = c ( 0 , 1 ) , col = 'red' , type ='l' )
lines ( x3 , empirical_function ( x3 ) ,                    xlim = c ( 0 , 20 ) , ylim = c ( 0 , 1 ) , col = 'blue'            )

