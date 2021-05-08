library ( e1071     )
library ( WriteXLS  )
library ( tidyverse )
library ( reshape   )
library ( Amelia    )

# https://www.kdnuggets.com/datasets/index.html

getwd ()

train.data <- read.csv ( './titanic/train.csv' , na.strings=c ( "NA" , "" ) )
str ( train.data )

table ( train.data $ Embarked , useNA = "always" )

paste ( 'Fix NA values' )
train.data $ Embarked [ which ( is.na ( train.data $ Embarked ) ) ] = 'S'
table ( train.data $ Embarked , useNA = "always" )

paste ( 'Fix Names' )
train.data $ Name = as.character ( train.data $ Name )

table_words_2 <- table ( c() )

# ‘table’ uses the cross-classifying factors to build a contingency
# table of the counts at each combination of factor levels.

paste ( 'split Name column ang get levels and table' )
array <- strsplit ( train.data $ Name , "\\s+" )

levels <- c ( ) ; all <- c ( )

for ( row1 in array ) {
    
    for ( row2 in row1 ) {
        
        if ( ! any ( levels == row2 ) ) {
        
           levels <- c ( levels , row2 )
           
           all <- c ( all , row2 )
        }
    }
    
    levels <- c ()
}

for ( row1 in array ) {
    
    for ( row2 in row1 ) {
    
        if ( ! any ( levels == row2 ) ) {
        
            levels <- c ( levels , row2 )
        
            table_words_2 [ row2 ] <- sum ( row2 == all )
        }
    }
}

paste ( 'levels size : ' , length ( levels ) )

table_words_1 <- table ( unlist ( strsplit ( train.data $ Name , "\\s+" ) ) )

sort ( table_words_1 [ 1:length ( levels ) ] , decreasing = T ) [ 1 ]
sort ( table_words_2 [ 1:length ( levels ) ] , decreasing = T ) [ 1 ]

sort_1 <- sort ( table_words_1 [ grep ( '\\.' , names ( table_words_1 ) ) ] , decreasing = T )
sort_2 <- sort ( table_words_2 [ grep ( '\\.' , names ( table_words_2 ) ) ] , decreasing = T )

paste ( 'my algorithm == book-algorithm: ' , all ( sort_1 == sort_2 ) )

