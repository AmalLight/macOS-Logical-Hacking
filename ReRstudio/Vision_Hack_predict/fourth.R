lottery <- round ( runif ( 8 , 1 , 99 ) )

momnumber <- c ( 1:8 )

momnumber
lottery

momnumber == lottery

# momnumber = lottery . like <-

differences <- function ( x , y ) 
{
    length ( setdiff ( x , y ) ) == 0 
}

differences ( momnumber , lottery )

# for ( value in lottery ) { print ( value ) } -> works with c ()

for ( v in list ( 1 , 2 , 3 ) ) { print ( v ) }

# works with list ()
