
exercise1 <- function ( x ) 
{
    return ( ( ( x ^ 2 ) + 1 ) * 2 )
}

exercise1 ( 10 )

f <- function(x)
{
    f <- function(x)
    {
        f <- function(x)
        {
            x ^ 2
        }
        f(x) + 1
    }
    f(x) * 2
}
     
f(10)

# save a function with <- , doesn't execute it
