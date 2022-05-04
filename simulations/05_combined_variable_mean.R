################################################################################
## Thom Volker
## 07-09-2021
################################################################################


################################################################################
## Script 3
################################################################################
## Generate normal, logit and probit regression model data with
## fixed effect sizes (R2 = {0.02, 0.09, 0.25}) and and a single effect
## that is the sum of three separate effects (and hence yields the same
## hypothesis). The correlation between correlations predictors (rho = 0.3)
################################################################################

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
         fit  = future_pmap(list(r2, betas, rho, n, model),         # generate normal,
                            function(r2, betas, rho, n, model) {    # logit and probit
                              data_and_model(r2 = r2, 
                                             betas = betas, 
                                             rho = rho,
                                             n = n,
                                             model = model,
                                             formula = Y ~ V1 + Vcomb + V5 + V6,
                                             hypothesis = "Vcomb > 0; Vcomb < 0",
                                             mutate_args = quos(Vcomb = (V2 + V3 + V4)/3),
                                             select_args = quos(-c(V2, V3, V4)))
                            }, 
                            .options = options))



save.image(file = "simulations/05_combined_variable_mean.RData")
