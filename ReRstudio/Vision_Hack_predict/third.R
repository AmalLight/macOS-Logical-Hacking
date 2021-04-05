lista <- list (

    c ( 1 , 3 , 5 , 7 , 9 , 11 ) ,
    list (

        c ( "Happy Birthday" ) ,
        c ( 'Archery' )
    )
)

lista

numbers <- lista [[ 1 ]]
numbers
strings <- lista [[ 2 ]] [[ 1 ]]
strings
lista2  <- lista [[ 2 ]] [ 2 ]
lista2
lista3 <- lista [ 2 ]
lista3
lista4 <- lista [ 1 ]
lista4

print ( '-------------------------- ' )
print ( '-------------------------- ' )

lista [[ 1 ]] <- numbers + 2

names ( lista ) <- c ( 'numbers' , 'phrases' )
lista $ numbers <- lista $ numbers + 2

lista [ 'numbers' ]
lista [ 'phrases' ]

print ( '-------------------------- ' )
print ( '-------------------------- ' )

lista [[ 'Brands' ]] <- c ( 'Kellogs' , 'Nike' , 'iPhone' )
lista [[ 'Brands' ]] <- NULL
lista
