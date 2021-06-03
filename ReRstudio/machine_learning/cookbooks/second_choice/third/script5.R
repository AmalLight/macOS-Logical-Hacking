library ( e1071     )
library ( reshape2  )
library ( ggplot2   )
library ( car       )
library ( modeldata )
library ( caret     )
library ( party     )
library ( rpart     )
library ( class     )

pdf ( file = 'Rplots.pdf' , onefile = T , paper = 'A4r' , width=80 , height=80 )

data ( mlc_churn )

str ( mlc_churn )

churnTrain = mlc_churn [ , ! names ( mlc_churn ) %in% c ( "state" , "area_code" , "account_length" ) ]

set.seed ( 2 )

ind = sample ( 2 , nrow ( churnTrain ) , replace = TRUE, prob = c ( 0.7 , 0.3 ) )

trainset = churnTrain [ ind == 1, ]
testset  = churnTrain [ ind == 2, ]

dim ( trainset )

dim ( testset )

# before done with ctree

churn.ct = ctree ( churn ~ . , data = trainset )
churn.rp = rpart ( churn ~ . , data = trainset )

churn.rp ; churn.ct

# summary ( churn.rp ) ; summary ( churn.ct ) more long than expected

plot ( churn.rp , margin = 0.1 )

text ( churn.rp , all = TRUE , use.n = TRUE )

plot ( churn.rp , uniform=TRUE , branch=0.6 , margin=0.1 )
 
text ( churn.rp , all=TRUE , use.n = TRUE )

pred.rp = predict ( churn.rp , testset , type="class" )
pred.ct = predict ( churn.ct , testset )

cat ( '\n' ) ; paste ( 'tb.rp: ' ) ; paste ( tb.rp <- table ( testset $ churn , pred.rp ) )
               paste ( 'tb.ct: ' ) ; paste ( tb.ct <- table ( testset $ churn , pred.ct ) )

cat ( '\n' )
print ( paste ( 'total y:'       , len.pred <- length ( testset $ churn                                 ) ) )
print ( paste ( 'total valid y:' , len.pred <- length ( testset $ churn [ ! is.na ( testset $ churn ) ] ) ) )

cat ( '\n' )
print ( paste ( 'prediction correctly fot ct:' , valid.ct <- ( tb.ct [ 1,1 ] + tb.ct [ 2,2 ] ) , '%:' , valid.ct / len.pred ) )
print ( paste ( 'prediction correctly fot rp:' , valid.rp <- ( tb.rp [ 1,1 ] + tb.rp [ 2,2 ] ) , '%:' , valid.rp / len.pred ) )

# ---------------------------
# --- k-nearest -------------
# ---------------------------
# --- class package ---------
# ---------------------------

cat ( '\n' ) ; print ( 'k-nearest in class package:' )

levels ( trainset $ international_plan ) = list ( "0" = "no" , "1" = "yes" )
levels ( trainset $    voice_mail_plan ) = list ( "0" = "no" , "1" = "yes" )
levels ( testset  $ international_plan ) = list ( "0" = "no" , "1" = "yes" )
levels ( testset  $    voice_mail_plan ) = list ( "0" = "no" , "1" = "yes" )

print ( '‘levels’ provides access to the levels attribute of a variable.' )
print ( 'The first form returns the value of the levels of its argument and' )
print ( 'the second sets the attribute.' )

cat ( '\n' )
print ( 'Use the knn classification method on the training dataset and the testing dataset'  )
print ( 'Then, you can use the summary function to retrieve the number of predicted labels:' )

churn.knn = knn ( trainset [ , ! names ( trainset ) %in% c ( "churn" ) ] ,
                   testset [ , ! names (  testset ) %in% c ( "churn" ) ] ,
                  trainset $                                  churn      , k = 3 )
                  
cat ( '\n' ) ; summary ( churn.knn )

print ( 'tb.knn:' )
tb.knn <- table ( testset $ churn , churn.knn ) ; tb.knn

cat ( '\n' ) ; print ( 'it\'s more speedly but minus accurate:' )
paste ( accuracy <- ( tb.knn [ 1,1 ] + tb.knn [ 2,2 ] ) / len.pred )

# ---------------------------------
# --- made with binomyal family ---
# ---------------------------------

fit1 = glm ( churn ~ . , data = trainset , family = binomial )

cat ( '\n' ) ; print ( 'made glm1 with binomyal family' )

summary ( fit1 )

fit2 = glm ( churn ~ international_plan +
                    voice_mail_plan+total_intl_calls +
                    number_customer_service_calls ,
                    
            data = trainset , family = binomial )
            
cat ( '\n' ) ; print ( 'made glm2 with binomyal family' )

summary ( fit2 )

pred1 = predict ( fit1 , testset , type = "response" )

pred2 = predict ( fit2 , testset , type = "response" )

classification1 = pred1 > 0.5

tb.pred1 = tb = table ( testset $ churn , classification1 )

class2 = pred2 > 0.5

tb.pred2 = tb = table ( testset $ churn , class2 )

print ( paste ( 'accuracy glm1:' , ( tb.pred1 [ 1,1 ] + tb.pred1 [ 2,2 ] ) / len.pred ) )
print ( paste ( 'accuracy glm2:' , ( tb.pred2 [ 1,1 ] + tb.pred2 [ 2,2 ] ) / len.pred ) )

# ----------------------------------------------------------------------------------------------
# ----------------------------------------------------------------------------------------------

cat ( '\n' ) ; print ( 'made Naïve Bayes' )

classifier = naiveBayes ( trainset [ , ! names ( trainset ) %in% c ( "churn" ) ] , trainset $ churn )
classifier

bayes.table = table ( predict ( classifier , testset [ , !names ( testset ) %in% c ( "churn" ) ] ) , testset $ churn )
bayes.table

print ( paste ( 'accuracy naive bayes:' , ( bayes.table [ 1,1 ] + bayes.table [ 2,2 ] ) / len.pred ) )


