# sudo apt install -y curl libxml2-dev libcurl4-openssl-dev
# install.packages ( "tidyverse" )

library ( tidyverse )

read.table ( "pokRdex_comma.csv" ,
              sep = "," ,
              header = T ,
              stringsAsFactors = F ,
              skip = 10 ,
              nrow = 10 )