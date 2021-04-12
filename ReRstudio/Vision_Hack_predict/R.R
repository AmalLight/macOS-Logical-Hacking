# install.packages ( "tidyverse" )
# install.packages ( "e1071" )
# install.packages ( "psych" )
# install.packages ( "pastecs" ) 
  library ( pastecs )
  library ( psych )
  library ( tidyverse )
  library( e1071 )

saved <- read.csv (
    "dependent-samples.csv" ,
    header = T ,
    stringsAsFactors = T
)

# convert columns to lists
paste ( 'x:' , x <- saved [[ 1 ]] )
paste ( 'y:' , y <- saved [[ 2 ]] )

saved
describe ( saved )

dependent <- function(x,y) {
return ( mean(x-y) / (sd(x-y) / sqrt(length(x))) )}

paste ( 'my t-value:' , tvalue <- dependent (x,y) )
paste ( 'my size for p-value:' , size <- length(x)-1 )
paste ( 'my p-value considering size=' , size ,
        'and tvalue=' , tvalue ,
        'is <<a>> , a value inside' ,
        '( 0.025 and 0.01 ) so is=' , a <- 0.023 )

        paste ( 'so p-value for ttest is not 1-%' ,
                'is a , considering size like y'  ,
                'and tvalue like point of cross'  ,
                'wit x' )

t.test ( x , y , paired=T , alternative='l' )
paste ( 'alternative between: Less Greater Two-tail' )
