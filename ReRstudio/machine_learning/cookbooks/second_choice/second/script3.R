library ( e1071     )
library ( tidyverse )
library ( reshape2  )
library ( stringr   )
library ( party     )
library ( ggplot2   )

data ( mtcars )
mode = function ( x ) {
   temp = table ( x )
   names ( temp ) [ temp == max ( temp ) ]
}

cat ( '\n' ) ; print ( 'cor:' ) ; cor ( mtcars )

qplot ( x=Var1 , y=Var2 , data = melt ( cor ( mtcars ) ) , fill=value , geom="tile" )

cat ( '\n' ) ; print ( 'lm:' )
lmfit = lm ( mtcars $ mpg ~ mtcars $ cyl )
lmfit

costant <- lmfit $ coefficients [ 1 ]
costant

moltiplicator_for_cyl <- lmfit $ coefficients [ 2 ]
moltiplicator_for_cyl

cat ( '\n' ) ; print ( 'summary lm:'  ) ; summary ( lmfit )
cat ( ''   ) ; print ( 'summary mpg:' ) ; summary ( mtcars $ mpg )
cat ( '\n' ) ; print ( 'summary cyl:' ) ; summary ( mtcars $ cyl )

cat ( '\n' ) ; print ( 'Anova:' ) ; anova ( lmfit )

plot ( mtcars $ cyl , mtcars $ mpg ) ; abline ( lmfit )

paste ( 'Anova DF :' , df <- 1 )

paste (
    'Anova SQ = sum ( ( cyl * var4cyl - mean ( cyl * var4cyl ) ) ^ 2 ) :' , sq <-
    sum ( ( mtcars $ cyl * moltiplicator_for_cyl - mean ( mtcars $ cyl * moltiplicator_for_cyl ) ) ^ 2 )
)

paste (
    'Anova SQ mean = sum ( ( cyl * var4cyl - mean ( cyl * var4cyl ) ) ^ 2 ) / DF :' , 
    sqm <- sq / df
)

paste ( 'Anova DF For All = length ( cyl ) -1 - DF :' , df_all <- length ( mtcars $ cyl ) - 1 - df )

paste (
   'Anova Error Square = sum ( ( mpg - ( cyl * molt4cyl + costant ) ) ^ 2 )' ,  error_sq <-
   sum ( ( mtcars $ mpg - ( mtcars $ cyl * moltiplicator_for_cyl + costant ) ) ^ 2 )
)

paste ( 'Anova Error Square mean = Error Square / DF for All' ,  error_mean <- error_sq / df_all )

paste ( 'Anova F value = SQ mean / Error Square mean :' , fvalue <- sqm / error_mean )

paste (
    'Anova P value = pf is (F-statistic=F-value) on DF and DF For ALL ==' ,
    'pf is' , fvalue , 'on' , df , 'and' , df_all , ':' ,
    pvalue <- sqrt ( pf ( fvalue , df , df_all , lower.tail = T , log.p = T ) ^ 2 )
)

#
# * lower.tail: logical; if TRUE (default), probabilities are P[X <= x] ,
#   otherwise, P[X > x].
#
# log, log.p: logical; if TRUE, probabilities p are given as log(p).
#

