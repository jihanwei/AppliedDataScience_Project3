#########################################################
### Train a classification model with training images ###
#########################################################

### Author: Yuting Ma
### Project 3
### ADS Spring 2016


train <- function(train, par=NULL){
  
  ### Train a Gradient Boosting Model (GBM) using processed features from training images
  
  ### Input: datatable containing processed features and labels
  ### Output: training model specification
  
  ### load libraries
  library("gbm")
  
  ### Train with gradient boosting model
  if(is.null(par)){
    nb_trees <- 10000
    shrinkage <- 0.01
  } else {
    nb_trees <- par$nb_trees + 1000
    shr <- par$shrinkage
  }
  boost.fit <- gbm(labels~., data=train,
                   distribution="bernoulli",
                   n.trees=nb_trees,
                   interaction.depth=1,
                   shrinkage=shr)
  
  best_iter <- gbm.perf(boost.fit, method="OOB", plot.it = FALSE)

  return(list(fit=boost.fit, iter=best_iter))
}
