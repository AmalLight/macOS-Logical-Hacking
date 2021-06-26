library ( doMC    )
library ( caret   )
library ( mlbench )
library ( xgboost )
library ( gbm     )

cat ( '\n' ) ; print ( 'load on supported cores' )

registerDoMC ( cores = 4 )

# ------------------------------------------------------------

cat ( '\n' ) ; print ( 'fix imported data , reset it' )

mydata <- data.frame ( read.csv ( 'Attrition.csv' ) , stringsAsFactors = T )

mydata $ EmployeeNumber = mydata $ Over18 = mydata $ EmployeeCount = mydata $ StandardHours = NULL

# ------------------------------------------------------------

print ( ' Seen :             ' )
print ( '   Knn              ' )
print ( '   Treebag          ' )
print ( '   Svmbag      bugs ' )
print ( '   Naive Bayes bugs ' )
print ( '   Random Forests   ' )
print ( '   Boosting GDM     ' )

# ------------------------------------------------------------

cat ( '\n' ) ; print ( 'predict on imported data for Boosting XGBoost' )

ControlParamteres <- trainControl ( method = "repeatedcv" , number = 10 , repeats=10 , savePredictions = TRUE , classProbs = TRUE )

# setting up hyper parameters grid to tune

parametersGrid <- expand.grid( eta = 0.1 , colsample_bytree = c ( 0.5 , 0.7 ) ,
                               max_depth = c ( 3 , 6 ) , nrounds = 100 , gamma = 1 ,
                               min_child_weight = 2 , subsample = 0.5 )
                               
# printing the parameters grid to get an intuition

print ( parametersGrid ) # xgboost model building

modelxgboost <- train ( Attrition ~ . , data = mydata , method = "xgbTree" , trControl = ControlParamteres , tuneGrid = parametersGrid )

# printing the model summary

print ( modelxgboost )
