library ( e1071     )
library ( tidyverse )
library ( reshape2  )
library ( stringr   )
library ( party     )
library ( ggplot2   )

data ( mtcars )

x <- mtcars $ mpg

summary ( x )

q1 <- summary ( x ) [ '1st Qu.' ]
q3 <- summary ( x ) [ '3rd Qu.' ]

IQR ( x ) == ( q3 - q1 )

quantile ( x , 0.75 )

# first = 0%
# 1st = 25%
# median = 50%
# 3d = 75%
# last = 100%

cat ( '\n X:' ) ; x

cat ( '\n Cummax:' ) ; cummax ( x )
cat (

    '\n Cummax: For each index in a vector,',
    'computes the maximum of the vector\n',
    'from the beginning of the vector up to the current index\n'
)

cat ( '\n Cummin:' ) ; cummin ( x )
cat (

    '\n Cummin: For each index in a vector,',
    'computes the minimum of the vector\n',
    'from the beginning of the vector up to the current index\n'
)

table ( y <- mtcars $ cyl )

cat ( '\n Try to understand the frequency inside stem:\n\n' )

table ( x ) ; stem ( x )

cat ( 'from wikipedia: It is important to note that when there is a repeated number in the data (such as two 72s),\n',
'then the plot must reflect such (so the plot would look like 7 | 2 2 5 6 7 when it has the numbers 72 72 75 76 77).\n' )

cat ( '\n like steam , but not cli : plot inRplots.pdf\n\n' ) ; qplot( x , binwidth=2 )

mode = function ( x ) {
   temp = table ( x )
   names ( temp ) [ temp == max ( temp ) ]
}

print ( 'cov:' )
cov ( mtcars[1:3] )
print ( 'cor:' )
cor ( mtcars[1:3] )

qplot ( x=Var1 , y=Var2 , data = melt ( cor ( mtcars [1:3] ) ) , fill=value , geom="tile" )

