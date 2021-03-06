#' Compass Bearing of a Line Between 2 Points
#'
#' The angle between a line between 2 points in Euclidean 2-D space and the line from
#' (0,0) to (0,1) is calculated. In other words, the compass bearing of a line
#' between 2 points where north is 0. Angles increase in clockwise direction.
#' @param point1 \link[base]{numeric} \link[base]{vector} holding the
#'  x and y coordinates of the first point.
#' @param point2 \link[base]{numeric} \link[base]{vector} holding the
#' x and y coordinates of the second point.
#' @param fullcirc \link[base]{logical} value indicating whether the output
#' should be an angle on \eqn{[0, 2\pi)} or \eqn{[-\pi, \pi)}.
#'
#' @return If \code{fullcirc = FALSE}, the function returns a \link[base]{numeric}
#'   value (angle) from the interval \eqn{[-\pi, \pi)}. \cr
#'   If \code{fullcirc = TRUE}, the function returns a numeric value \link[base]{numeric} from the interval
#'   \eqn{[0, 2\pi)}.
#' @export
#'
#' @examples
#' bearing(c(3,5), c(1,4))
#' bearing(c(3,5), c(1,4), fullcirc = FALSE)
bearing <- function(point1, point2, fullcirc = TRUE) {
  if (all(point1 == point2)) {
    warning(
      "Distance between points is 0, cannot calculate bearing. Arbitratily assigned it an angle of 0"
    )
    return(0)
  }
  delx <- point2[1] - point1[1]
  dely <- point2[2] - point1[2]

  b <- sign(delx)
  b[b == 0] <- 1  #corrects for the fact that sign(0) == 0
  angle = b * (dely < 0) * pi + atan(delx / dely)

  if(fullcirc==TRUE){
    angle <- half2full_circ(angle)
  }
  return(angle)
}


#' Calculate the Next Position in a Trajectory from a Turn Angle and a Step Length
#'
#' The xy-coordinates of a position in 2-D space is calculated from the angle
#' between that position and the 2 previous ones in the trajectory and the
#' distance between that position and the previous one.
#'
#' @param angle \link[base]{numeric} value of the turn angle or a
#'  \code{\link[circular]{circular}} object, either in \eqn{[0, 2\pi)} or in \eqn{[-\pi, \pi)}
#' @param steplength \link[base]{numeric} value giving the distance between the
#' position and the previous one.
#' @param prevp1 \link[base]{numeric} \link[base]{vector} holding the x and y
#' coordinates of the previous position.
#' @param prevp2 \link[base]{numeric} \link[base]{vector} holding the x and y
#' coordinates of the position before the previous one.
#'
#' @return The function returns a \link[base]{numeric} \link[base]{vector}
#' holding the x and y coordinates of the position
#' @export
#'
#' @examples
#'  angstep2xy(1.5*pi, 2, prevp1 = c(1, 4), prevp2 = c(2, 7.5))
#'  angstep2xy(-0.5*pi, 2, c(1, 4), c(2, 7.5))
angstep2xy <- function(angle, steplength, prevp1, prevp2) {
  #convert angle to \eqn{[0, 2\pi)} if necessary
  angle <-
    tryCatch(
      half2full_circ(angle),
      error = function(e)
        as.double(angle)
    )

  prevbear <- bearing(prevp2, prevp1)
  newbear <- (prevbear + angle) %% (2 * pi)

  ##calculate changes in x and y coordinates from position-1 to position
  delx <- sin(as.double(newbear)) * steplength
  dely <- cos(as.double(newbear)) * steplength
  pos = c(prevp1[1] + delx, prevp1[2] + dely)
  return(pos)
}



