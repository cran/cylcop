% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/simulate_trajectory.R
\name{traj_get}
\alias{traj_get}
\title{Get a Trajectory from Coordinates}
\usage{
traj_get(x_coords, y_coords)
}
\arguments{
\item{x_coords}{\link[base]{vector} of \link[base]{numeric} values
containing the x-coordinates of a trajectory.}

\item{y_coords}{\link[base]{vector} of \link[base]{numeric} values
containing the y-coordinates of a trajectory.}
}
\value{
A \link[base]{data.frame} containing the trajectory. It has 6 columns
containing the x and y coordinates, the turn angles, the step lengths, and
the pseudo-observations.
}
\description{
The function calculates step lengths and turn angles from x- and y-coordinates
and calculates pseudo-observations from those step lengths and turn angles.
}
\examples{
set.seed(123)

traj <- traj_sim(n = 5,
copula = cyl_quadsec(0.1),
marginal_circ = list(name="vonmises",coef=list(0, 1)),
marginal_lin = list(name="weibull",coef=list(shape=3))
)

traj_from_coords <- traj_get(traj[,1], traj[,2])


}
\seealso{
\code{\link{traj_sim}()}.
}
