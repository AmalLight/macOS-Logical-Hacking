# install.packages ( "tidyverse" )
# install.packages ( "ggplot2" )

library ( tidyverse )
library ( ggplot2   )
  
cars <- data.frame (

    Year = c ( 2 , 3 , 4 , 5 , 8 , 9 , 8 ) ,
    Size = c ( 'medium' , 'small' , 'medium' ,
               'small' , 'small' , 'medium' ,
               'extra large' ) ,
   MPG = c ( 25 , 47 , 27 , 36 , 31 , 2 , 36 ) ,
   Geerbox = c ( 'manual' , 'manual' , 'auto' ,
                 'auto' , 'manual' , 'manual' ,
                 'auto' ) ,
   Inspected = c ( 'Yes' , 'Yes' , 'No' , 'Yes' ,
                   'No' , 'No' , 'Yes' ) ,
   row.names = c ( 'VolkswagenTouraeg' ,
                   'CitroenC3' ,
                   'Audi3' ,
                   'ToyotaYaris' ,
                   'KiaForte' ,
                   'DaciaLogan' ,
                   'NissanPajero' ) ,
   stringsAsFactors = F
)

cars <- rbind ( cars , FordFusion = c ( 6 , Size = 'large' ,
                27 , 'auto' , 'Yes' ) )
cars

summary ( cars )
nrow ( cars )
ncol ( cars )
rownames ( cars )
colnames ( cars )

one <- cars [ 1 , ]

one
for ( var in one ) { print ( class ( var ) ) }

class ( diamonds )
frame <- as.data.frame(diamonds)
class ( frame )

class ( USJudgeRatings )
row_means <- rowMeans ( USJudgeRatings )
row_means