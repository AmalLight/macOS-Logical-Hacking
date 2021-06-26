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

# ------------------------------------------------------------

cat ( '\n' ) ; print ( 'predict on imported data using Stacking=Mix of Techniques' )

control <- trainControl ( method = "repeatedcv" , number = 10 , repeats = 10 , savePredictions = TRUE , classProbs = TRUE ,
                          index = createMultiFolds ( mydata $ Attrition , k = 10 , times = 10 ) )

# declaring the ML algorithms to use in stacking

algorithmList <- c ( 'C5.0' , 'glm' , 'knn' , 'svmRadial' ) # naiveBayes bn bugs

# setting the seed to ensure reproducibility of the results

set.seed ( 10000 )

# creating the stacking model

models <- caretList ( Attrition~., data = mydata , trControl = control , methodList = algorithmList )

# obtaining the stacking model results and printing them

results <- resamples ( models )
results

summary ( results )

stackControl <- trainControl ( method = "repeatedcv" , number = 10 , repeats = 10 , savePredictions = TRUE , classProbs = TRUE )

# stack using glm

stack.glm <- caretStack ( models , method = "glm" , trControl = stackControl )

print ( stack.glm )

stack.rf <- caretStack ( models , method = "rf" , trControl = stackControl )

print ( stack.rf )

# ------------------------------------------------------------
# step by step

# made 4 model for tunneling of 10 parameters for each time repeated 10 times , so 100 samples

# measure correlaction of accuracy and kappa for each model

# mixing = stacking:
#    apply glm ( best correlation ) on Dominio
#    solutions 1 = 88%
#    re-apply rf random-forest on Codominio = Codominio 2
#    solutions 2 = 91%
