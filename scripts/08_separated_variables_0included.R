
# --------------------------------- METADATA -----------------------------------
#   Thom Volker
#   14-05-2022
#   Simulation 8 in Volker & Klugkist "Combining support for hypotheses over 
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
#   In each study, the separate variables X_1, X_2 and X_3 are evaluated in a
#   regression model containing an intercept and all other predictors as control
#   variables. We evaluate the hypothesis {beta_1, beta_2, beta_3} > 0, which is
#   partially incorrect because beta_1 = 0. This hypothesis corresponds to 
#   V1 > 0 & V2 > 0 & V3 > 0 in the code. 
#
# ______________________________________________________________________________

# ------------------------------ Run simulations -------------------------------

output <- 
  expand_grid(nsim = 1:nsim,                                      # 1. make data.frame with all
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
                              data_and_model(r2 = r2,             #    evaluate hypothesis
                                             betas = betas, 
                                             rho = rho,
                                             n = n,
                                             model = model,
                                             formula = Y ~ V1 + V2 + V3 + V4 + V5 + V6,
                                             hypothesis = "V1 > 0 & V2 > 0 & V3 > 0")
                            }, 
                            .options = options))

# --------------------------- Save output simulations --------------------------

save.image(file = "output/08_separated_variables_0included.RData")
