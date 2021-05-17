library ( e1071     )
library ( WriteXLS  )
library ( tidyverse )
library ( reshape   )
library ( Amelia    )
library ( stringr   )
library ( party     )
library ( caret     )
library ( ROCR      )

# https://www.kdnuggets.com/datasets/index.html

getwd ()

train.data <- read.csv ( './titanic/train.csv' , na.strings=c ( "NA" , "" ) )
str ( train.data )

train.data $ Survived <- factor ( train.data $ Survived )
train.data $ Pclass   <- factor ( train.data $ Pclass   )
cat ( '\n Fixed/Factorized Survived 1-0 and PClass 1-2-3\n'  )

cat ( '\n Show bug where ther\'is some Na' ) 
table ( train.data $ Embarked , useNA = "always" )

cat ( '\n Fix NA values' )
train.data $ Embarked [ which ( is.na ( train.data $ Embarked ) ) ] = 'S'
table ( train.data $ Embarked , useNA = "always" )

cat ( '\n Fix Names with as.character,' )
train.data $ Name = as.character ( train.data $ Name )

cat ( '\n\ And testing if all is right' )

table_words = table ( unlist ( strsplit ( train.data $ Name , "\\s+" ) ) )
sort( table_words [ grep ( '\\.' , names (table_words) ) ] , decreasing = T )

tb = cbind ( train.data $ Age , str_match ( train.data $ Name , "[a-zA-Z]+\\." ) )
table ( tb [ is.na ( tb [ , 1 ] ) , 2 ] )

mean.mr     <- mean ( train.data $ Age [ grepl ( " Mr\\."  ,   train.data $ Name ) & ! is.na ( train.data $ Age ) ] )
mean.mrs    <- mean ( train.data $ Age [ grepl ( " Mrs\\." ,   train.data $ Name ) & ! is.na ( train.data $ Age ) ] )
mean.dr     <- mean ( train.data $ Age [ grepl ( " Dr\\."  ,   train.data $ Name ) & ! is.na ( train.data $ Age ) ] )
mean.miss   <- mean ( train.data $ Age [ grepl ( " Miss\\.",   train.data $ Name ) & ! is.na ( train.data $ Age ) ] )
mean.master <- mean ( train.data $ Age [ grepl ( " Master\\.", train.data $ Name ) & ! is.na ( train.data $ Age ) ] )

cat ( '\n Fix only for Age Na or incomplete giving to it the mean for each category' )
train.data $ Age [ grepl ( " Mr\\.",     train.data $ Name ) & is.na ( train.data $ Age ) ] = mean.mr
train.data $ Age [ grepl ( " Mrs\\.",    train.data $ Name ) & is.na ( train.data $ Age ) ] = mean.mrs
train.data $ Age [ grepl ( " Dr\\.",     train.data $ Name ) & is.na ( train.data $ Age ) ] = mean.dr
train.data $ Age [ grepl ( " Miss\\.",   train.data $ Name ) & is.na ( train.data $ Age ) ] = mean.miss
train.data $ Age [ grepl ( " Master\\.", train.data $ Name ) & is.na ( train.data $ Age ) ] = mean.master

split.data_my <- function ( data , p = 0.7 , s = 666 ) {

    print ( paste ( 'set frequency for future training test ( make it reproducible )' ) ) ; set.seed ( s )
    
    print ( paste ( 'take dimension N for NxM: ', dimN <- dim( data ) [ 1 ] ) )
    
    index <- sample ( 1 : dimN ) # take dimension N for NxM | N is number of rows , M is number of columns
    
    print ( paste ( 'floor rounding exemple [ 5.0 , 5.1 , 5.7 ] -> 5' ) )
    print ( paste ( 'floor rounding by dimN for p:{', p, '} : ', floor_dimN <- floor ( dimN * p ) ) )
    
    print ( paste ( 'make train subset from data' ) ) ; train <- data [ index [ 1 : floor_dimN ] , ]
    
    print ( paste ( 'ceiling rounding exemple 5.0 -> 5 ; [ 5.1 , 5.7 ] -> 6' ) )
    print ( paste ( 'ceiling rounding by dimN for p:{', p, '} : ', ceiling_dimN <- ceiling ( dimN * p ) ) )
    
    print ( paste ( 'make test subset from data' ) ) ; test <- data [ index [ ( ceiling_dimN + 1 ) : dimN ] , ]
    
    return ( list ( train = train , test = test ) )
}

