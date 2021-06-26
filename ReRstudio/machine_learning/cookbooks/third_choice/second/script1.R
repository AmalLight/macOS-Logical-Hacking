library ( rsample  )
library ( corrplot )
library ( ggplot2  )

cat ( '\n' ) ; print ( 'Import filec:' ) ; 

attrition <- read.csv ( 'Attrition.csv' , header = TRUE , sep  =  "," , dec =  "." , comment.char = "" )

cat ( '\n' ) ; print ( 'filter columns:' ) ; 

str   ( attrition )
table ( attrition $ Attrition )

numeric_mydata <- attrition [ ,

    c ( 1 , 4 , 6 , 7 , 10 , 11 , 13 , 14 , 15 , 17 , 19 , 20 , 21 , 24 , 25 , 26 , 28 : 35 )
]

numeric_Attrition = as.numeric ( attrition $ Attrition) - 1

numeric_mydata = cbind ( numeric_mydata , numeric_Attrition )

M <- cor ( numeric_mydata )

cat ( '\n' ) ; print ( 'correlation:' ) ; corrplot ( M , method = "circle" )

l <- ggplot ( attrition , aes ( OverTime , fill = Attrition ) )

l <- l + geom_histogram ( stat="count" )

tapply ( as.numeric ( attrition $ Attrition ) - 1 , attrition $ OverTime , mean )

print ( l )

l <- ggplot ( attrition , aes ( MaritalStatus , fill = Attrition ) )

l <- l + geom_histogram ( stat = "count" )

tapply ( as.numeric ( attrition $ Attrition ) - 1 , attrition $ MaritalStatus ,mean )

print ( l )

l <- ggplot ( attrition , aes ( JobRole , fill = Attrition ) )

l <- l + geom_histogram ( stat = "count" )

tapply ( as.numeric ( attrition $ Attrition ) - 1 , attrition $ JobRole , mean )

print ( l )

mean ( as.numeric ( attrition $ Attrition ) - 1 )

l <- ggplot( attrition , aes ( Gender , fill = Attrition ) )

l <- l + geom_histogram ( stat = "count" )

tapply ( as.numeric ( attrition $ Attrition ) - 1 , attrition $ Gender , mean )

print ( l )

l <- ggplot ( attrition , aes ( EducationField , fill = Attrition ) )

l <- l + geom_histogram ( stat = "count" )

tapply ( as.numeric ( attrition $ Attrition ) - 1 , attrition $ EducationField , mean )

print ( l )

l <- ggplot ( attrition , aes ( Department , fill = Attrition ) )

l <- l + geom_histogram ( stat = "count" )

tapply ( as.numeric ( attrition $ Attrition ) - 1 , attrition $ Department , mean )

print ( l )

l <- ggplot ( attrition , aes ( BusinessTravel , fill = Attrition ) )

l <- l + geom_histogram ( stat = "count" )

tapply ( as.numeric ( attrition $ Attrition ) - 1 , attrition $ BusinessTravel , mean )

print ( l )

ggplot ( attrition , aes ( OverTime , Age ) ) +

facet_grid ( .~MaritalStatus ) + geom_jitter ( aes ( color = Attrition ) , alpha = 0.4 ) +

ggtitle ( "x=Overtime, y= Age, z = MaritalStatus , t = Attrition" ) + theme_light ()

ggplot ( attrition , aes ( MonthlyIncome , Age , color = Attrition ) ) +

geom_jitter () + ggtitle ( "MonthlyIncome vs. Age, by color = Attrition " ) +

theme_light ()
