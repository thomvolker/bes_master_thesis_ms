################################################################################
## Thom Volker
## 07-09-2021
################################################################################


################################################################################
## Script 2
################################################################################
## Generate normal, logit and probit regression model data with
## fixed effect sizes (R2 = {0.02, 0.09, 0.25}) and tapering 
## regression coefficients (B = {0, 1, 1, 1, 2, 3}) and correlations 
## between predictors (rho = 0.3), but keep a single study's
## sample size fixed at 25
################################################################################

################################################################################
## Adjust sample size
################################################################################


n_initial <- n

output <- expand_grid(nsim = 1:nsim,
                      n_initial = n_initial,
                      pcor = pcor,
                      r2 = r2,
                      model = models)

n25 <- map(1:(nrow(output)/3), ~sample(c(FALSE,FALSE,TRUE))) %>% unlist()

################################################################################
## Run simulations
################################################################################

output <-
  output %>%
  mutate(n     = ifelse(n25, 25, n_initial),
         rho   = map(pcor, ~cormat(.x, length(ratio_beta))),
         betas = pmap(list(r2, rho, model),                   # calculate regression
                      function(r2, rho, model) {              # coefficients given
                        coefs(r2, ratio_beta, rho, model)     # model specifications
                      }),
         fit  = future_pmap(list(r2, betas, rho, n, model),         # generate normal,
                            function(r2, betas, rho, n, model) {    # logit and probit
                              data_and_model(r2 = r2, 
                                             betas = betas, 
                                             rho = rho,
                                             n = n,
                                             model = model,
                                             formula = Y ~ V1 + V2 + V3 + V4 + V5 + V6,
                                             hypothesis = "V4 < V5 < V6")
                            }, 
                            .options = options))

save.image(file = "simulations/02_sample_size_underpowered.RData")
