
# --------------------------------- METADATA -----------------------------------
#   Thom Volker
#   13-05-2022
#   Simulation 6 in Volker & Klugkist "Combining support for hypotheses over 
#   heterogeneous studies with Bayesian Evidence Synthesis: A simulation study"
# ______________________________________________________________________________



# ----------------------------- Simulation set-up ------------------------------
#
#   Data-generating mechanism is outlined in file `00_run_simulations.R`.
#   Over 1000 iterations, we apply BES to a collection of three studies, 
#   generated with normal, logit and probit regression models, using the effect
#   sizes R^2 = {0.02, 0.09, 0.25}, the relative strength of predictor variables
#   B = {0, 1, 1, 1, 2, 3}, common correlation between predictors rho = 0.3, 
#   and sample sizes n = {25, 50, 100, 200, 400, 800}.
#
#   In each study, the separate variables X_2, X_3 and X_4 are evaluated in a
#   regression model containing an intercept and all other predictors as control
#   variables. We evaluate the hypothesis {beta_2, beta_3, beta_4} > 0, which 
#   corresponds to V2 > 0 & V3 > 0 & V4 > 0 in the code. 
#
# ______________________________________________________________________________

# ------------------------------ Run simulations -------------------------------

output <- 
  expand_grid(nsim = 1:nsim,                                      # 1. create data.frame with all
              n = n,                                              #    simulation conditions
              pcor = pcor, 
              r2 = r2, 
              model = models) %>%
  mutate(rho   = map(pcor, ~cormat(.x, length(ratio_beta))),      # 2. create covariance matrix
         betas = pmap(list(r2, rho, model),                       # 3. calculate regression coefficients
                      function(r2, rho, model) {                  #    given model specifications
                        coefs(r2, ratio_beta, rho, model)
                      }),
         fit  = future_pmap(list(r2, betas, rho, n, model),       # 4. generate normal, logit and probit
                            function(r2, betas, rho, n, model) {  #    data, fit regression model and 
                              data_and_model(r2 = r2,             #    evaluate hypotheses
                                             betas = betas, 
                                             rho = rho,
                                             n = n,
                                             model = model,
                                             formula = Y ~ V1 + V2 + V3 + V4 + V5 + V6,
                                             hypothesis = "V2 > 0 & V3 > 0 & V4 > 0")
                            }, 
                            .options = options))

# --------------------------- Save output simulations --------------------------

save.image(file = "output/06_separated_variables.RData")
