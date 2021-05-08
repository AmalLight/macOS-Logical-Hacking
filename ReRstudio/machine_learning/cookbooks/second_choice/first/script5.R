library ( e1071     )
library ( WriteXLS  )
library ( tidyverse )
library ( reshape   )

# ? aggregate

print ( 'group by list ( Species ), make summarise from FUN = mean' )
aggregate ( x = iris [ , 1:4 ] , by = list ( iris $ Species ) , FUN = mean )

paste( 'molten data frame on Species -> is like spread on iris for Species' )
iris.melt <- melt ( iris , id = 'Species' ) # Convert an object into a molten data frame

paste ( 'Cast a molten data frame into the reshaped or aggregated form you want' )
cast ( Species~variable , data = iris.melt , mean ,
       subset = Species %in%
           c ( 'setosa' , 'versicolor' ),
       margins ='grand_row' )
       
paste ( 'this melt + cast is like aggregate !' )


table.iris = table ( iris $ Species )
table.iris

paste ( 'pie read only table , auto saved on ./ like Rplots.pdf' )
pie ( table.iris ,  main="Pie Chart of Species1" )
pie ( table.iris ,  main="Pie Chart of Species2" )

paste ( 'hist distribution read vector , auto saved on ./ like Rplots.pdf' )
hist ( iris $ Sepal.Length , main="Distribution for Sepal.Length" )

# iris %>% boxplot ( Petal.Width ~ Species , main="Distribution 2 for Species (x) on Petal.Width (y)" )

paste ( 'boxplot work well with data=... . no pipe %>%' )
boxplot ( data=iris , Petal.Width ~ Species , main="Distribution 2 for Species (x) on Petal.Width (y)" )

paste ( 'plot on x=iris$Petal.Length, y=iris$Petal.Width . based on iris$Species . done .' )
plot ( x=iris$Petal.Length , y=iris$Petal.Width , col=iris$Species , main="plot for x=iris$Petal.Length, y=iris$Petal.Width . based on iris$Species" )


paste ( 'pairs : a collection of plot for data' )
pairs ( iris [ 1 : 4 ] , main = "Edgar Anderson's Iris Data" , pch = 21 ,
        bg = c ( "red" , "green3" , "blue" ) [ unclass ( iris $ Species ) ] )
        
paste ( 'this head it will be equal to get it from head ( read.csv ( url ( "..." ) ) )' )
head ( iris )
