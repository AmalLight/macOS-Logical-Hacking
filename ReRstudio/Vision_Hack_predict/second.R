# sudo apt install libgsl-dev
# install.packages( 'Rfast' )

library ( Rfast )

matrixa <-
    matrix ( runif ( 25 , 5 , 8 ) , 5 , 5 ,
             dimnames = list ( c ( 'a' , 'b' , 'c' , 'd' , 'e' ) ,
                               c ( 'x' , 'y' , 'w' , 'y' , 'z' ) ) )
             
matrixb <-
    matrix ( rnorm ( 25 , 5 , 8 ) , 5 , 5 ,
             dimnames = list ( c ( 'a' , 'b' , 'c' , 'd' , 'e' ) ,
                               c ( 'x' , 'y' , 'w' , 'y' , 'z' ) ) )

add_more_rows_and_columns <- function ( matrix )
{
    Means_for_column <- colMeans ( matrix )
    Sums_for_column  <- colSums  ( matrix )
    Mins_for_column  <- colMins  ( matrix , value = T )
    Maxs_for_column  <- colMaxs  ( matrix , value = T )

    names ( Means_for_column ) <- 'Means for Column'
    names ( Sums_for_column  ) <- 'Sums  for Column'
    names ( Mins_for_column  ) <- 'Mins  for Column'
    names ( Maxs_for_column  ) <- 'Maxs  for Column'

    matrix <- rbind ( matrix , Means_for_column ,
                               Sums_for_column  ,
                               Mins_for_column  ,
                               Maxs_for_column  )
    
    Means_for_row <- rowMeans ( matrix )
    Sums_for_row  <- rowSums  ( matrix )
    Mins_for_row  <- rowMins  ( matrix , value = T )
    Maxs_for_row  <- rowMaxs  ( matrix , value = T )
    
    matrix <- cbind ( matrix , Means_for_row ,
                               Sums_for_row  ,
                               Mins_for_row  ,
                               Maxs_for_row  )
    matrix
}

add_more_rows_and_columns ( matrixa )
add_more_rows_and_columns ( matrixb )
