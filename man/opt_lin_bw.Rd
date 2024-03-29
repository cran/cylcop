% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/fit_margin.R
\name{opt_lin_bw}
\alias{opt_lin_bw}
\title{Find the Optimal Bandwidth for a Linear Kernel Density Estimate}
\usage{
opt_lin_bw(x, method = c("cv", "nrd"))
}
\arguments{
\item{x}{\link[base]{numeric} \link[base]{vector} of linear measurements.}

\item{method}{\link[base]{character} string describing the method used to find
the optimal bandwidth. Either \code{"cv"} (cross-validation),
or \code{"nrd"} (rule-of-thumb estimate).}
}
\value{
A \link[base]{numeric} value, the optimized bandwidth.
}
\description{
This function wraps \code{stats::\link[stats]{bw.ucv}()}
and \code{stats::\link[stats]{bw.nrd}()} of the '\pkg{stats}'
 package, simplifying their inputs. For more control,
these '\pkg{stats}' functions could be used directly.
}
\details{
The normal reference distribution (\code{nrd}) method involves
matching a normal distribution to the data using an empirical measure of spread.
The optimal bandwidth for that normal distribution can then be exactly calculated
by minimizing the mean integrated square error.
\code{method="cv"} finds the optimal bandwidth using unbiased cross-validation.
}
\examples{
require(graphics)
set.seed(123)
n <- 1000

x <- rweibull(n, shape = 10)
bw1 <- opt_lin_bw(x = x, method="nrd")
bw2 <- opt_lin_bw(x = x, method="cv")

dens1 <- fit_steplength(x = x, parametric = FALSE, bandwidth = bw1)
dens2 <- fit_steplength(x = x, parametric = FALSE, bandwidth = bw2)
true_dens <- dweibull(seq(0,max(x),length.out = 200), shape = 10)

plot(seq(0,max(x),length.out = 200), true_dens, type = "l")
lines(dens1$x, dens1$y, col = "red")
lines(dens2$x, dens2$y, col = "green")

}
\seealso{
\code{stats::\link[stats]{bw.ucv}()},
\code{stats::\link[stats]{bw.nrd}()}
\code{\link{opt_lin_bw}()}.
}
