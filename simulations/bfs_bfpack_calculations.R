
set.seed(123)
n <- 1000
x <- rnorm(n)
mu <- mean(x)
post_t  <- mu / (sd(x)/sqrt(n))
t.test(x)
var(x)
sd(x)^2

post_t

prior_t <- 0

BFpack::BF(bain::t_test(x), hypothesis = "mu = 0")
bf_iu <- (1 - pt(0, n-1, post_t)) / 0.5
bf_cu <- 1 / bf_iu
bf_iu / bf_cu
pt(post_t, 999)

y1 <- rnorm(1000)
y2 <- rnorm(1000)
x1 <- y1 + y1 / y2 + rnorm(1000)
x2 <- 0.3 * y2 + rnorm(1000)

summary(lm(cbind(y1, y2) ~ x1 + x2))


X <- mvtnorm::rmvnorm(1000, c(0,0,0), diag(3))

y <- X %*% c(0.2, 0.5, 0.8) + rnorm(1000)

lm(y ~ X)

X <- cbind(1, X)

solve(t(X) %*% X) %*% t(X) %*% y

own_lm <- function(y, X) {
  X <- cbind(1, X)
  solve(t(X) %*% X) %*% t(X) %*% y
}
rbenchmark::benchmark(own_lm(y, X),
                      lm(y ~ X))

set.seed(123)

X <- mvtnorm::rmvnorm(1000, 
                      c(0, 0),
                      matrix(c(1, 0.2, 0.2, 1), 
                             nrow = 2))

X <- cbind(1, X)

y <- X %*% c(0, 0.02, 0.02) + rnorm(1000)

B <- solve(t(X) %*% X) %*% t(X) %*% y

SX <- X[,-1]

out <- BFpack::BF(lm(y ~ SX), hypothesis = "SX2 > SX1 > 0")
out
library(mvtnorm)

pr_s2 <- t(y - X %*% B) %*% (y - X %*% B)
p_s2  <- t(y - X %*% B) %*% (y - X %*% B) / (1000 - 3)

fi <- pmvt(c(-Inf, 0, 0),
           Inf,
           delta = c(B), 
           sigma = c(p_s2) * solve(t(X) %*% X), 
           df = 997,
           type = "shifted")

ci <- pmvt(c(-Inf, 0, 0),
           Inf,
           delta = c(0,0,0),
           sigma = c(p_s2) * solve(t(X) %*% X) / (1 / 997),
           df = 1,
           type = "shifted")
((1 - fi) / (1 - ci)) / (fi / ci)

!!!CHECK S_b IN BFPACK


debug(BFpack:::BF.lm)
pt()