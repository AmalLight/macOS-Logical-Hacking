library ( doMC           )
library ( caret          )
library ( recommenderlab )
library ( data.table     )

cat ( '\n' ) ; print ( 'load on supported cores' )

registerDoMC ( cores = 4 )

# ------------------------------------------------------------

print ( ' Seen :              ' )
print ( '   Knn               ' )
print ( '   Treebag           ' )
print ( '   Svmbag      bugs  ' )
print ( '   Naive Bayes bugs  ' )
print ( '   Random Forests    ' )
print ( '   Boosting GDM      ' )
print ( '   Boosting XGB loop ' )
print ( ''                      )
print ( 'Done Stacking = 91%  ' ) 

# ------------------------------------------------------------

cat ( '\n' ) ; print ( 'import data' )

set.seed ( 54 )

data ( Jester5k )

str ( Jester5k )

print ( 'first dgCMatrix , example:' )

print ( '' )

print ( '   c1 c2 c3 c4' )
print ( 'r1  .  .  .  2' )
print ( 'r2  6  . -1  5' )
print ( 'r3  .  4  3  .' )
print ( 'r4  .  .  5  .' )

print ( '' )

print ( paste ( 'source:' , 'r-bloggers.com/2020/03/what-is-a-dgcmatrix-object-made-of-sparse-matrix-format-in-r' ) )

print ( 'x, slot about non-zero elemnts , in this case : [ 6 , 4 , -1 , 3 , 5 , 2 , 5 ]' )

print ( 'i, slot about non-zero elements index , starting to count from 0 tor nrow-1 by the top of each columns , in this case : [ 1 , 2 , 1 , 2 , 3 , 0 , 1 ]' )

print ( '' )
print ( '. as 0' )
print ( '' )

print ( 'p, slot about where cn0s is coount-non-zero-elements :: cn0s ( i ) = cn0s ( i+2 ) - cn0s ( i+1 ).' )
print ( '        , starting to count from 0 to ncol-1 for each columns.'                                    )
print ( '        , count-non-zero ( j ) = sum ( i=0:j , non-zero ( i ) ).'                                  )

print ( '        , in this case : [ 0 , 1 , 2 , 5 , 7 ] , the first value define the value used for start to count.' )

print ( '' ) ; print ( 'Dim , 4x4' )
               print ( 'Dimnames:List of 2 , chr [1:4] r1 r2 r3 r4 ; chr [1:4] c1 c2 c3 c4.' )

print ( '' ) ; print ( 'source 2 : rdrr.io/cran/recommenderlab/man/realRatingMatrix-class.html' )

# ------------------------------------------------------------

cat ( '\n' ) ; print ( 'view head of 5:' )

head ( getRatingMatrix ( Jester5k ) ,5 )

cat ( '\n' ) ; print ( 'view nratings information:' )

print ( nratings ( Jester5k ) )

cat ( '\n' ) ; print ( 'summary:' )

print ( summary ( rowCounts ( Jester5k ) ) )

hist ( getRatings ( Jester5k ) , main = "Distribution of ratings" )

cat ( '\n' ) ; print ( 'other string dataset' )

head ( JesterJokes , 5 )

best <- which.max ( colMeans ( Jester5k ) )

cat ( JesterJokes [ best ] )

cat ( '\n' ) ; print ( 'evaluationScheme with train and given' )

Jester5k_es <- evaluationScheme ( Jester5k , method = "split" , train = 0.8 , given = 20 , goodRating = 0 )

# verifying if the train - test was done successfully

print( Jester5k_es )

cat ( '\n' )
cat ( '\n' ) ; print ( 'di 0.8 dataset prendi 20 valutazioni , dove i valutati sono le colonne e i valutatori sono le righe o viceversa' )

