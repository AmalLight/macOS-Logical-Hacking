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

ftable = table ( mtcars $ am , mtcars $ gear )
ftable

mosaicplot ( ftable , main="Number of Forward Gears Within Automatic and Manual Cars" , color = TRUE )

# gear == marcia o cambio

n <- length ( unique ( mtcars $   am ) )
m <- length ( unique ( mtcars $ gear ) )

collection <- matrix ( rep ( 0 , n*m ) , nrow=n , ncol=m , byrow=T )

dimnames ( collection ) <- list ( unique ( mtcars $ am ) , unique ( mtcars $ gear ) )

cat ( '\nunique list for mtcars $ am:'   ) ; unique ( mtcars $   am )
cat ( '\nunique list for mtcars $ gear:' ) ; unique ( mtcars $ gear ) ; cat ( '\n' )

for ( i1 in 1:n ) {

    cat ( '\n' )
    
    el1 <- unique ( mtcars $ am ) [ i1 ]
    
    print ( paste ( '1° unique for am:' , el1 ) )
    
    for ( i2 in 1:m ) {

        el2 <- unique ( mtcars $ gear ) [ i2 ]
        
        print ( paste ( '2° unique for gear:' , el2 ) )
        print ( paste (
 
            'values count:' , count12 <- length (

                mtcars [[ 1 ]] [ ( mtcars $ am == el1 ) & ( mtcars $ gear == el2 ) ]
            )
        ))
        
        collection [ i1 , i2 ] <- count12
    }
}

cat ( '\n' ) ; paste ( 'collection:' ) ; collection

# ---------------------------------------------------------------------------------------------------------
# --- Pearson's Chi-squared test is a statistical test used to discover whether there is a relationship ---
# --- between two categorical variables -------------------------------------------------------------------
# ---------------------------------------------------------------------------------------------------------

cat ( '\n' )
paste ( 'df = ( r − 1 ) × ( c − 1 ):' , df <- ( length ( unique ( mtcars $ am ) ) - 1 ) * ( length ( unique ( mtcars $ gear ) ) - 1 ) )

cat ( '\n' )

x210 <- 0 ; x201 <- 0

for ( i in 1:m ) {

    i1 <- 1 ; i2 <- 2
    
    if ( collection [ i2 , i ] > 0 )
    
        x210 <- x210 + ( collection [ i1 , i ] - collection [ i2 , i ] ) ^ 2 / collection [ i2 , i ]
    else
        x210 <- x210 + 1

    i1 <- 2 ; i2 <- 1
    
    if ( collection [ i2 , i ] > 0 )
    
        x201 <- x201 + ( collection [ i1 , i ] - collection [ i2 , i ] ) ^ 2 / collection [ i2 , i ]
    else
        x201 <- x201 + 1
}

paste ( 'x210:' , x210 , 'x201:' , x201 )

chisq.test ( ftable )
