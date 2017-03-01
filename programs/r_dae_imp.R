# R-Script to reun a denoising autoencoder for imputation #

# load H20 package
require(h2o)

# convert your training and test frames into h20 objects, here training would be the complete dataset and test is the 
# partition that needs to be imputed

train.hex=as.h2o(train)
test.hex=as.h2o(test)

# model setup
n=ncol(test)
pred=c(1:n)

# build the model, every successive layer adds p dimensions, layers can be increased or decreased depending on complexity required, 
# p can be treated as a hyperparameter
# setting input dropout ratio=n makes the model a denoising autoencoder where inputs are coupled with dropout, 
# randomly setting some inputs to 0

p=7
ae_model <- h2o.deeplearning(x=pred,
                             training_frame=train.hex,
                             hidden=c(n,n+p,n+(2*p),n+(3*p),n+(2*p),n+p),
                             epoch=500,
                             activation="Tanh",
                             autoencoder=T,
                             input_dropout_ratio = 0.2,
                             ignore_const_cols=F)

# predict the missing data
pred=h2o.predict(ae_model,test.hex)

# convert to data frame
dae_tanh=as.data.frame(pred)

# write the data to the disk
write.table(dae_tanh,".../dae_imputed.csv",sep = ",",row.names = FALSE,col.names = FALSE)