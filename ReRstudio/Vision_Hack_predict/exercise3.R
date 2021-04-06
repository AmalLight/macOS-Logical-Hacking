# install.packages ( "tidyverse" ) 
  library ( tidyverse )
  
saved <- read.table (
    "employee_data_2.csv" ,
    sep = "," , header = T ,
    stringsAsFactors = T ,
    dec = "." , skip = 23 ,
)

any (
    saved %>%
        is.na ()
)

saved [ 1:2 , ]

saved %>%
    arrange ( gender , last_name ) %>%
    select ( first_name , last_name , gender , title , salary ) %>%
    group_by ( title ) %>%
    filter ( salary > 70000 ) %>%
    summarise ( count = n () )

saved %>%
    select ( title , gender , salary ) %>%
    group_by ( title , gender ) %>%
    summarise ( average = mean ( salary ) , avg.monthly = mean ( salary / 12 ) ) %>%
    arrange ( gender , desc ( avg.monthly ) )
