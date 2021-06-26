library ( doMC          )
library ( caret         )
library ( caretEnsemble )

cat ( '\n' ) ; print ( 'load on supported cores' )

registerDoMC ( cores = 4 )

# ------------------------------------------------------------

cat ( '\n' ) ; print ( 'fix imported data , reset it' )

mydata <- data.frame ( read.csv ( 'Attrition.csv' ) , stringsAsFactors = T )

mydata $ EmployeeNumber = mydata $ Over18 = mydata $ EmployeeCount = mydata $ StandardHours = NULL

# ------------------------------------------------------------

print ( ' Seen :              ' )
print ( '   Knn               ' )
print ( '   Treebag           ' )
print ( '   Svmbag      bugs  ' )
print ( '   Naive Bayes bugs  ' )
print ( '   Random Forests    ' )
print ( '   Boosting GDM      ' )
print ( '   Boosting XGB loop ' )
print ( '' )
print ( 'Done Stacking = 91%  ' ) 

# ------------------------------------------------------------
