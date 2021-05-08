library ( e1071    )
library ( WriteXLS )

out <- data ()

# iris exists && ? grepl

any ( grepl ( "iris" , out , fixed = TRUE ) )

# all = AND
# any =  OR

save ( iris , file = "myData.RData" )
load (        file = "myData.RData" )

test.data = read.table (
   header = TRUE ,
   text   = "a b 1 2 3 4"
)

test.data

test.data = read.table (
    text = "1 2 3 4",
    col.names = c ( "a" ,"b" ) ,
    row.names = c ( "first" , "second" )
)

test.data

class ( test.data )

write.table ( test.data , file = "test.txt" , sep = " " )

write.csv ( test.data , file = "test.csv" )

csv.data = read.csv ( "test.csv" , header = TRUE , row.names = 1 )

head ( csv.data )

WriteXLS ( "iris" , ExcelFileName="iris.xls" )

