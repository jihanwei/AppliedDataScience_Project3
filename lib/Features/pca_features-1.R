# PCA

pca <- function(data, n){
  # n: the number of principle components 
  
  pca=prcomp(data, center=TRUE, scale=TRUE);
  
  # Cum.Screeplot.
  # pr_var=(pca$sdev)^2;
  # plot(cumsum(pr_var)/sum(pr_var)*100,ylim=c(0,100),type="b",xlab="component",ylab="c umulative propotion (%)",main="Cum. Scree plot");
  # plot(pca)
  # abline(h=80,col="red")
  # dim(pca$x[,1:n2])
  
  load <- pca$rotation[,1:n]
  save(load,file = "pca_loading.rda")
  
  # newpca = as.matrix(newdata)*load
  
  return(pca$x[,1:n])
}
#to use this function, u need to clean and import the raw images first
#the following code is from Jihan's feature codes, haven't debug 
#yet since I am having troubles with package EBImage
#experiment_dir <- "../training_data/raw_images/" 

#library("EBImage")
#no_files <- length(list.files(experiment_dir))
#fe<-matrix(NA, no_files ,256*256)    ##1024 features are extracted
#for(i in 1:no_files ){
  #img <-readImage(paste0(img_dir, "image", "_",sprintf("%04.0f", i) ,".jpg"))
  #img<- resize(img, 256,256)
 
  #fe[i,] <- c(as.matrix(img))
  
#}

# in order to keep the new pcs the same meaning as the training pcs
# we have to maintain the same loading matrix which will be multipled with new data.