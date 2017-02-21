# As our all real life datasets are publicly available, we show example for introducing missing data using only one, 
# same procedure can be followed to induce missingness in simulated datasets

# read in GRACE dataset
grace=read.table("https://www.umass.edu/statdata/statdata/data/grace1000.dat",sep="")
# remove id variable
grace_req=grace[,-1]

# set proportion of loss to followup needed to be introduced
prop.m = .2  # 20% missingness
# add a uniform random vector
grace_req$mcar   = runif(nrow(grace_req), min=0, max=1)

# for missing completely at random (MCAR)
grace_req$time2 = ifelse(grace_req$mcar<prop.m, NA, grace_req[,1])
grace_req$cens2 = ifelse(grace_req$mcar<prop.m, NA, grace_req[,2])

# for missing not at random (MNAR)
grace_req$time2 = ifelse(grace_req$mcar<prop.m & grace_req[,2]==1, NA, grace_req[,1])
grace_req$cens2 = ifelse(grace_req$mcar<prop.m & grace_req[,2]==1, NA, grace_req[,2])

# Split data to test and train, 70% - Training, rest testing
smp_size <- floor(0.70 * nrow(grace_req))

train_ind <- sample(seq_len(nrow(grace_req)), size = smp_size)

# drop complete time and outcome variables to get noisy data
train_noisy1 <- grace_req[train_ind,c(-1,-2,-9) ]
test_noisy1 <- grace_req[-train_ind,c(-1,-2,-9) ]

# drop time and outcome with missing data and keep just clean data for training
train1<- grace_req[train_ind,c(-9,-10,-11) ]
test1<- grace_req[-train_ind,c(-9,-10,-11) ]

# rename time and outcome and move them to same position as in noisy data
train1$time2=train1[,1]
train1$cens2=train1[,2]

test1$time2=test1[,1]
test1$cens2=test1[,2]

train1=train1[,c(-1,-2)]
test1=test1[,c(-1,-2)]

# now the datasets are ready to be exported and to be used in our python program
write.table(train_noisy1,".../train_noisy.csv",sep = ",",row.names = FALSE,col.names = FALSE)
write.table(test_noisy1,".../test_noisy.csv",sep = ",",row.names = FALSE,col.names = FALSE)
write.table(train1,".../train.csv",sep = ",",row.names = FALSE,col.names = FALSE)
write.table(test1,".../test.csv",sep = ",",row.names = FALSE,col.names = FALSE)
