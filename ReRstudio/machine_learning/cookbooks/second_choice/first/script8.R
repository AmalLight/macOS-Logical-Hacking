library ( e1071     )
library ( WriteXLS  )
library ( tidyverse )
library ( reshape   )
library ( Amelia    )
library ( stringr   )

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

# ‘table’ uses the cross-classifying factors to build a contingency
# table of the counts at each combination of factor levels.

paste ( 'split Name column ang get levels and table' )
array <- strsplit ( train.data $ Name , "\\s+" )

table_words_1 <- table ( unlist ( strsplit ( train.data $ Name , "\\s+" ) ) )

sort_1 <- sort ( table_words_1 [ grep ( '\\.' , names ( table_words_1 ) ) ] , decreasing = T )

paste ( 'make cbind matrix from Age and filtred name , with str_match' )
tb = cbind ( train.data $ Age , str_match ( train.data $ Name , "[a-zA-Z]+\\." ) )

table ( tb [ is.na ( tb [ , 1 ] ) , 2 ] )

paste ( 'collection of mean' )
paste ( 'mean Mr     : ', mean.mr     <- mean ( train.data $ Age [ grepl ( " Mr\\."  ,   train.data $ Name ) & !is.na ( train.data $ Age ) ] ) )
paste ( 'mean Mrs    : ', mean.mrs    <- mean ( train.data $ Age [ grepl ( " Mrs\\." ,   train.data $ Name ) & !is.na ( train.data $ Age ) ] ) )
paste ( 'mean Dr     : ', mean.dr     <- mean ( train.data $ Age [ grepl ( " Dr\\."  ,   train.data $ Name ) & !is.na ( train.data $ Age ) ] ) )
paste ( 'mean Miss   : ', mean.miss   <- mean ( train.data $ Age [ grepl ( " Miss\\.",   train.data $ Name ) & !is.na ( train.data $ Age ) ] ) )
paste ( 'mean Master : ', mean.master <- mean ( train.data $ Age [ grepl ( " Master\\.", train.data $ Name ) & !is.na ( train.data $ Age ) ] ) )

print ( 'Fix Na or incomplete : give mean to all ( for each category )' )
train.data $ Age [ grepl ( " Mr\\.",     train.data $ Name ) & is.na ( train.data $ Age ) ] = mean.mr
train.data $ Age [ grepl ( " Mrs\\.",    train.data $ Name ) & is.na ( train.data $ Age ) ] = mean.mrs
train.data $ Age [ grepl ( " Dr\\.",     train.data $ Name ) & is.na ( train.data $ Age ) ] = mean.dr
train.data $ Age [ grepl ( " Miss\\.",   train.data $ Name ) & is.na ( train.data $ Age ) ] = mean.miss
train.data $ Age [ grepl ( " Master\\.", train.data $ Name ) & is.na ( train.data $ Age ) ] = mean.master

paste ( 'collection of mean , try again' )
paste ( 'mean Mr     : ', mean.mr     <- mean ( train.data $ Age [ grepl ( " Mr\\."  ,   train.data $ Name ) & !is.na ( train.data $ Age ) ] ) )
paste ( 'mean Mrs    : ', mean.mrs    <- mean ( train.data $ Age [ grepl ( " Mrs\\." ,   train.data $ Name ) & !is.na ( train.data $ Age ) ] ) )
paste ( 'mean Dr     : ', mean.dr     <- mean ( train.data $ Age [ grepl ( " Dr\\."  ,   train.data $ Name ) & !is.na ( train.data $ Age ) ] ) )
paste ( 'mean Miss   : ', mean.miss   <- mean ( train.data $ Age [ grepl ( " Miss\\.",   train.data $ Name ) & !is.na ( train.data $ Age ) ] ) )
paste ( 'mean Master : ', mean.master <- mean ( train.data $ Age [ grepl ( " Master\\.", train.data $ Name ) & !is.na ( train.data $ Age ) ] ) )
