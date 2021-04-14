# install.packages ( "tidyverse" )
# install.packages ( "ggplot2" ) 
  library ( ggplot2 ) 
  library ( tidyverse )

matrix <-
read.csv ( 'regression_example.csv' , 
            header = T ,
            stringsAsFactors = T )
              
as_tibble ( matrix )
x <- matrix [[ 1 ]]
y <- matrix [[ 2 ]]

paste ( 'y~x' ,
        'like space from y and x' ,
        'for independent variables' ,
        'like y=c+x*v' )

save_plot_lm <- function (flag,matrix,file) {
xnames <- colnames ( matrix ) [ 1 ]
ynames <- colnames ( matrix ) [ 2 ]
xvalues <- matrix [[ 1 ]]
yvalues <- matrix [[ 2 ]]
ggplot ( matrix , aes ( xvalues , yvalues ) ) +
geom_point () + theme_light () +
labs ( x = xnames , y = ynames , title = flag ) +
stat_smooth ( method = 'lm' , se = FALSE )
ggsave ( file , plot = last_plot () ) }

summary ( val_lm <- lm ( y~x ) )

save_plot_lm (
'GPA for student carrer' ,
matrix ,
'linear_regression/plots/GPAbySAT.png' )

sep <- function() {
print ( '' )
print ( '----------------------------------------------------' )
print ( '' ) }

sep ()

# str ( val_lm )

paste ( 'costant:'  , c <- val_lm $ coefficients [ 1 ] )
paste ( 'variable:' , v <- val_lm $ coefficients [ 2 ] )

paste ( 'y calculated:' )
paste ( y2 <- ( ( x * v ) + c ) )

sse <- function(ytrue,ylm) {return (sum ( ( y2 - y ) ^ 2 ) )}
ssr <- function(ytrue,ylm) {return (sum (( y2 - mean(y) )^2) )}
sst <- function(sse,ssr) {return ( ssr + sse )}
rsquare <- function(ssr,sst) {return ( ssr / sst )}

sep ()

paste ( 'sse:' , ssey2 <- sse ( y , y2 ) )

paste ( 'ssr:' , ssry2 <- ssr ( y , y2 ) )

paste ( 'sst:' , ssty2 <- ssey2 + ssry2 )

paste ( 'r-square:' , rsquare <- ssry2 / ssty2 )

SST <- function() {}
