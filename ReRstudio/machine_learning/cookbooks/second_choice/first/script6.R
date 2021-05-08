library ( e1071     )
library ( WriteXLS  )
library ( tidyverse )
library ( reshape   )
library ( Amelia    )

# https://www.kdnuggets.com/datasets/index.html

getwd ()

train.data <- read.csv ( './titanic/train.csv' , na.strings=c ( "NA" , "" ) )
str ( train.data )

paste ( 'factoring number to string' )
train.data $ Survived = factor ( train.data $ Survived )
train.data $ Pclass   = factor ( train.data $ Pclass   )

str ( train.data )

# Talking about statistics, there are four measurements:
# nominal, ordinal, interval, and ratio.
#
# Nominal variables  : are used to label variables, such as gender and name; 
# ordinal variables  : are measures of non-numeric concepts, such as satisfaction and happiness.
# Interval variables : shows numeric scales, which tell us not only the order but can also show the differences between the values, such as temperatures in Celsius.

# ratio variable     : shows the ratio of a magnitude of a continuous quantity to a unit magnitude.
# Ratio variables provide order, differences between the values, and a true zero value, such as weight and height.

# In R different measurements are calculated differently, so you should perform a type conversion
# before applying descriptive or inferential analytics toward the dataset.

# you can see that Survived (0 = No; 1 = Yes) and Pclass (1 = 1st; 2 = 2nd; 3 = 3rd) are categorical variables.
# As a result, we transform the data from a character to a factor type via the factor function.

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
# --- CAST ---------------------------------------------------------------------------------|
# ------------------------------------------------------------------------------------------|
# Besides factor, there are more type conversion functions. For numeric types, there are ---|
# is.numeric() and as.numeric() ; for character, there are: is.character() and -------------|
# as.character() . For vector, there are: is.vector() and as.vector() ; for matrix, there --|
# are is.matrix() and as.matrix() . Finally, for data frame, there are: is.data.frame() ----|
# and as.data.frame() . --------------------------------------------------------------------|
# ------------------------------------------------------------------------------------------|
# ------------------------------------------------------------------------------------------|
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|

paste ( 'if all (and) : ' , all ( is.na ( train.data $ Age ) ) ) # if all (and)
paste ( 'if one ( or) : ' , any ( is.na ( train.data $ Age ) ) ) # if one ( or)

paste ( 'auto factor is.na with sum : ' , sum ( is.na ( train.data $ Age ) ) )
paste ( 'percentage  is.na with sum : ' , sum ( is.na ( train.data $ Age ) ) / length ( train.data $ Age ) )

sapply ( train.data , function ( df ) {

    sum ( is.na ( df ) ) / length ( df ) } )

print   ( 'Missing Map saved in Rplots'   )
missmap ( train.data , main="Missing Map" )

# AmeliaView () # for what ??

table ( train.data $ Embarked , useNA = "always" )

paste ( 'Fix NA values' )
train.data$Embarked [ which ( is.na ( train.data$Embarked ) ) ] = 'S'
table ( train.data $ Embarked , useNA = "always" )