paste ( 'run split.data ( data )' ) ; allset <- split.data_my ( train.data )

trainset <- allset $ train
testset  <- allset $ test

paste ( 'trainset and testset builted' )

cat ( '\nparty : A computational toolbox for recursive partitioning.',
'The core of the package is ctree(), an implementation of conditional inference trees which embed tree-structured regression models,',
'into a well defined theory of conditional inference procedures.',
'This non-parametric class of regression trees is applicable to all kinds of regression problems, including nominal, ordinal, numeric,',
'censored as well as multivariate response variables and arbitrary measurement scales of the covariates. Based on conditional inference trees,',
'cforest() provides an implementation of Breiman\'s random forests.',
'The function mob() implements an algorithm for recursive partitioning based on parametric models (e.g. linear models,',
'GLMs or survival regression) employing parameter instability tests for split selection.',
'Extensible functionality for visualizing tree-structured regression models is available.\n', sep="\n" )

namecol <- colnames ( trainset )
paste ( 'possible Node: ' , namecol )
paste ( 'possible size: ', length ( namecol ) )

paste ( 'Node we want use: ', interest <- c ( 'Pclass' , 'Sex' , 'Age' , 'SibSp' , 'Fare' , 'Parch' , 'Embarked' ) )
paste ( 'size of Nodes we want: ', interest_len <- length ( interest ) )

paste ( 'build my first inference like lm but using a tree' )

my_function <- c () ; for ( value in interest ) { my_function <- c ( my_function , paste ( value , '* var' ) ) }

paste ( 'So: Survived ~ ', paste ( my_function, collapse=' + ' ) , '+ costant' )

cat ( '\n see if all is ok before to start \n' )
trainset $ Pclass   [ 1 ]
trainset $ Sex      [ 1 ]
trainset $ Age      [ 1 ]
trainset $ SibSp    [ 1 ]
trainset $ Fare     [ 1 ]
trainset $ Parch    [ 1 ]
trainset $ Embarked [ 1 ]

cat ( '\n start ctree' )

train.ctree = ctree ( Survived ~ Pclass + Sex + Age + SibSp + Fare + Parch + Embarked , data = trainset )

cat ( '\n \n Ended -> print the tree' ) ; train.ctree

cat ( '\n terminal node is last leaf' )
cat ( '\n inner node is like root a parent leaf \n' )

plot ( train.ctree , main="Conditional inference tree of Titanic Dataset" )

svm.model = svm ( Survived ~ Pclass + Sex + Age + SibSp + Fare + Parch + Embarked , data = trainset , probability = TRUE )
svm.model

cat ( 'Here, we use svm to show how easy it is that you can immediately use different machine',
'learning algorithms on the same dataset when using R. For further information on how to use',
'svm , please refer to Chapter 6, Classification (II) – Neural Network, SVM.', sep='\n' )

# --------------------
# --- TESTING --------
# --------------------

ctree.predict = predict ( train.ctree , testset )

cat ( '\npredicted by id:\n' )
typeof ( ctree.predict )
testset [[ 1 ]]

cat   ( '\n' )
paste ( 'exemple for' , testset [[ 1 ]][ 1 ] , 'has status from resulted predict of:' , testset [ 1,2 ] )
paste ( 'and has status to predict of:' , ctree.predict [ 1 ] , 'called:' , names ( ctree.predict [ 1 ] ) )
cat   ( '\n' )
    
paste ( 'considering this names:' ) ; colnames ( testset )
cat ( '\nI want to get:' ) ; testset [ 1 , c ( 3 , 5 : 8 , 10 , 12 ) ]

train.ctree

# model ----------------------------------------------------------------------
# ----------------------------------------------------------------------------

