setwd("/Users/zhuuu/Desktop/spr2017-proj3-grp1-master")

y <- read.csv("./data/sift_labels.csv" , as.is = T)

data1 <- read.csv("./lib/Features/GIST/chickf.csv",as.is = T,header = F)
data2 <- read.csv("./lib/Features/GIST/dogf.csv",as.is = T,header = F)

GIST.data<-rbind(data1,data2)
y<-y[1:2000,]

per_train <- 0.75 # percentage of training data
smp_size <- floor(per_train * nrow(GIST.data)) # size of the sample
set.seed(0)
index <- sample(seq_len(nrow(GIST.data)), size = smp_size)



data.train<-GIST.data[index,]
y.train<-y[index]

data.test<-GIST.data[-index,]
y.test<-y[-index]

train.matrix <- data.matrix(data.train,rownames.force = NA)
train.D <- xgb.DMatrix(data=train.matrix,label=y.train,missing = NaN)
watchlist <- list(train.matrix=train.D)

parameters <- list ( objective        = "binary:logistic",
                     #booser              = "gbtree",
                     eta                 = 0.05,
                     max_depth           = 6,
                     subsample           = 0.5,
                     gamma = 0
)

crossvalid <- xgb.cv( params             = parameters,
                      data                = train.D,
                      nrounds             = 500,
                      verbose             = 1,
                      watchlist           = watchlist,
                      maximize            = FALSE,
                      nfold               = 5,
                      early_stopping_rounds    = 8,
                      print_every_n       = 1
)


crossvalid$best_iteration
#best error from cross vaclidation
crossvalid$evaluation_log[crossvalid$best_iteration,4]

train.model <- xgb.train( params              = parameters,
                          data                = train.D,
                          nrounds             = crossvalid$best_iteration, 
                          verbose             = 1,
                          watchlist           = watchlist,
                          maximize            = FALSE
)


testmodel <- data.matrix(data.test,rownames.force = NA)
result <- predict (train.model,testmodel)
result<-as.numeric(result > 0.5)
mean(y.test!=result)

tm_train <- system.time(md <- xgb.train(xgb.train( params              = parameters,
                                                   data                = train.D,
                                                   nrounds             = crossvalid$best_iteration, 
                                                   verbose             = 1,
                                                   maximize            = FALSE)))
