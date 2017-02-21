# Simulate datasets with single event per patient
# load required package
require(pensim)
#Simple sim, data 1
x <- create.data(nvars=c(15, 20),
                 cors=c(0.5, 0.5),
                 associations=c(1, 2),
                 firstonly=c(FALSE, TRUE),
                 nsamples=25000,
                 censoring=c(2, 10),
                 response="timetoevent")

xdat1=x$data

#Simple sim, data 2
x <- create.data(nvars=c(20, 20),
                 cors=c(0.5, 0.8),
                 associations=c(0.3, 2),
                 firstonly=c(FALSE, FALSE),
                 nsamples=25000,
                 censoring=c(2, 10),
                 response="timetoevent")

xdat2=x$data

#Simple sim, data 3
x <- create.data(nvars=c(15, 15),
                 cors=c(0.1, 0.1),
                 associations=c(0.3, 0.1),
                 firstonly=c(FALSE, FALSE),
                 nsamples=25000,
                 censoring=c(2, 10),
                 response="timetoevent")

xdat3=x$data

#Simple sim, data 4
x <- create.data(nvars=c(25, 25),
                 cors=c(0.9, 0.9),
                 associations=c(0.1, 0.1),
                 firstonly=c(TRUE, TRUE),
                 nsamples=25000,
                 censoring=c(2, 10),
                 response="timetoevent")

xdat4=x$data

#Simple sim, data 5
x <- create.data(nvars=c(20, 25),
                 cors=c(0.5, 0.5),
                 associations=c(2, 2),
                 firstonly=c(FALSE, FALSE),
                 nsamples=25000,
                 censoring=c(2, 10),
                 response="timetoevent")

xdat5=x$data


# Simulate datasets with multiple event per patient
# load required package
require(frailtySurv)


dat1 <- genfrail(N=5000, K = "poisson", K.param=c(5, 1), beta=c(0.7,0.9,2,3,1,0.5,0.9,0,0,0,0.1,0.2,0.3,0,0,0,0,2,0.05,1,0.3,0,0,0), frailty="gamma", theta=2,censor.rate=0.35,
                Lambda_0=function(t, tau=4.6, C=0.01) (C*t)^tau,covar.distr = "normal")
dat2 <- genfrail(N=5000, K = "poisson", K.param=c(3, 1), beta=c(0.7,0.9,2,3,1,0.5,0.9,0.5,0.7,0.3,0.1,0.2,0.3,0,0,0,0,2,0.05,1,0.3,0,0,0.4), frailty="gamma", theta=2,censor.rate=0.35,
                Lambda_0=function(t, tau=4.6, C=0.01) (C*t)^tau,covar.distr = "normal")
dat3 <- genfrail(N=5000, K = "poisson", K.param=c(8, 1), beta=c(0.7,0.9,2,3,1,0.5,0.9,0,1,1.3,0.1,0.2,0.3,0,0,0,0,2,0.05,1,0.3,0,0,0), frailty="gamma", theta=2,censor.rate=0.35,
                Lambda_0=function(t, tau=4.6, C=0.01) (C*t)^tau,covar.distr = "normal")
dat4 <- genfrail(N=5000, K = "poisson", K.param=c(6, 1), beta=c(0.7,0,0,3,0,0.5,0.9,0,0,0,0.1,0,0.3,0,0,0,0,0,0.05,0,0.3,0,0,0), frailty="gamma", theta=2,censor.rate=0.35,
                Lambda_0=function(t, tau=4.6, C=0.01) (C*t)^tau,covar.distr = "normal")
dat5 <- genfrail(N=5000, K = "poisson", K.param=c(5, 1), beta=c(0.7,0.9,2,3,1,0.5,0.9,0.5,0.6,0.4,0.1,0.2,0.3,1.2,0.6,0.3,0.9,2,0.05,1,0.3,0.4,0.87,0.43), frailty="gamma", theta=2,censor.rate=0.35,
                Lambda_0=function(t, tau=4.6, C=0.01) (C*t)^tau,covar.distr = "normal")