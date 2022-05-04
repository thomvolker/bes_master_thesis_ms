################################################################################
## Thom Volker
## 07-09-2021
################################################################################


################################################################################
## Test script
################################################################################


################################################################################
## Load required packages and functions
################################################################################

library(tidyverse)
library(magrittr)
library(furrr)
library(bain)
library(Rcpp)
library(RcppArmadillo)

source("./MSBBSS/simulations/functions.R")
sourceCpp("./MSBBSS/simulations/mvn_c.cpp")

################################################################################
## Specify parallel functionality and seed
################################################################################

## Set seed 
set.seed(123)

## Parallel processing
plan(multisession)

## Parallel seed
options <- furrr_options(seed = 123)

################################################################################
## Specify simulation conditions
################################################################################

## Number of simulations 
nsim <- 5

## Sample sizes
n <- 25 * 2^{0:5}

## Models
models <- c("normal", "logit", "probit")

## r2 of the regression model
r2 <- c(.02, .09, .25)

## Specify relative importance of the regression coefficients
ratio_beta <- c(1,1,1,2,3)

## Specify the bivariate correlations between predictors
pcor <- c(0.3)

################################################################################
## Run simulations
################################################################################

output <- 
  expand_grid(nsim = 1:nsim, 
              n = n, 
              pcor = pcor, 
              r2 = r2, 
              model = models) %>%
  mutate(rho   = map(pcor, ~cormat(.x, length(ratio_beta))),
         betas = pmap(list(r2, rho, model),                   # calculate regression
                      function(r2, rho, model) {              # coefficients given
                        coefs(r2, ratio_beta, rho, model)     # model specifications
                      }),
         data  = pmap(list(r2, betas, rho, n, model),         # generate normal,
                      function(r2, betas, rho, n, model) {    # logit and probit
                        gen_dat(r2, betas, rho, n, model)     # data
                      }),
         fit   = map2(data, model, ~fit_full_model(.x, .y)),
         bain  = map(fit, ~bain(.x, 
                                "V1 < 0 & V2 < 0 & V3 < 0; 
                                 V1 > 0 & V2 > 0 & V3 > 0")))

save.image(file = "./MSBBSS/simulations/99_test.RData")

