library ( e1071     )
library ( tidyverse )
library ( reshape2  )
library ( stringr   )
library ( party     )
library ( ggplot2   )
library (  car      )

data ( mtcars )

mode = function ( x ) {
   temp = table ( x )
   names ( temp ) [ temp == max ( temp ) ]
}

data ( Quartet )

str ( Quartet )

plot ( Quartet $ x , Quartet $ y1 )

lmfit = lm ( y1 ~ x , Quartet )

abline ( lmfit , col="red" )

lmfit

plot ( Quartet $ x , Quartet $ y1 )

lmfit2 = lsfit ( Quartet $ x , Quartet $ y1 )

abline ( lmfit2 , col="red" )

print ( 'different way to call lm: lsfit' ) # lmfit2

summary ( lmfit )
