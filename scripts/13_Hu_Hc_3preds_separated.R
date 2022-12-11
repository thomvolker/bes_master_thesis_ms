
# --------------------------------- METADATA -----------------------------------
#   Thom Volker
#   15-05-2022
#   Additional simulation that is discussed without figure (after simulation 11) 
#   for Volker & Klugkist "Combining support for hypotheses over heterogeneous 
#   studies with Bayesian Evidence Synthesis: A simulation study"
# ______________________________________________________________________________



# ----------------------------- Simulation set-up ------------------------------
#
#   Data-generating mechanism is outlined in file `00_run_simulations.R`.
#   Over 1000 iterations, we cumulatively apply BES to a collection of 150
#   studies, all generated with OLS regression. We use the effect sizes 
#   R^2 = 0.09, the relative strength of predictor variables 
#   B = {0, 1, 1, 1, 2, 3}, common correlation between predictors rho = 0.3, and 
#   sample sizes n = {25, 200}.
#
#   In each study, the variables X_2, X_3 and X_4 are evaluated in a regression 
#   model containing an intercept and all other predictors as control variables. 
#   Rather than evaluating the hypothesis {beta_2, beta_3, beta_4} > 0, we
#   evaluate the separate components of this hypothesis, which yields
#   beta_2 > 0; beta_3 > 0; beta_4 > 0, corresponding to V2 > 0; V3 > 0; V4 > 0
#   in the R code. 
#
# ______________________________________________________________________________

# ------------------------------ Run simulations -------------------------------

output <- 
  expand_grid(nsim = 1:nsim,                                     # 1. create data.frame with all
              study = 1:nstudy,                                  #    simulation conditions
              n = n, 
              pcor = pcor, 
              r2 = r2, 
              model = models) %>%
  mutate(rho   = map(pcor, ~cormat(.x, length(ratio_beta))),     # 2. create covariance matrix
         betas = pmap(list(r2, rho, model),                      # 3. calculate regression coefficients
                      function(r2, rho, model) {                 #    given model specifications
                        coefs(r2, ratio_beta, rho, model)     
                      }),
         fit  = future_pmap(list(r2, betas, rho, n, model),      # 4. generate normal data, fit 
                            function(r2, betas, rho, n, model) { #    regression model and evaluate
                              data_and_model(r2 = r2,            #    hypothesis
                                             betas = betas, 
                                             rho = rho,
                                             n = n,
                                             model = model,
                                             formula = Y ~ V1 + V2 + V3 + V4 + V5 + V6,
                                             hypothesis = "V2 > 0; V3 > 0; V4 > 0",
                                             complement = FALSE) # complements are calculated for the
                            },                                   # hypotheses separately
                            .options = options))


# --------------------------- Save output simulations --------------------------

save.image(file = "output/13_Hu_Hc_3preds_separated.RData")


