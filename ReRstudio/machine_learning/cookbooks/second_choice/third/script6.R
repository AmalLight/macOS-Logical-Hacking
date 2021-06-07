library ( e1071     )
library ( reshape2  )
library ( ggplot2   )
library ( caret     )
library ( party     )
library ( class     )
library ( car       )
library ( modeldata )
library ( neuralnet )
library ( nnet      )

pdf ( file = 'Rplots.pdf' , onefile = T , paper = 'A4r' , width=80 , height=80 )

data ( mlc_churn )

churnTrain = mlc_churn [ , ! names ( mlc_churn ) %in% c ( "state" , "area_code" , "account_length" ) ]

set.seed ( 2 )

ind = sample ( 2 , nrow ( churnTrain ) , replace = TRUE, prob = c ( 0.7 , 0.3 ) )

trainset = churnTrain [ ind == 1, ]
testset  = churnTrain [ ind == 2, ]

model = svm ( churn ~ . , data = trainset , kernel = "radial" , cost = 1 , gamma = 1 / ncol ( trainset ) )

summary ( model )

# kernel: the kernel used in training and predicting. You might
#         consider changing some of the following parameters, depending
#         on the kernel type.
#          linear: u'*v
#          polynomial: (gamma*u'*v + coef0)^degree
#          radial basis: exp(-gamma*|u-v|^2)
#          sigmoid: tanh(gamma*u'*v + coef0)

print ( 'Kernel is like family for glm ?' )

# The cost parameter penalizes large residuals.
# So a larger cost will result in a more flexible model with fewer misclassifications.
# In effect the cost parameter allows you to adjust the bias/variance trade-off.
# The greater the cost parameter, the more variance in the model and the less bias.
# So the answer to your question is no. The greater the cost, the fewer misclassifications are allowed.

print ( 'Costs : costant cost ? The greater the cost, the fewer misclassifications are allowed.' )
print ( 'misclassifications = bias and family and link ...' )

# Gamma parameter needed for all kernels except ‘linear’ (default: 1/(data dimension))
# So here Gamma and sigma are the same things.
# Gamma is a hyperparameter which we have to set before training model. Gamma decides that how much curvature we want in a decision boundary.
# Gamma high means more curvature.
# Gamma low means less curvature.

print ( 'Gamma is a part of Kernel' )

#
# -------------------------
# --- another model -------
# -------------------------
#
# Another popular support vector machine tool is SVMLight . Unlike the e1071 package, which
# provides the full implementation of libsvm , the klaR package simply provides an interface
# to SVMLight only. To use SVMLight , one can perform the following steps:
#
# 1. Install the klaR package:
# > install.packages("klaR")
# > library(klaR)
#
# 2. Download the SVMLight source code and binary for your platform from http://
# svmlight.joachims.org/ . For example, if your guest OS is Windows 64-bit, you
# should download the file from http://download.joachims.org/svm_light/
# current/svm_light_windows64.zip .
#
# 3. Then, you should unzip the file and put the workable binary in the working directory;
# you may check your working directory by using the getwd function:
# > getwd()
#
# 4. Train the support vector machine using the svmlight function:
# > model.light = svmlight(churn~., data = trainset,
# kernel="radial", cost=1, gamma = 1/ncol(trainset))
#

iris.subset = subset ( iris , select = c ( "Sepal.Length" , "Sepal.Width" , "Species" ) , Species %in% c ( "setosa" , "virginica" ) )

plot ( x = iris.subset $ Sepal.Length , y = iris.subset $ Sepal.Width , col = iris.subset $ Species , pch = 19 )

svm.model = svm ( Species ~ . , data=iris.subset , kernel='linear' , cost=1 , scale = FALSE )

points ( iris.subset [ svm.model $ index , c ( 1 , 2 ) ] , col = "blue" , cex = 2 )

w =  t ( svm.model $ coefs ) %*% svm.model $ SV

b = -svm.model $ rho

abline ( a = - b / w [ 1 , 2 ] , b = - w [ 1 , 1 ] / w [ 1 , 2 ] , col = "red" , lty = 5 )

data ( iris )

model.iris = svm ( Species ~ . , iris )

svm ( Species ~ . , iris )

