cormat <- function(partial_cor, diag_length) {
  r <- diag(diag_length)
  r[r != 1] <- partial_cor
  r
}

coefs <- function(r2, ratio, rho, model = c("normal", "logit", "probit")) {
  
  if (model == "normal") {
    var_y <- r2
  }
  else if (model == "logit") {
    var_y <- (r2 * pi^2 / 3) / (1 - r2)
  }
  else if (model == "probit") {
    var_y <- r2 / (1 - r2)
  }
  
  sqrt(var_y / sum(ratio %*% t(ratio) * rho)) * ratio
}

gen_dat <- function(r2, betas, rho, n, model = c("normal", "logit", "probit"), 
                    mutate_args = NULL, select_args = quos(everything())) {
  
  X <- mvrnormArma(n, mu = rep(0, length(betas)), sigma = rho)
  
  if (model == "normal") {
    Y <- X %*% betas + rnorm(n = n, mean = 0, sd = sqrt(1 - r2))
  }
  if (model == "logit") {
    Y <- rbinom(n, 1, 1 / (1 + exp(-(X %*% betas))))
  }
  if (model == "probit") {
    Y <- rbinom(n, 1, pnorm(X %*% betas))
  }
  bind_cols(X = as.data.frame(X), Y = Y) %>%
    mutate(!!!mutate_args) %>%
    select(!!!select_args)
}

q_glm <- quietly(glm)

data_and_model <- function(r2, betas, rho, n, model, 
                           formula, 
                           hypothesis, complement = TRUE,
                           mutate_args = NULL, select_args = quos(everything())) {
  
  if (model == "normal") {
    
    gen_dat(r2, betas, rho, n, model, mutate_args, select_args) %>%
      lm(formula = formula, data = .) %>%
      BF(hypothesis = hypothesis, complement = complement) %$%
      BFtable_confirmatory
    
  } else {
      
    warnings <- 0
      
    while(length(warnings) > 0) {
      mod <- gen_dat(r2, betas, rho, n, model, mutate_args, select_args) %>%
        q_glm(formula = formula, 
              family = binomial(link = model),
              data = .)
      warnings <- mod$warnings
    }
      
    mod$result %>% 
      BF(hypothesis = hypothesis, complement = complement) %$%
      BFtable_confirmatory
    
  }
}
