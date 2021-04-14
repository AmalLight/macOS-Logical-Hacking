# install.packages ( "tidyverse" )
# install.packages ( "ggplot2" ) 
  library ( ggplot2 ) 
  library ( tidyverse )

save <-
read.csv ( 'regression_example.csv' , 
            header = T ,
            stringsAsFactors = T )
              
as_tibble ( save )

vars <- function(x) {return ( sum( (x-mean(x))^2) / (length(x)-1) )}
sds <- function(x) {return ( sqrt( vars(x) ) )}
cvs <- function(x) {return ( sds(x) / mean(x) )}
cov2 <- function(x,y) {return ( sum((x-mean(x))*(y-mean(y))) / (length(x)-1) )}
cor2 <- function(x,y) {return ( cov(x,y) / (sds(x)*sds(y)) )}

paste ( 'variance x:' , varx <- vars ( x <- save [[ 1 ]] ) )
paste ( 'variance x:' , vary <- vars ( y <- save [[ 2 ]] ) )

paste ( 'standard deviation x:' , sdx <- sds ( x ) )
paste ( 'standard deviation y:' , sdy <- sds ( y ) )

paste ( 'coeficent of variation x:' , cvx  <- cvs ( x ) )
paste ( 'coeficent of variation y:' , cvy  <- cvs ( y ) )

paste ( 'covariance  of xy:' , cov <- cov2 ( x , y ) )
paste ( 'correlation of xy:' , cor <- cor2 ( x , y ) )

x~y

paste ( 'y~x' ,
        'like space from y and x' ,
        'for independent variables' ,
        'like y=c+x*v' )

summary ( val_lm <- lm ( y~x ) )

sep <- function() {
print ( '' )
print ( '----------------------------------------------------' )
print ( '' ) } ; sep ()

save2 <-
read.csv ( 'real_estate_price_size_year_view.csv' , 
            header = T ,
            stringsAsFactors = T )
            
save2 <- as_tibble ( save2 )
str ( save2 )
save2

plot1 <-
save2 %>%
    filter ( view == 'Sea view' ) %>%
    arrange ( size ) %>%
    select ( size , price )

plot2 <-
save2 %>%
    filter ( view == 'No sea view' ) %>%
    arrange ( size ) %>%
    select ( size , price )

plot3 <-
save2 %>%
    arrange ( year ) %>%
    group_by ( year ) %>%
    summarise ( total = sum ( price ) )

plot4 <-
save2 %>%
    arrange ( size ) %>%
    group_by ( size ) %>%
    summarise ( total = sum ( price ) )
    
print ( 'Sea view' )
plot1
sep ()
print ( 'No sea view' )
plot2
sep ()
print ( 'by year' )
plot3
sep ()
print ( 'by size' )
plot4

sep ()

save_plot_lm <- function (flag,matrix,file) {
xnames <- colnames ( matrix ) [ 1 ]
ynames <- colnames ( matrix ) [ 2 ]
xvalues <- matrix [[ 1 ]]
yvalues <- matrix [[ 2 ]]
ggplot ( matrix , aes ( xvalues , yvalues ) ) +
geom_point () + theme_light () +
labs ( x = xnames , y = ynames , title = flag ) +
stat_smooth ( method = 'lm' , se = FALSE )
ggsave ( file , plot = last_plot () ) }

save_plot_lm ( 'See view' ,
plot1 , 'linear_regression/plots/seaview.png' )
summary ( lm ( price~size , data=plot1 ) )

save_plot_lm ( 'No See view' ,
plot2 , 'linear_regression/plots/noseaview.png' )
summary ( lm ( price~size , data=plot2 ) )

save_plot_lm ( 'By year' ,
plot3 , 'linear_regression/plots/byYear.png' )
summary ( lm ( total~year , data=plot3 ) )

save_plot_lm ( 'By size' ,
plot4 , 'linear_regression/plots/bySize.png' )
summary ( lm ( total~size , data=plot4 ) )

sep ()

