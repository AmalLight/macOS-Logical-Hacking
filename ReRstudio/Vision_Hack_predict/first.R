matrix1 <-
    matrix ( runif ( 12 , 5 , 8 ) , 3 , 4 , byrow = T ,
             dimnames = list ( c ( 'x' , 'y' , 'z' ) , c ( 'uno' , 'due' , 'tre' , 'quattro' ) ) )
matrix1

matrix2 <- matrix1 [ 1:2 , 1:4 ] * 10
matrix2

# matrix3 <- matrix2 - matrix1

# matrix3 <- matrix2 - matrix1 [ 1:3 , 1:3 ]

matrix3 <- matrix1 - matrix1 [ , 'uno' ]
matrix3

matrix4 <-
    matrix ( rnorm ( 12 , 5 , 8 ) , 3 , 4 , byrow = T , 
             dimnames = list ( c ( 'x' , 'y' , 'z' ) , c ( 'uno' , 'due' , 'tre' , 'quattro' ) ) )

matrix4
matrix4 * matrix1
matrix4 %*% matrix1