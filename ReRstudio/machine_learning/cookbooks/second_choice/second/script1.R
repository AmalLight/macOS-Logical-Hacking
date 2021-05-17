library ( e1071     )
library ( tidyverse )
library ( reshape   )
library ( stringr   )
library ( party     )

# pag 88

z_scores <- seq ( -3 , 3 , by = .1 )
z_scores

p_values <- pnorm ( z_scores )
p_values

z_scores <- qnorm ( p_values )
z_scores

# qnorm inverse for pnorm

# probability density function = f ( x|μ , σ ) = 1 / ( σ * sqrt ( 2 * π ) ) * e ^ ( - ( x - μ )^2 / 2 * σ^2 )
# z-score == z-value == y <- dnorm ( x )
# more options : dnorm ( 0, mean = 3 , sd = 5 )

curve ( dnorm , -3 , 3 )
curve ( pnorm , -3 , 3 )
curve ( qnorm , -3 , 3 )

set.seed ( 50 )
x1 <- rnorm ( 100 , mean = 3 , sd = 5 )
hist ( x1 )

# uniform distribution

set.seed ( 50 )
x2 <- runif ( 100 , 0 , 5 )
hist ( x2 )

shapiro.test ( x1 )

# From the output ,
# the p-value > 0.05 implying that the distribution of the data are not significantly different from normal distribution .
# In other words , we can assume the normality.

shapiro.test ( x2 )

# From the output ,
# the p-value > 0.05 implying that the distribution of the data are not significantly different from normal distribution .
# In other words , we can assume the normality.

# in SHORT:

# dnorm , a probability density function, which returns the height = y

# pnorm , can generate the area under a given value .
# also used to calculate the p-value from a normal distribution .

# qnorm returns the z-score of a given probability .

# Without any other arguments specified ,
# it is assumed that the normal distribution use a mean of zero and a standard deviation of one .

# rnrom function to generate random samples from a     normal distribution .
# runif function to generate random samples from a not normal distribution .

# Shapiro-Wilks test : p-value > 0.05 = normal distribution .

