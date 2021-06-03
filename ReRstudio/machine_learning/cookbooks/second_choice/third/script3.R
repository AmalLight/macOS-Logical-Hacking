library ( e1071     )
library ( reshape2  )
library ( ggplot2   )
library (  car      )
library ( MASS      )

str ( SLID )

par ( mfrow = c ( 2 , 2 ) )

plot ( SLID $ wages ~ SLID $ language )

plot ( SLID $ wages ~ SLID $ age )

plot ( SLID $ wages ~ SLID $ education )

plot ( SLID $ wages ~ SLID $ sex )

# ------------------------------------------
# --- like gon use all in the same time ----
# ------------------------------------------

lmfit = lm ( wages ~ . , data = SLID )

summary ( lmfit )

# -----------------------------------------------------------

lmfit = lm ( wages ~ age + sex + education , data = SLID )

summary ( lmfit )

# -----------------------------------------------------------

par ( mfrow = c ( 2 , 2 ) )

plot ( lmfit )

# -----------------------------------------------------------

lmfit = lm ( log ( wages ) ~ age + sex + education , data = SLID )

plot ( lmfit )

print ( 'Theoretical Quantiles = studio su un set x come la distribuzione di predict con livello di confidenza ..% abbia incrocio su un altro parametro di cordinata y sul grafico.' )

# -----------------------------------------------------------

cat ( '\n' ) ; print ( 'glm is exactly like lm , but have family selectionable' )

lmfit1 = glm ( wages ~ age + sex + education, data = SLID , family=gaussian )

summary ( lmfit1 )

lmfit2 = lm ( wages ~ age + sex + education , data = SLID ) # previously done

anova ( lmfit1 , lmfit2 )

