# install.packages ( "tidyverse" )
# install.packages ( "psych" )
# install.packages ( "e1071" ) 
  library ( tidyverse )
  library ( e1071 )
  library ( psych )

# reject hypotesis using p value : °
# p-value = 1 - z-value
# p-value = 1 - val ( 1-a )

saved <- read.csv (
    "ttest-a.csv" , header = T ,
    stringsAsFactors = T
)
    
saved
describe ( saved )
lista <- saved [[ 1 ]]
lista

tvalue <- function(x,meany) {
return ( (mean(x)-meany) / (sd(x) / sqrt(length(x))) )}

tvalue ( lista , 0.4 )
# -0.5295018

length ( lista )

a = 0.5

# if ( tcalue > ttable ( size - 1 , avalue ) )
#        0.53 > ttable ( 9 , 0.5 )
#        0.53 > 1.83 ?
#        no , -> not reject

print ( '----------------------------------------------------' )

# for EXACTLY 40 % i am using two side test ,
# so:
#    a = 0.025
#    size - 1 = 9
#    tvalue = 0.53

# i don't know about sd ( y ) so
# ttable ( ... ) = 2.26 -> no reject

# a = 0.01 / 2 = 0.025
# ttable ( ... ) = 3.25

print ( '----------------------------------------------------' )

# summary :
#    z-value say that i have need of x% minimum
#    x = 1 - a ( a can be a * 1 or a * 1/2 )
#    z-value = z value function ,
#        get by mean , sd and standard error .
#    for accept hypothesis ( null ) made
#    in proportion by sample to population .
#    if ( %( z-value ) >= x%_minimum ) accept

#    t-value say that with size that i have
#    and with a ( minimum ) , that i want to prove
#        ( a can be a * 1 or a * 1/2 ) ,
#    using mean from population
#    i can prove only hypothesis lower than
#    t table value .
#    t table value = t ( size -1 and a choose )
#    t value = t value function ,
#        get by mean , and standard error .
#    if ( t-value < t table value ) accept
