# install.packages ( "tidyverse" )
# install.packages( "e1071" ) 
  library ( tidyverse )
  library( e1071 )

saved <- as_tibble (
    read.table (
        "ztest-a.csv" , header = T ,
        stringsAsFactors = T ,
        sep = "," , dec = "."
    )
)

x <- saved [[ 1 ]] # convert column to list

summary ( saved )
saved

# sample mean : 100.200
# population mean we want : 113k
# sd of mean : 15k

standarizexy <- function(x,meany,sdy) {
return ( (mean(x)-meany) / sex( sdy,length(x) ) )}
sex <- function(sdx,len) {return ( sdx / sqrt(len) )}

standarized <- standarizexy ( x , 113000 , 15000 )

sdtest <- sd ( x )
sdtest # is close to 15k

if ( standarized < 0 ) standarized <- standarized * -1

sep <- sex ( 15000 , 30 )
sep # is close to 2739k

# test done for two side of test , 0.05 / 2 ,
# if z < corresponding ( 1 - 0.05 / 2 ) so reject
#    z < corresponding ( 0.9750 ) ?
#    z < 1.6
# no so hypothesis cannot be rejected , so it is accepted .