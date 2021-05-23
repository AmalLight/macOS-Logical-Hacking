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

# test for binomial

# won 92 out of 315 games
# binom.test ( x=92 , n=315 , p=1/6 )

kdone=92 ; number=315 ; prob=1/6

binom.test ( x=kdone , n=number , p=prob , alternative='two.sided' )

print ( paste ( 'where p is probability of roll one face of six of the dice' ) )

# ----------------------------------------------------------------------------------------------
# ----------------------------------------------------------------------------------------------

cat ( '\n' )

paste ( 'probability for all is the sum of indipendent event with prob=1/6 so =' )

paste ( 'probability of success =' , success <- prob )

paste ( 'probability of failure =' , failure <- 1-prob )

paste ( 'P ( X = k ) = combo ( n k ) == n! / ( (n - k)! * k! ) * p^k * q^( n − k ) =' )

paste ( 'part 1 * part 2 -->' )

paste ( 'part 1 :' )

paste ( '    ' , number , '! / ( (' , number , '-' , kdone , ') ! *' , kdone , '! ) =' )

paste ( '    ' , factorial(number) / ( factorial(number - kdone) * factorial(kdone) ) , '=' )

paste ( '    ' , part1 <- choose ( number , kdone ) , 'fix using choose (' , number , ',' , kdone , ') . function where numbers are too much big.' )

paste ( 'part 2 where q = (1-p):' )

paste ( '    ' , part2 <- ( ( success ^ kdone ) * ( failure ^ (number-kdone) ) ) )

paste ( 'result for 92 times of success from 315 trials, is:' , result <- part1 * part2 )
paste ( 'the result communicate with us that is probable the dice was be biased.'  )

