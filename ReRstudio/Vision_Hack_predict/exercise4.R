# install.packages ( "tidyverse" ) 
  library ( tidyverse )
  library ( sjmisc )
  library ( readr )
  
saveIT <- read.table ( "weather_untidy.csv" ,
                        sep = "," , dec = "." ,
                        header = T )
saveIT <-
as_tibble ( saveIT ) %>%
    gather ( d1:d31 , key = days , 
                      value = value ,
                      na.rm = T ) %>%
    
    spread ( key = element , value = value ) %>%
    spread ( key = year , value = month  ) %>%
    arrange ( `2010` )

new_col <- str_replace_all (
    paste (
        saveIT [ 1 , ][[ 1 ]] , 
        '-' ,
        colnames ( saveIT )[[ 5 ]]
    ) ,
    ' ' , ''
)

colnames ( saveIT ) <- c ( 'id' , 'days' , 'TMAX' ,
                           'TMIN' , new_col )
saveIT $ id <- NULL
saveIT

# -------------------------------------------------------

saveIT2 <- as_tibble (
    read.table (
        "tb_untidy.csv" ,
         sep = "," , dec = "." ,
         header = T ,
         stringsAsFactors = T
     )
)

saveIT2 <-
saveIT2 %>%
    filter ( ! is.na ( country ) ) %>%
    gather ( m04:fu , key = groups , 
             value = value , na.rm = T )

saveIT2 $ groups <- str_replace_all ( saveIT2 $ groups , 'f0' , 'f'  )
saveIT2 $ groups <- str_replace_all ( saveIT2 $ groups , 'm0' , 'm'  )
saveIT2 $ groups <- str_replace_all ( saveIT2 $ groups , 'f'  , 'f_' )
saveIT2 $ groups <- str_replace_all ( saveIT2 $ groups , 'm'  , 'm_' )

saveIT2 <-
saveIT2 %>%
    separate ( groups , into = c ( 'sex' , 'group' ) , sep = '_' ) %>%
    unite ( mix , c ( sex , value ) , sep = '_' )

saveIT2 $ year <- NULL

saveIT2_m <-
    group_by ( saveIT2 , country , group ) %>%
    mutate ( m = str_contains ( mix , 'm_' ) ) %>%
    filter ( m ) %>%
    mutate ( value = parse_number( str_replace_all ( mix , 'm_' , '' ) ) ) %>%
    filter ( value > 0 ) %>%
    summarise ( Total_m = sum ( value ) )
    
saveIT2_f <-
    group_by ( saveIT2 , country , group ) %>%
    mutate ( f = str_contains ( mix , 'f_' ) ) %>%
    filter ( f ) %>%
    mutate ( value = parse_number( str_replace_all ( mix , 'f_' , '' ) ) ) %>%
    filter ( value > 0 ) %>%
    summarise ( Total_f = sum ( value ) )

saveIT2_m
saveIT2_f
saveIT2_mf <- merge ( x=saveIT2_m , y=saveIT2_f ,
                      by=intersect ( names ( saveIT2_m ) ,
                                     names ( saveIT2_f ) ) ,
                      all=T )

saveIT2_mf[ is.na ( saveIT2_mf ) ] <- 0
saveIT2_mf %>%
    as_tibble ( saveIT2_mf )

write.table ( saveIT2_mf , file = 'tb_untidy_solved.csv' ,
              sep = ',' , dec = '.' ,
              col.names = T ,
              row.names = F )