#' Convert Angle from Half Circle to Full Circle
#'
#' Converts an angle from the half circle (i.e. in the interval \eqn{[-\pi, \pi)})
#' to an angle on the full circle  (i.e. in the interval \eqn{[0, 2\pi)}).
#'
#' @param angle \link[base]{numeric} value of an angle or a
#' \code{\link{circular}}-objekt in \eqn{[-\pi, \pi)}.
#'
#' @return The \link[base]{numeric} value of the angle in \eqn{[0, 2\pi)}.
#' @export
#'
#' @examples
#' half2full_circ(-1 * pi) / pi
#' half2full_circ(-0.5 * pi) / pi
#' half2full_circ(-0 * pi) / pi
#' half2full_circ(0.5 * pi) / pi
#'
half2full_circ <- function(angle) {
  (as.double(angle) + (2 * pi)) %% (2 * pi)
}

#' Convert Angle from Full Circle to Half Circle
#'
#' Converts an angle from the full circle (i.e. in the interval \eqn{[0, 2\pi)})
#' to an angle on the half circle  (i.e. in the interval \eqn{[-\pi, \pi)}).
#'
#' @param angle \link[base]{numeric} value of an angle or a
#' \code{\link{circular}}-objekt in \eqn{[0, 2\pi)}.
#'
#' @return The \link[base]{numeric} value of the angle in \eqn{[-\pi, \pi)}.
#' @export
#'
#' @examples
#' full2half_circ(0 * pi) / pi
#' full2half_circ(0.5 * pi) / pi
#' full2half_circ(1 * pi) / pi
#' full2half_circ(1.5 * pi) / pi
#' full2half_circ(2 * pi) / pi
#'
#'
full2half_circ <- function(angle) {
  if (any(angle < 0)) {
    stop(error_sound(),
         "An angle is negative. Did you mean to convert half to full instead?")
  }
  angle <- as.double(angle %% (2 * pi)) %>%
    modify_if(~ .x > pi, ~ .x - (2 * pi))
  return(angle)
}


# Print arguments of a function call
#
#
#
# @param fun The function.
# @param params A list of characters holding the arguments passed to that function (named or unnamed).
# @param start An integer value, indicating with which function argument printing starts.
# @param param_print An integer value, indicating how many arguments are printed.
#
# @return A string consisting of parameter names and values with wich \code{fun} was called
# @export
#
# @examples
# print_param(dnorm, list(sd=1),start=1)
print_param <-
  function(fun,
           params = list(),
           start = 2,
           param_print = seq(start, length(formals(fun)))) {

    #Replace arguments of fun with elements of params, starting with the "start" argument.
    #Give back a string with the argument names and their values of argument numbers
    #specified in param_print
    args <- formals(fun)
    if (is.null(args)) {
      return("none")
    }
    if (length(param_print) > length(args)) {
      stop("requested to print more parameters than function has arguments",
           error_sound())
    }
    if (length(params) > length(args)) {
      stop("specified more parameters than the function has arguments",
           error_sound())
    }


    # If the parameters in params are not named, replace the default parameters consecutively

    if (length(params) != 0 && is.null(names(params))) {
      for (i in 1:length(params)) {
        if(!is.numeric(params[[i]]) && !is.character(params[[i]])){
          params[[i]]<-"object"
        }
        args[[i + start - 1]] <- params[[i]]
      }
    }


    #If the parameters in params are named, replace the default parameters by name

    else if (length(params) != 0 &&
             !"" %in% names(params) && !is.null(names(params))) {
      for (i in 1:length(params)) {
        if (!names(params)[i] %in% names(args)) {
          stop(error_sound(),
               names(params)[i],
               " is not a valid argument name")
        }
        if(!is.numeric(params[[i]]) && !is.character(params[[i]])){
          params[[i]]<-"object"
        }
        args[[names(params)[i]]] <- params[[i]]
      }
    }
    else if (length(params) != 0 && "" %in% names(params)) {
      stop(error_sound(),
           "either have all function arguments specified by name or none")
    }


    # Print

    temp <-
      paste(names(args)[param_print[1]], "=", deparse(args[[param_print[1]]]))
    if (length(param_print) > 1) {
      for (i in 2:length(param_print)) {
        temp <-
          paste(temp, ", ", names(args)[param_print[i]], " = ", deparse(args[[param_print[i]]]), sep = "")
      }
    }
    temp
  }

