// Gompertz survival model

functions {
  // Defines the log hazard
  /*
  * define the log hazard
  *
  * Internal stan function - Gompertz model
  *
  * @param t times
  * @param shape shape
  * @param rate rate
  * @return log hazard
  */
  vector log_h (vector t, real shape, vector rate) {
    vector[num_elements(t)] log_h;
    log_h = log(rate) + (shape * t);
    return log_h;
  }
  
  // Defines the log survival
  /*
  * define the log Survival
  *
  * Internal stan function - Gompertz model
  *
  * @param t times
  * @param shape shape
  * @param rate rate
  * @return log Survival
  */
  vector log_S (vector t, real shape, vector rate) {
    vector[num_elements(t)] log_S;
    for (i in 1:num_elements(t)) {
      log_S[i] = -rate[i]/shape * (exp(shape * t[i]) - 1);
    }
    return log_S;
  }
  
  // Defines the sampling distribution
  /*
  * define the sampling distribution
  *
  * Internal stan function - Gompertz model
  *
  * @param t times
  * @param d censoring indicator
  * @param shape shape
  * @param scale scale
  * @return sampling distribution
  */
  real surv_gompertz_lpdf (vector t, vector d, real shape, vector scale) {
    vector[num_elements(t)] log_lik;
    real prob;
    log_lik = d .* log_h(t,shape,scale) + log_S(t,shape,scale);
    prob = sum(log_lik);
    return prob;
  }
}

data {
  int n;                  // number of observations
  vector[n] t;            // observed times
  vector[n] d;            // censoring indicator (1=observed, 0=censored)
  int H;                  // number of covariates
  matrix[n,H] X;          // matrix of covariates (with n rows and H columns)
  vector[H] mu_beta;	  // mean of the covariates coefficients
  vector<lower=0> [H] sigma_beta;   // sd of the covariates coefficients
  real<lower=0> a_alpha;
  real<lower=0> b_alpha;
}

parameters {
  vector[H] beta;         // Coefficients in the linear predictor (including intercept)
  real<lower=0> alpha;    // shape parameter
}

transformed parameters {
  vector[n] linpred;
  vector[n] mu;
  linpred = X*beta;
  for (i in 1:n) {
    mu[i] = exp(linpred[i]);
  }
}

model {
  alpha ~ gamma(a_alpha,b_alpha);
  beta ~ normal(mu_beta,sigma_beta);
  t ~ surv_gompertz(d,alpha,mu);
}

generated quantities {
  real rate;                // rate parameter
  rate = exp(beta[1]);
}
