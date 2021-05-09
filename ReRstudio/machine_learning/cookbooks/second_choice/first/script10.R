library ( e1071     )
library ( WriteXLS  )
library ( tidyverse )
library ( reshape   )
library ( Amelia    )
library ( stringr   )
library ( party     )
library ( partykit  )

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
from_kit <- ctree_control ( minbucket = interest_len )
train.ctree = ctree ( Survived ~ Pclass + Sex + Age + SibSp + Fare + Parch + Embarked , data = trainset , control=from_kit )

cat ( '\n \n Ended -> print the tree' ) ; train.ctree

cat ( '\n terminal node is last leaf' )
cat ( '\n inner node is like root a parent leaf \n' )

plot ( train.ctree , main="Conditional inference tree of Titanic Dataset" )

svm.model = svm ( Survived ~ Pclass + Sex + Age + SibSp + Fare + Parch + Embarked , data = trainset , probability = TRUE )
svm.model

cat ( 'Here, we use svm to show how easy it is that you can immediately use different machine',
'learning algorithms on the same dataset when using R. For further information on how to use',
'svm , please refer to Chapter 6, Classification (II) – Neural Network, SVM.', sep='\n' )

