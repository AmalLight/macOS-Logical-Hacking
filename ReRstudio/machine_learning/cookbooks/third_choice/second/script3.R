library ( doMC  )

library ( devtools )
install_github( "topepo/caret/pkg/caret" )

library ( caret )

cat ( '\n' ) ; print ( 'load on supported cores' )

registerDoMC ( cores = 4 )

# ------------------------------------------------------------

cat ( '\n' ) ; print ( 'import model by rds' )

model <- readRDS ( "production_model.rds" )

# ------------------------------------------------------------

cat ( '\n' ) ; print ( 'predict on imported data from attrition' )

unseen_data <- read.csv ( 'Attrition.csv' )

final_predictions <- predict ( model , unseen_data )

# ------------------------------------------------------------

cat ( '\n' ) ; print ( 'import data from attrition' )

mydata <- read.csv ( 'Attrition.csv' )

# ------------------------------------------------------------

cat ( '\n' ) ; print ( 'predict on imported data for Treebag' )

mydata $ EmployeeNumber = mydata $ Over18 = mydata $ EmployeeCount = mydata $ StandardHours = NULL

cvcontrol  <- trainControl ( method = "repeatedcv" , repeats = 10 , number = 10 , allowParallel = TRUE )

train.bagg <- train ( Attrition ~ . , data = mydata , method = "treebag" , B = 10 , trControl = cvcontrol , importance = TRUE )
train.bagg

# ------------------------------------------------------------

print ( ' seen:     ' )
print ( '   knn     ' )
print ( '   treebag ' )

# ------------------------------------------------------------

cat ( '\n' ) ; print ( 'fix imported data , reset it' )

mydata <- data.frame ( read.csv ( 'Attrition.csv' ) , stringsAsFactors = T )

mydata $ EmployeeNumber = mydata $ Over18 = mydata $ EmployeeCount = mydata $ StandardHours = NULL

cx <- c () ; ii <- 1

for ( name in names ( mydata ) ) {

    if ( any ( is.na ( mydata [ name ] ) ) ) print ( paste ( 'find NA in:' , name ) )
    
    if ( name != 'Attrition' ) cx <- c ( cx , ii )
    ii <- ii + 1
}

x <- mydata [ , cx ]
y <- mydata $ Attrition

# y <- y [ 1:40   ]
# y
# x <- x [ 1:40 , ]
# x

# ------------------------------------------------------------

cat ( '\n' ) ; print ( 'predict on imported data for SvmBag' )

svm.predict <- function ( object , x ) {

    if ( is.character ( lev ( object ) ) ) { # lev = levels of factor

        out  <- predict ( object , as.matrix ( x ) , type = 'probabilities' )
        
        colnames ( out ) <- lev ( object )
        rownames ( out ) <- NULL
    }
    
    else out <- predict ( object , as.matrix ( x ) ) [ , 1 ]
         out
}

bagctrl <- bagControl ( fit = svmBag $ fit , predict = svm.predict , aggregate = svmBag $ aggregate )

# fit the bagged svm model

set.seed ( 300 )

# svmbag <- train ( x , y , method = "bag" , trControl = cvcontrol , bagControl = bagctrl , allowParallel = T )
# printing the model results
# svmbag

# Something is wrong; all the Accuracy metric values are missing : see the picture made from draw.io
# that is miss.values.draw.io.png

