
# --------------------------------- METADATA -----------------------------------
#   Thom Volker
#   13-05-2022
#   Simulation 4 in Volker & Klugkist "Combining support for hypotheses over 
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
#   In each study, we first generate Y and X, and after generating the data, 
#   we create a categorical version of X_6, by splitting the variable into three 
#   equally sized tertiles in each sample (low, medium and high).
# 
#   Accordingly, we fit a regression model with all 5 other predictors, but
#   without an intercept (because the intercept is in beta_low). Hereafter, we 
#   evaluate the hypothesis beta_low < beta_medium < beta_high which corresponds
#   to V6D1 < V6D2 < V6D3 in the code. 
#
# ______________________________________________________________________________

# ------------------------------ Run simulations -------------------------------

output <- 
  expand_grid(nsim = 1:nsim,                                     # 1. create data.frame with all
              n = n,                                             #    simulation conditions
              pcor = pcor, 
              r2 = r2, 
              model = models) %>%
  mutate(rho   = map(pcor, ~cormat(.x, length(ratio_beta))),     # 2. create covariance matrix
         betas = pmap(list(r2, rho, model),                      # 3. calculate regression coefficients
                      function(r2, rho, model) {
                        coefs(r2, ratio_beta, rho, model)
                      }),
         fit  = future_pmap(list(r2, betas, rho, n, model),      # 4. generate normal, logit and 
                            function(r2, betas, rho, n, model) { #    probit data, fit regression model
                              data_and_model(r2 = r2,            #    and evaluate hypothesis
                                             betas = betas, 
                                             rho = rho,
                                             n = n,
                                             model = model,
                                             formula = Y ~ V1 + V2 + V3 + V4 + V5 + V6D - 1,
                                             hypothesis = "V6D1 < V6D2 < V6D3",
                                             mutate_args = quos(V6D = cut(V6, 3, labels = 1:3))) # three equally sized quartiles are created here
                            }, .options = options))


# --------------------------- Save output simulations --------------------------

save.image(file = "output/04_dummied_variable_cat.RData")

