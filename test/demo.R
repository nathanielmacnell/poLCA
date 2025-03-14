# make sure to install first 
# (from this source or CRAN version)
library(poLCA)
library(data.table) # fast data operations
library(profvis)

## Three models without covariates:
# M0: Loglinear independence model.
# M1: Two-class latent class model.
# M2: Three-class latent class model.

data(carcinoma)
f <- cbind(A,B,C,D)~1
M0 <- poLCA(f,carcinoma,nclass=1) # log-likelihood: -543.6498
M1 <- poLCA(f,carcinoma,nclass=2) # log-likelihood: -504.4677

profvis({
M2 <- poLCA(f,carcinoma,nclass=3,maxiter=8000) # log-likelihood: -503.3011
})

# create an enormous copy of the carcinoma data
carcinoma_huge = data.table(carcinoma)[rep(1:.N, 1e4)]
format(object.size(carcinoma_huge), units='MB') # these are bits, not bytes

profvis({
M2.big = poLCA(f,carcinoma_huge,nclass=3,maxiter=8000)
})

  

