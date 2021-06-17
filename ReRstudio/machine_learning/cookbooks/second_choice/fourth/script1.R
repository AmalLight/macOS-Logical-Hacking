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

accuracies = c ()

for ( i in 1:10 ) {

    fit = svm ( churn ~ . , churnTrain [ ind != i , ] ) # modello

    predictions = predict ( fit , churnTrain [ ind == i , ! names ( churnTrain ) %in% c ( "churn" ) ] ) # fit=model on dataset=churnTrain[x,y]

    testset = churnTrain [ ind == i , c ( "churn" ) ] # get testset
    
    correct_count = sum ( as.data.frame ( predictions ) == testset ) # count sum for good prediction

    accuracies = append ( correct_count / nrow ( testset ) , accuracies )
}

accuracies ; mean ( accuracies )
