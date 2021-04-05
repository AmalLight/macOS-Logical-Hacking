data <- read.table ( "employee_data.csv" ,
                     sep = "," ,
                     header = T ,
                     stringsAsFactors = T , 
                     dec = "." ,
                     skip = 23 ,
                     nrows = 200 )

names ( data ) <- c ( "Employee number", "First name", "Last name", "Birth date", "Gender", "Job title", "Salary", "From date", "To date" )
        data
        
write.table ( data , file = 'employee_solved.csv' ,
                     sep = ',' , dec = '.' ,
                     eol = "\n" ,
                     col.names = T ,
                     row.names = F )

read.table ( "employee_solved.csv" ,
             header = T ,
             stringsAsFactors = T , 
             sep = "," , dec = "." ,
             nrows = 200 )
