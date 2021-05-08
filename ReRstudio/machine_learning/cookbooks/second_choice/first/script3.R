library ( e1071     )
library ( WriteXLS  )
library ( tidyverse )

data ( iris )

iris [ 1 , "Sepal.Length" ]

Sepal.iris = iris [ , c ( "Sepal.Length" , "Sepal.Width" ) ]

str( Sepal.iris )

Five.Sepal.iris = iris [ 1:5 , c ( "Sepal.Length" , "Sepal.Width" ) ]

str( Five.Sepal.iris )

setosa.data1 = iris [ iris $ Species == "setosa" , 1:5 ]
setosa.data  = iris [ iris $ Species == "setosa" , 1:5 ]

paste ( 'iris $ Species' , str ( setosa.data ) )

# which : index of found

which ( iris $ Species == "setosa" )

setosa.data2 = iris [ which ( iris $ Species == "setosa" ) , 1:5 ]
setosa.data  = iris [ which ( iris $ Species == "setosa" ) , 1:5 ]

paste ( 'which iris $ Species' , str ( setosa.data ) )

all ( setosa.data1 == setosa.data2 )
any ( setosa.data1 == setosa.data2 )

# select

iris2 <-
iris %>%
    subset ( select = c ( "Sepal.Length", "Sepal.Width" ) )

iris2 [ 1:5 , ]

# where

setosa.data <-
iris %>%
    subset( Species =="setosa" )

setosa.data [ 1:5 , ]

paste ( 'and1 : subset ( A , B )' )
paste ( 'and2 : subset ( A & B )' )
paste ( 'or1  : subset ( A | B )' )

head( iris [ order ( iris $ Sepal.Length , decreasing = TRUE ) , ] )

