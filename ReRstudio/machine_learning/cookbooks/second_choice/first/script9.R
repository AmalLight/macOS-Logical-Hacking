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

mean.mr     <- mean ( train.data $ Age [ grepl ( " Mr\\."  ,   train.data $ Name ) & !is.na ( train.data $ Age ) ] )
mean.mrs    <- mean ( train.data $ Age [ grepl ( " Mrs\\." ,   train.data $ Name ) & !is.na ( train.data $ Age ) ] )
mean.dr     <- mean ( train.data $ Age [ grepl ( " Dr\\."  ,   train.data $ Name ) & !is.na ( train.data $ Age ) ] )
mean.miss   <- mean ( train.data $ Age [ grepl ( " Miss\\.",   train.data $ Name ) & !is.na ( train.data $ Age ) ] )
mean.master <- mean ( train.data $ Age [ grepl ( " Master\\.", train.data $ Name ) & !is.na ( train.data $ Age ) ] )

print ( 'Fix Na or incomplete : give mean to all ( for each category )' )
train.data $ Age [ grepl ( " Mr\\.",     train.data $ Name ) & is.na ( train.data $ Age ) ] = mean.mr
train.data $ Age [ grepl ( " Mrs\\.",    train.data $ Name ) & is.na ( train.data $ Age ) ] = mean.mrs
train.data $ Age [ grepl ( " Dr\\.",     train.data $ Name ) & is.na ( train.data $ Age ) ] = mean.dr
train.data $ Age [ grepl ( " Miss\\.",   train.data $ Name ) & is.na ( train.data $ Age ) ] = mean.miss
train.data $ Age [ grepl ( " Master\\.", train.data $ Name ) & is.na ( train.data $ Age ) ] = mean.master

train.data $ Survived

barplot ( table (train.data $ Survived) , main="Passenger Survival" )
barplot ( table (train.data $ Survived) , main="Passenger Survival", names=c ( "Perished" , "Survived"      ) )
barplot ( table (train.data $ Pclass)   , main="Passenger Class"   , names=c ( "first" , "second" , "third" ) )

barplot (

   table (
       train.data %>%
           filter ( Survived == 1 ) %>%
           select ( Pclass )
   ),
      
   main="Passenger Survived Class",
   names=c ( "first" , "second" , "third" )
)

barplot (

   table (
       train.data %>%
           filter ( Survived == 0 ) %>%
           select ( Pclass )
   ),
      
   main="Passenger Not Survived Class",
   names=c ( "first" , "second" , "third" )
)

# train.data $ SibSp
# interesting test >> . install.sh first script9 | grep 8

paste ( 'some statistics , from crossing search' )

train.child = train.data $ Survived [ train.data $ Age < 13 ]
paste ( 'Survived <13 % : ', sur13 <- length ( train.child [ which ( train.child == 1 ) ] ) / length ( train.child ) )

train.youth = train.data $ Survived [ train.data $ Age >= 15 & train.data $ Age < 25 ]
paste ( 'Survived >15 <25 : ', sur1525 <- length ( train.youth [ which ( train.youth == 1 ) ] ) / length ( train.youth ) )

train.adult = train.data $ Survived [ train.data $ Age >= 20 & train.data $ Age < 65 ]
paste ( 'Survived >20 <65 : ', sur2065 <- length ( train.adult [ which ( train.adult == 1 ) ] ) / length ( train.adult ) )

train.senior = train.data$Survived [ train.data $ Age >= 65 ]
paste ( 'Survived >65 : ',  sur65 <- length ( train.senior [ which ( train.senior == 1 ) ] ) / length ( train.senior ) )

mosaicplot (

    train.data $ Pclass ~ train.data $ Survived,
    main="Passenger Survival Class", color=TRUE,
    xlab="Pclass", ylab="Survived"
)

