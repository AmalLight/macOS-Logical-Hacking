library ( e1071     )
library ( reshape2  )
library ( ggplot2   )
library (  car      )

data ( mtcars )

mode = function ( x ) {
   temp = table ( x )
   names ( temp ) [ temp == max ( temp ) ]
}

data ( Quartet )

str ( Quartet )

plot ( Quartet $ x , Quartet $ y1 )

lmfit = lm ( y1 ~ x , Quartet )

abline ( lmfit , col="red" )

lmfit

plot ( Quartet $ x , Quartet $ y1 )

lmfit2 = lsfit ( Quartet $ x , Quartet $ y1 )

abline ( lmfit2 , col="red" )

print ( 'different way to call lm: lsfit' ) # lmfit2

summary ( lmfit )

# -----------------------------------------------------------

paste ( 'coefficents:' )
coefficients ( lmfit ) ; cat ( '\n' )

paste ( 'coefficient confidence:' )
confint ( lmfit , level=0.95 )

cat ( '\n' )

# str ( coefficients ( lmfit ) )

x <- Quartet $ x ; hist ( x , x )

percentage <- 0.95

lower <- ( -percentage + 1 ) / 2
upper <-    percentage + lower

costant       <- coefficients ( lmfit ) [ '(Intercept)' ]
moltiplicator <- coefficients ( lmfit ) [ 'x'           ]

y1 = x * moltiplicator + costant ; hist ( y1 , y1 )
y2 = Quartet $ y1                ; hist ( y2 , y2 )

paste ( 'for y that i took: a predicted model from non normal distribution can\'t produce a normal distribution.' )

cat ( '\n' ) ; paste ( 'my coefficient confidence:' )

# 0,847 % on up
# 0,75  % on down

my.confint <- function ( model , level ) {

  print ( paste ( 'confidence:', new_level <- level / 100 ) )
  
  print ( paste ( 'lower side:' , lower_side <- ( - new_level + 1 ) / 2 ) )
  
  print ( paste ( 'n:',  n <- length ( x ) ) )
  print ( paste ( 'df:', df <- n-2 ) )

  alpha <- qt   ( lower_side , df = df )
  beta  <- coef ( model )
  
  se <- 0 ; i = 0 ; print ( '' )
  
  for ( el in beta ) {
  
      i = i + 1
  
      if ( el == beta [ 1 ] ) {

          print ( paste ( 'intercept coef:', el ) )
          
          print ( paste ( 'intercept standard error:', se <- summary ( model ) $ coefficients [ '(Intercept)' , 'Std. Error' ] ) )
          
          listloup <- list ( lower = el + alpha * se , upper = el - alpha * se )
          
          print ( paste ( 'intercept lower:' , listloup $ lower, ';', 'intercept upper:', listloup $ upper ) )
      }
      
      else {
      
          print ( paste ( 'moltiplicator coef for variable in', i-1 , 'position:', el ) )
          
          print ( paste ( 'standard error for variable in', i-1, 'pos:' , se <- summary ( model ) $ coefficients [ i , 'Std. Error' ] ) )
          
          listloup <- list ( lower = el + alpha * se , upper = el - alpha * se )
          
          print ( paste ( 'lower for variable in', i-1, 'pos:', listloup $ lower, ';', 'upper for variable in', i-1, 'pos:', listloup $ upper ) )
      }
      
      print ( '' )
  }
}
  
my.confint ( lmfit , 95 )

# standard error != standard deviation
# alpha != t value
#
# dt = pdf = study for distribution of set X == density               PDF = Density of X
#      result by percentage % about set X
#      will be useful rember that with CAMPANA
#
# pt = Cumulative Distribution                                        CDF = Integral on Fx
#      result by percentage % about Fx
#      integral using Fx
#      will be useful rember that with ESSE
#
# qt = Quantile Function
#      result a Fx about cdf ( or model if you don't have )
#      derivate of integral pt , inverse for pt !
#      will be useful rember that with ESSE CAPOVOLTA
#
# rt = random new set X from set X
#
# from https://statisticsglobe.com/student-t-distribution-in-r-dt-pt-qt-rt

# --------------------------------
# --- fitted ---------------------
# ---------------------------------

cat ( '\n' )

      fit <-  fitted ( lmfit ) ;       fit
predicted <- predict ( lmfit ) ; predicted

print ( paste ( 'fitted is predicted ?', all ( toString ( fit ) == toString ( predicted ) ) ) )

cat ( '\n' ) ; print ( paste ( 'residual:' ) )

y2 ; residuals ( lmfit )

# ---------------------------------
# --- ANOVA -----------------------
# ---------------------------------

cat ( '\n' ) ; anova ( lmfit )

print ( paste ( 'per sum sq -> sum of square pensare alla semplice variance' ) )

# F value  -> qf on pf or more advanced calculation
# percentage using F distribution --> pf or more advanced calculation

# --------------------------------
# --- vcov -----------------------
# --------------------------------

cat ( '\n' ) ; vcov ( lmfit )

print ( 'vcov = variance & covariance' )
print ( 'variance made from it self & covariance made from x and y' )

x2 <- x + costant
x3 <- x * moltiplicator

print ( 'influence:' ) ; influence ( lmfit )

# --------------------------------
# --- predict --------------------
# --------------------------------

cat ( '\n' ) ; lmfit = lm ( y1 ~ x , Quartet )

print ( 'interval like lower and upper' )

newdata = data.frame ( x = c ( 3 , 6 , 15 ) )

print ( 'lower and upper from confidence:' )
predict ( lmfit , newdata , interval = "confidence" , level = 0.95 )

print ( 'lower and upper from pridiction:' )
predict ( lmfit , newdata , interval = "predict" )

print ( 'here confidence < predict' )


