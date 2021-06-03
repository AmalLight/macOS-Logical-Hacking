library ( e1071     )
library ( reshape2  )
library ( ggplot2   )
library (  car      )
library ( MASS      )

# --------------------------------
# --- plots differences ----------
# --------------------------------

cat ( '\n' ) ; lmfit = lm ( y1 ~ x , Quartet )

par ( mfrow = c ( 2 , 2 ) )

plot ( lmfit )

# https://it.wikipedia.org/wiki/Distanza_di_Cook

print ( 'M^(-1) = (-1)^(i+j) * det( Mij )' )

plot ( cooks.distance ( lmfit ) )

plot ( Quartet $ x , Quartet $ y2 )

lmfit = lm ( Quartet $ y2 ~ poly ( Quartet $ x , 2 ) )

lines ( sort ( Quartet $ x ) , lmfit $ fit [ order ( Quartet $ x ) ] , col = "red" )

plot ( Quartet $ x , Quartet $ y2 )

# lmfit = lm ( Quartet $ y2 ~ I ( Quartet $ x ) + I ( Quartet $ x^2 ) )

# --------------------------------
# --- rlm differences ------------
# --------------------------------

cat ( '\n' ) ; print ( 'rlm plotting = auto remove outsider ( maybe from Cook )' )

plot ( Quartet $ x , Quartet $ y3 )

lmfit = rlm ( Quartet $ y3 ~ Quartet $ x )

abline ( lmfit , col = "red" )

plot ( Quartet $ x, Quartet $ y3 )

lmfit = lm ( Quartet $ y3 ~ Quartet $ x )

abline ( lmfit , col = "red" )

plot ( cooks.distance ( lmfit ) )
