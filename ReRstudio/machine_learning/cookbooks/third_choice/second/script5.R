library ( doMC    )
library ( caret   )
library ( mlbench )
library ( gbm     )

cat ( '\n' ) ; print ( 'load on supported cores' )

registerDoMC ( cores = 4 )

# ------------------------------------------------------------

cat ( '\n' ) ; print ( 'fix imported data , reset it' )

mydata <- data.frame ( read.csv ( 'Attrition.csv' ) , stringsAsFactors = T )

mydata $ EmployeeNumber = mydata $ Over18 = mydata $ EmployeeCount = mydata $ StandardHours = NULL

# ------------------------------------------------------------

print ( ' Seen:              ' )
print ( '   Knn              ' )
print ( '   Treebag          ' )
print ( '   Svmbag      bugs ' )
print ( '   Naive Bayes bugs ' )
print ( '   Random Forests   ' )

# ------------------------------------------------------------

cat ( '\n' ) ; print ( 'predict on imported data for Boosting GBM' )

# gradient boosting machines

mydata $ Attrition = as.numeric ( mydata $ Attrition )

# forcing the attrition column values to be 0 and 1 instead of 1 and 2

mydata = transform ( mydata , Attrition = Attrition - 1 )

# running the gbm model with 10 fold cross validation to identify the number
# of trees to build - hyper parameter tuning

gbm.model = gbm ( Attrition ~ . , data = mydata , shrinkage = 0.01 , distribution = 'bernoulli' , cv.folds = 10 , n.trees = 3000 , verbose = F )

# identifying and printing the value of hyper parameter identified through the tuning above

best.iter = gbm.perf ( gbm.model , method = "cv" )

print ( best.iter )

# setting the seed for reproducibility

set.seed ( 123 )

# creating a copy of the dataset

mydata1 = mydata

# converting target to a factor

mydata1 $ Attrition = as.factor ( mydata1 $ Attrition )

# setting up cross validation controlsfitControl = trainControl(method="repeatedcv", number=10,repeats=10)
# runing the gbm model in tandem with caret

fitControl = trainControl ( method = "repeatedcv" , number = 10 , repeats = 10 )

caretmodel = train ( Attrition ~ . , data = mydata1 , method = "gbm" , distribution = "bernoulli" , trControl = fitControl , verbose = F ,
                                     tuneGrid = data.frame ( .n.trees = best.iter , .shrinkage = 0.01 , .interaction.depth = 1 , .n.minobsinnode = 1 ) )
# printing the model summary

print ( caretmodel )
