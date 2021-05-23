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

wilcox.test ( mpg ~ am , data = mtcars )

boxplot ( mtcars $ mpg ~ mtcars $ am , xlab = '' , ylab = 'mpg' , names = c ( 'automatic' , 'manual' ) )

cat ( '\n colnames:' ) ; colnames ( mtcars ) ; cat ( '\n' )

paste ( 'sorted mpg values:' ) ; mpgs <- mtcars $ mpg ; mpgs
paste ( 'total mpg:' , length ( mtcars $ mpg ) ) ; cat ( '\n' )

  cat ( 'unique am:' ) ; unique ( mtcars $ am ) ;
paste ( 'binary for am: automatic and manual' ) ; cat ( '\n' )

paste ( 'sorted mpg where am == 0:' ) ; mpgs0 <- mtcars $ mpg [ mtcars $ am == 0 ]     ; sort ( mpgs0 )
paste (  'total mpg where am == 0:'   , length ( mtcars $ mpg [ mtcars $ am == 0 ] ) ) ;  cat ( '\n'  )

paste ( 'sorted mpg where am == 1:' ) ; mpgs1 <- mtcars $ mpg [ mtcars $ am == 1 ]     ; sort ( mpgs1 )
paste (  'total mpg where am == 1:'   , length ( mtcars $ mpg [ mtcars $ am == 1 ] ) ) ;  cat ( '\n'  )

# -----------------------------------------------------------------------------------------------------------
# ---------------------- Wilcoxon Rank Sum --- == --- Mann-Whitney U-test) ----------------------------------
# -----------------------------------------------------------------------------------------------------------

w <- 0

for ( value0 in mpgs0 )

    for ( value1 in mpgs1 ) {
    
        if      ( value1  < value0 ) { w <- w + 1   }
        else if ( value1 == value0 ) { w <- w + 1/2 }
        else if ( value1  > value0 ) { w <- w + 0   }
    }
    
paste ( 'wikipedia w:' , w )
paste ( 'wikipedia :: https://en.wikipedia.org/wiki/Mann%E2%80%93Whitney_U_test' )

# -----------------------------------------------------------------
# -----------------------------------------------------------------
# --- https://en.wikipedia.org/wiki/Mann%E2%80%93Whitney_U_test ---
# sono due dei più potenti test non parametrici per verificare,
# in presenza di valori ordinali provenienti da una distribuzione continua,
# se due campioni statistici provengono dalla stessa popolazione.
# -----------------------------------------------------------------
# -----------------------------------------------------------------

cat ( '\n' ) ; paste ( w , 'is enought ?' )