plot ( model.iris , iris , Petal.Width ~ Petal.Length , slice = list ( Sepal.Width = 3 , Sepal.Length = 4 ) )

plot ( model , trainset , total_day_minutes ~ total_intl_charge )

model

svm.pred  = predict (    model , testset [ , ! names ( testset ) %in% c ( "churn" ) ] )
svm.table =   table ( svm.pred , testset $                                 churn  )
svm.table

cat ( '\n' )

print ( paste ( 'accuracy:' , ( svm.table [ 1,1 ] + svm.table [ 2,2 ] ) / sum ( svm.table ) ) )

print ( 'remember 94% with tree decision' ) ; cat ( '\n' )

# tuned = tune.svm ( churn ~ . , data = trainset , gamma = 10 ^ ( -6 : -1 ) , cost = 10 ^ ( 1 : 2 ) )
# tuned
# 0.01  100

model.tuned = svm ( churn ~ . , data = trainset , gamma = 0.01 , cost = 100 )


svm.tuned.pred  = predict ( model.tuned , testset [ , ! names ( testset ) %in% c ( "churn" ) ] )
svm.tuned.table = table ( svm.tuned.pred , testset $ churn )
svm.tuned.table

cat ( '\n' )

print ( paste ( 'accuracy svm tuned:' , ( svm.tuned.table [ 1,1 ] + svm.tuned.table [ 2,2 ] ) / sum ( svm.tuned.table ) ) )


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

cat ( '\n' ) ; print ( 'Other neural network R , using neurlanet' )

data( iris )

ind = sample ( 2 , nrow ( iris ) , replace = TRUE, prob = c ( 0.7 , 0.3 ) )

trainset = iris [ ind == 1 , ]
testset  = iris [ ind == 2 , ]

trainset $ setosa     = trainset $ Species == "setosa"
trainset $ virginica  = trainset $ Species == "virginica"
trainset $ versicolor = trainset $ Species == "versicolor"

network = neuralnet ( versicolor + virginica + setosa ~ Sepal.Length + Sepal.Width + Petal.Length + Petal.Width , trainset , hidden = 3 )

head ( network $ generalized.weights [[ 1 ]] )

# plot ( network )

print ( 'hidden: a vector of integers specifying the number of hidden neurons (vertices) in each layer.' )

print ( 'The number of epochs is a hyperparameter that defines the number times that the learning algorithm will work through the entire training dataset.' )

print ( 'The batch size is a hyperparameter that defines the number of samples to work through before updating the internal model parameters.' )

par ( mfrow = c ( 2 , 2 ) )

gwplot ( network , selected.covariate = "Petal.Width"  )
gwplot ( network , selected.covariate = "Sepal.Width"  )
gwplot ( network , selected.covariate = "Petal.Length" )
gwplot ( network , selected.covariate = "Petal.Width"  )

cat ( '\n' ) ; print ( 'predict session for neurlanet for 4 columns' )

net.predict = compute ( network , testset [ -5 ] )

str ( net.predict )

net.predict.result = net.predict $ net.result

# dim ( testset [ -5 ] ) 56 4

net.predict.result [ 1:6 , ]

# The function ‘compute’ is deprecated. Please refer to the new
# function ‘predict.nn’.

net.prediction = c ( "which.max.versicolor" , "which.max.virginica" , "which.max.setosa" ) [ apply ( net.predict.result , 1 , which.max ) ]
str ( net.prediction )
      net.prediction [ 1:6 ]

predict.table = table ( testset $ Species , net.prediction )
predict.table

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

cat ( '\n' ) ; print ( 'nnet session' )

set.seed ( 2 ) ; ind = sample ( 2 , nrow ( iris ) , replace = TRUE , prob = c ( 0.7 , 0.3 ) )

trainset = iris [ ind == 1, ]

names ( trainset )

testset  = iris [ ind == 2, ]

iris.nn = nnet ( Species ~ . , data = trainset , size = 2 , rang = 0.1 , decay = 5e-4 , maxit = 200 )

summary ( iris.nn )

iris.predict = predict ( iris.nn , testset , type = "class" )

head ( predict ( iris.nn , testset ) )

nn.table = table ( testset $ Species , iris.predict )
