\name{stan_models}
\Rdversion{1.1}
\docType{class}
\alias{stan_models}
\alias{Rcpp_model_Exponential-class}
\alias{Rcpp_model_Gamma-class}
\alias{Rcpp_model_GenF-class}
\alias{Rcpp_model_GenGamma-class}
\alias{Rcpp_model_Gompertz-class}
\alias{Rcpp_model_logLogistic-class}
\alias{Rcpp_model_logNormal-class}
\alias{Rcpp_model_PolyWeibull-class}
\alias{Rcpp_model_RP-class}
\alias{Rcpp_model_WeibullAF-class}
\alias{Rcpp_model_WeibullPH-class}

\title{Pre-compiled stan models}
\description{
Pre-compiled implementations of survival models in stan.
}
\section{Extends}{
Class \code{"\linkS4class{C++Object}"}, directly.

All reference classes extend and inherit methods from \code{"\linkS4class{envRefClass}"}.

}

\note{
Not to be accessed directly by the user.
}

\examples{
showClass("Rcpp_model_RP")
}
\keyword{classes}
\section{Methods}{
  \describe{
    \item{\code{initialize(...)}:}{ ~~ }
    \item{\code{finalize()}:}{ ~~ }
    \item{\code{update_param_oi(...)}:}{ ~~ }
    \item{\code{unconstrained_param_names(...)}:}{ ~~ }
    \item{\code{unconstrain_pars(...)}:}{ ~~ }
    \item{\code{param_oi_tidx(...)}:}{ ~~ }
    \item{\code{param_names_oi()}:}{ ~~ }
    \item{\code{param_names()}:}{ ~~ }
    \item{\code{param_fnames_oi()}:}{ ~~ }
    \item{\code{param_dims_oi()}:}{ ~~ }
    \item{\code{param_dims()}:}{ ~~ }
    \item{\code{num_pars_unconstrained()}:}{ ~~ }
    \item{\code{log_prob(...)}:}{ ~~ }
    \item{\code{grad_log_prob(...)}:}{ ~~ }
    \item{\code{constrained_param_names(...)}:}{ ~~ }
    \item{\code{constrain_pars(...)}:}{ ~~ }
    \item{\code{call_sampler(...)}:}{ ~~ }
  }
}