modello <- function ( set , show=T ) {
    sex    <- as.numeric ( set [ 2 ] )
    classe <- as.numeric ( set [ 1 ] )
    age    <- as.numeric ( set [ 3 ] )
    
    if ( show ) print ( paste ( 'set result sex:' , sex , 'classe:' , classe , 'age:' , age ) )
    
    if ( any ( is.na ( set ) ) ) return ( NA )
    
    result <- 0
    if ( sex == 1 )
    {
        if ( classe == 1 | classe == 2 ) { result <- 1 }
        else if ( classe == 3 )          { result <- 0 }
    }
    else if ( sex == 2 )
    {
        if ( classe == 2 | classe == 3 )
        {
            if ( age <= 3 )     { result <- 1 }
            else if ( age > 3 ) { result <- 0 }
        }
        else if ( classe == 1 ) { result <- 0 }
    }
    return ( result )
}

# ----------------------------------------------------------------------------
# model ----------------------------------------------------------------------

cat ( '\n' ) ; paste ( 'exists any is.na in testset:' , any ( is.na ( testset ) ) )

resulted_Alive <- function ( IFalive ) {
    returnv  <- 0
    for ( value in testset $ Survived )

        if ( ! is.na ( value ) & value == IFalive ) { returnv <- ( returnv + 1 ) }

    return ( returnv )
}

paste ( 'testing model:' ) ; modello ( testset [ 1 , c ( 3 , 5 , 6 ) ] )

resulted_live <- 0 ; resulted_dead <- 0
for ( i in 1 : length ( testset [[ 1 ]] ) )
{
    resulted <- modello ( testset [ i , c ( 3 , 5 , 6 ) ] )
    
    if ( ! is.na ( resulted ) )
    
        if      ( resulted == 1 ) { resulted_live <- resulted_live + resulted }
        else if ( resulted == 0 ) { resulted_dead <- resulted_dead + 1        }
}

paste ( 'model->resulted live:' , resulted_live )
paste ( 'model->resulted dead:' , resulted_dead )
paste ( ' test->resulted live:' , resulted_Alive ( 1 ) )
paste ( ' test->resulted dead:' , resulted_Alive ( 0 ) )

contradiction <- matrix ( c ( 0 , 0 , 0 , 0 ) , nrow=2 , byrow = T , dimnames = list ( c ( 'Predict.live' , 'Predict.dead' ) , c ( 'Ref.live' , 'Ref.dead' ) ) )

for ( i in 1 : length ( testset [[ 1 ]] ) )
{
    resulted <- modello ( testset [ i , c ( 3 , 5 , 6 ) ] , show=F )
    
    if ( ! is.na ( resulted ) )
    {
        value <- as.numeric ( testset $ Survived [ i ] ) # auto translate 0 to 1 and 1 to 2
        
        if ( resulted == 1 )
        {
           if      ( value-1 == 1 ) { contradiction [ 1,1 ] <- ( contradiction [ 1,1 ] + 1 ) }
           else if ( value-1 == 0 ) { contradiction [ 1,2 ] <- ( contradiction [ 1,2 ] + 1 ) }
        }
        else if ( resulted == 0 )
        {
           if      ( value-1 == 1 ) { contradiction [ 2,1 ] <- ( contradiction [ 2,1 ] + 1 ) }
           else if ( value-1 == 0 ) { contradiction [ 2,2 ] <- ( contradiction [ 2,2 ] + 1 ) }
        }
    }
}

cat ( '\n' )
contradiction
cat ( '\n' )
Accuracy <- (
    contradiction [ 1,1 ] + contradiction [ 2,2 ] ) /
    length ( testset $ Survived [ ! is.na ( testset $ Survived ) ]
)

paste ( 'Accuracy:' , Accuracy ) ; cat ( '\n' )

confusionMatrix ( ctree.predict , testset $ Survived )

# make order - normalize
train.ctree.prob = 1- unlist ( treeresponse ( train.ctree , testset ) , use.names=F ) [ seq ( 1 , nrow ( testset ) * 2 , 2 ) ]
train.ctree.pred = predict ( train.ctree )
train.ctree.prob.rocr = prediction ( train.ctree.prob , testset $ Survived )

train.ctree.perf = performance ( train.ctree.prob.rocr , "tpr" , "fpr" )
train.ctree.auc.perf = performance ( train.ctree.prob.rocr , measure = "auc" , x.measure = "cutoff" )

plot ( train.ctree.perf , col = 2 , colorize = T , main = paste ( "AUC:" , train.ctree.auc.perf@y.values ) )
