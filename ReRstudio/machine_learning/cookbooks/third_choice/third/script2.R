library ( doMC  )
library ( tidyr )

cat ( '\n' ) ; print ( 'load on supported cores' )

registerDoMC ( cores = 4 )

# ------------------------------------------------------------

cat ( '\n' ) ; print ( 'NLP' )

reviews_text <- readLines ( 'train.csv', n = 1000 )

reviews_text <- data.frame ( reviews_text )

print ( reviews_text [ 1:5 , ] )

reviews_text <- separate ( data = reviews_text , col = reviews_text , into = c ( "Sentiment" , "SentimentText" ) , sep = 4 )

print ( reviews_text [ 1:5 , ] )

# ------------------------------------------------------------

cat ( '\n' ) ; print ( 'Manipulate the text' )

# Retaining only alphanumeric values in the sentiment column
 
reviews_text$Sentiment <- gsub ( "[^[:alnum:] ]" , "" , reviews_text $ Sentiment )

# Retaining only alphanumeric values in the sentiment text

reviews_text$SentimentText <- gsub ( "[^[:alnum:] ]" , "" , reviews_text $ SentimentText )

# Replacing multiple spaces in the text with single space

reviews_text $ SentimentText <- gsub ( "(?<=[\\s])\\s*|^\\s+|\\s+$" , "" , reviews_text $ SentimentText , perl = TRUE )

# Viewing the dataset

print ( reviews_text [ 1:5 , ] )

# Writing the output to a file that can be consumed in other projects

write.table ( reviews_text , "Dataset.csv" , row.names = F , col.names = T , sep = ',' )

# ------------------------------------------------------------

cat ( '\n' ) ; print ( 'Manipulate the text' )