# Get univariate distributions
#
#
# @param marg_type A character string corresponding to the type of univariate distribution, e.g. "norm"
#
# @return Give A list of functions of a univariate distribution (random gneration, density, distribution, quantiles)
# @export
#
# @examples
# get_marg("norm")
get_marg <- function(marg_type) {
  if(marg_type=="exponential") marg_type <- "exp"
  if(marg_type=="gauss" || marg_type=="normal") marg_type <- "norm"

  tryCatch({
    list(
      "d" = (paste0("d", marg_type) %>% get()),
      "p" = (paste0("p", marg_type) %>% get()),
      "q" = (paste0("q", marg_type) %>% get()),
      "r" = (paste0("r", marg_type) %>% get())
    )
  }, error = function(e) {
    stop(
      error_sound(),
      "*",
      marg_type,
      " e.g. d",
      marg_type,
      " is not a distribution that could be found in any curently loaded package"
    )
  })
}


#' Set Package Options
#'
#' Currently the only option is to toggle verbosity on or off.
#' @param silent \link[base]{logical}, suppress all sounds and messages.
#'
#' @return No output, only side effects.
#' @examples cylcop_set_option(silent = FALSE)
#' @seealso \code{\link{cylcop_get_option}()}
#' @aliases verbose, silent
#' @export
#'
cylcop_set_option <- function(silent=FALSE){
  assign("silent", silent, envir=cylcop.env)
}



#' Get Package Options
#'
#' Currently the only option (\code{"silent"}) is to toggle verbosity on or off.
#'
#' @param option \link[base]{character} string, the name of the option.
#'
#' @return
#' The \link[base]{numeric} value of option. If no argument is provided, a list
#' of all options is printed.
#' @examples cylcop_get_option("silent")
#' cylcop_get_option()
#' @seealso \code{\link{cylcop_set_option}()}
#' @export
#'
#'
cylcop_get_option <- function(option=NULL){
  if(is.null(option)){
    result <- ls(cylcop.env)
  }
  else{
 result<-get(option,envir=cylcop.env)
  }
  return(result)
}



#--------------Set sounds----------------
#
# Sound functions are commented out and sound-files not provided at the moment
#



# Error sound
#
# @include aaaglobal.R
# @return Play the error sound
# @export
#
error_sound <- function() {
  # if(cylcop.env$silent==F){
  #   decide <- runif(1)
  #   if(decide>0.5){
  #   sound::play(sound::loadSample(system.file("extdata", "error.wav", package = "cylcop")))
  #   }
  #   else{
  #     sound::play(sound::loadSample(system.file("extdata", "confusion.wav", package = "cylcop")))
  #
  #   }
  # }
  # else{}
}

# Warning sound
#
# @include aaaglobal.R
# @return Play the warning sound
# @export
#
warning_sound <- function() {
  # if(cylcop.env$silent==F){
  #   sound::play(sound::loadSample(system.file("extdata", "warning.wav", package = "cylcop")))
  # }
  # else{}
}

# Waiting sound
#
# @include aaaglobal.R
# @return Play the waiting sound
# @export
#
waiting_sound <- function() {
  # if(cylcop.env$silent==F){
  #   sound::play(sound::loadSample(system.file("extdata", "waiting.wav", package = "cylcop")))
  # }
  # else{}
}

# Done sound
#
# @include aaaglobal.R
# @return Play the done sound
# @export
#
done_sound <- function() {
  # if(cylcop.env$silent==F){
  #   sound::play(sound::loadSample(system.file("extdata", "done.wav", package = "cylcop")))
  # }
  # else{}
}
