library ( e1071     )
library ( reshape2  )
library ( ggplot2   )
library ( caret     )
library ( party     )
library ( modeldata )
library ( class     )
library ( car       )

pdf ( file = 'Rplots.pdf' , onefile = T , paper = 'A4r' , width=80 , height=80 )

data ( mlc_churn )

churnTrain = mlc_churn [ , ! names ( mlc_churn ) %in% c ( "state" , "area_code" , "account_length" ) ]
names ( churnTrain )

set.seed ( 2 )

cat ('\n' ) ; print ( 'Ranking the variable importance with the caret package' )

control = trainControl ( method = "repeatedcv" , number = 10 , repeats = 3 )

model = train ( churn~. , data = churnTrain , method = "rpart" , preProcess = "scale" , trControl = control )

importance = varImp ( model , scale = FALSE )
importance

cat  ( '\n'       ) ; print ( 'Ranking plot for weight importance' )
plot ( importance )
