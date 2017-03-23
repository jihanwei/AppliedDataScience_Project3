########################
### Cross Validation ###
########################

### Author: Yuting Ma
### Project 3
### ADS Spring 2016


cv.function <- function(train, shr, K){
  
  library(gbm)
  
  
  boost.fit <- gbm(labels~., data=train,
                        distribution="bernoulli",
                        n.trees=15000,
                        interaction.depth=1,
                        shrinkage=shr,
                        cv.folds=K)
  cv.error = boost.fit$cv.error
  return(cv.error)
  
}
