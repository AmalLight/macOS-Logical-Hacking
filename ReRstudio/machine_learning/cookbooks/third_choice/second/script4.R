library ( doMC    )
library ( caret   )
library ( mlbench )
library ( gbm     )

cat ( '\n' ) ; print ( 'load on supported cores' )

registerDoMC ( cores = 4 )

# ------------------------------------------------------------

print ( ' seen:          ' )
print ( '   knn          ' )
print ( '   treebag      ' )
print ( '   svmbag  bugs ' )

# ------------------------------------------------------------

cat ( '\n' ) ; print ( 'fix imported data , reset it' )

mydata <- data.frame ( read.csv ( 'Attrition.csv' ) , stringsAsFactors = T )

mydata $ EmployeeNumber = mydata $ Over18 = mydata $ EmployeeCount = mydata $ StandardHours = NULL

# ------------------------------------------------------------

cat ( '\n' ) ; print ( 'predict on imported data for Naive Bayes' )

cvcontrol <- trainControl ( method = "repeatedcv" , repeats=10 , number = 10 , allowParallel = TRUE )

bagctrl <- bagControl ( fit = nbBag $ fit , predict = nbBag $ pred , aggregate = nbBag $ aggregate )

# fit the bagged nb model

set.seed ( 300 )

# nbbag <- train ( Attrition ~ . , data = mydata , method="bag" , trControl = cvcontrol, bagControl = bagctrl )
# printing the model results
# nbbag

# ------------------------------------------------------------

cat ( '\n' ) ; print ( 'predict on imported data for Random Forests' )

set.seed ( 10000 )

# setting the cross validation parameters

fitControl = trainControl ( method = "repeatedcv" , number = 10 , repeats = 10 )

# creating the caret model with random forest algorithm

caretmodel = train ( Attrition ~ . , data = mydata , method = "rf" , trControl = fitControl , verbose = F )

# printing the model summary

caretmodel

# algorithms that has proved itself multiple times as the best performing of algorithms

