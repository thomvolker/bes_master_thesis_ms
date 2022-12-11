################################################################################
## Thom Volker
## 17-03-2022
################################################################################


################################################################################
## Script 7
################################################################################
## Generate normal and logit regression model data with
## fixed effect sizes (R2 = {0.02, 0.09, 0.25}) and tapering 
## regression coefficients (B = {0, 1, 1, 1, 2, 3}) and correlations 
## between predictors (rho = 0.3)
################################################################################

################################################################################
## Run simulations
################################################################################

output <- 
  expand_grid(nsim = 1:nsim,
              study = 1:nstudy,
              n = n, 
              pcor = pcor, 
              r2 = r2, 
              model = models) %>%
  mutate(rho   = map(pcor, ~cormat(.x, length(ratio_beta))),
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
                                             hypothesis = "V2 < 0 & V3 < 0 & V4 < 0")
                            }, 
                            .options = options))

save.image(file = "simulations/12_Hu_Hc_3preds_wrong.RData")