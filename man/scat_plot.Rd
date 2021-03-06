% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plotting_functions.R
\name{scat_plot}
\alias{scat_plot}
\title{Scatterplot of Turn Angles ans Step Lengths}
\usage{
scat_plot(traj, periodic = FALSE)
}
\arguments{
\item{traj}{\link[base]{data.frame} containing the trajectory produced by e.g.
\code{\link{make_traj}()}. It must contain
 the columns \code{traj$angle} and \code{traj$steplength}.}

\item{periodic}{\link[base]{logical} value denoting whether the plot should
be periodically extended past -pi and pi.}
}
\value{
A '\code{\link[ggplot2]{ggplot}}' object, the scatterplot.
}
\description{
This function produces a scatterplot ('\code{\link[ggplot2]{ggplot}}' object) of
the turn angles and step lengths.
}
\examples{
set.seed(123)

traj <- make_traj(100,
  copula = cyl_quadsec(0.1),
  marginal_circ = "vonmises",
  parameter_circ = list(0, 1),
  marginal_lin = "weibull",
  parameter_lin = list(shape=3)
)
plot1 <- scat_plot(traj)
plot2 <- scat_plot(traj, periodic = TRUE)

}
\references{
\insertRef{Hodelappl}{cylcop}

\insertRef{Hodelmethod}{cylcop}
}
\seealso{
\code{\link{cop_scat_plot}()}, \code{\link{traj_plot}()},
\code{\link{circ_plot}()}, \code{\link{cop_plot}()}.
}
