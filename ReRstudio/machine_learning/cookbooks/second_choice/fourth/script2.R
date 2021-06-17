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

ind = cut ( 1:nrow ( churnTrain ) , breaks = 10 , labels = F )
ind

svm.cross <- function ( algorithm ) {

    accuracies = c () ; fit = null

    for ( i in 1:10 ) {

        
        if ( algorithm > 0 ) fit = naiveBayes ( churn ~ . , churnTrain [ ind != i , ] )
        else                 fit = svm        ( churn ~ . , churnTrain [ ind != i , ] ) # modello

        predictions = predict ( fit , churnTrain [ ind == i , ! names ( churnTrain ) %in% c ( "churn" ) ] ) # fit=model on dataset=churnTrain[x,y]

        testset = churnTrain [ ind == i , c ( "churn" ) ] # get testset
    
        correct_count = sum ( as.data.frame ( predictions ) == testset ) # count sum for good prediction

        accuracies = append ( correct_count / nrow ( testset ) , accuracies )
    }
    
    print (        accuracies   )
    print ( mean ( accuracies ) )
    
    return ( accuracies )
}

cat ( '\n' ) ; print ( 'Performing cross-validation with the e1071 package' )

tuned = tune.svm ( churn ~ . , data = churnTrain , gamma = 10^-2 , cost = 10^2 , tunecontrol = tune.control ( cross = 10 ) )

# Performing cross-validation with the caret package
# control = trainControl ( method = "repeatedcv" , number = 10 , repeats = 3 ) another control for make automatic this 10 cross
