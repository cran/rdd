\name{RDestimate}
\alias{RDestimate}
\title{Regression Discontinuity Estimation}
\usage{
  RDestimate(formula, data, subset = NULL, cutpoint = NULL,
    bw = NULL, kernel = "triangular", se.type = "HC1",
    cluster = NULL, verbose = FALSE, model = FALSE,
    frame = FALSE)
}
\arguments{
  \item{formula}{the formula of the RDD. This is supplied
  in the format of \code{y ~ x} for a simple sharp RDD, or
  \code{y ~ x | c1 + c2} for a sharp RDD with two
  covariates. Fuzzy RDD may be specified as \code{y ~ x +
  z} where \code{x} is the running variable, and \code{z}
  is the endogenous treatment variable. Covariates are then
  included in the same manner as in a sharp RDD.}

  \item{data}{an optional data frame}

  \item{subset}{an optional vector specifying a subset of
  observations to be used}

  \item{cutpoint}{the cutpoint. If omitted, it is assumed
  to be 0.}

  \item{bw}{the bandwidth. If omitted, it is calculated
  using the Imbens-Kalyanaraman method.}

  \item{kernel}{a string specifying the kernel to be used
  in the local linear fitting. \code{"triangular"} kernel
  is the default and is the "correct" theoretical kernel to
  be used for edge estimation as in RDD (Lee and Lemieux
  2010). Other options are \code{"rectangular"},
  \code{"epanechnikov"}, \code{"quartic"},
  \code{"triweight"}, \code{"tricube"}, \code{"gaussian"}
  and \code{"cosine"}.}

  \item{se.type}{this specifies the robust SE calculation
  method to use. Options are, as in \code{\link{vcovHC}},
  \code{"HC3"}, \code{"const"}, \code{"HC"}, \code{"HC0"},
  \code{"HC1"}, \code{"HC2"}, \code{"HC4"}, \code{"HC4m"},
  \code{"HC5"}. This option is overriden by
  \code{cluster}.}

  \item{cluster}{an optional vector specifying clusters
  within which the errors are assumed to be correlated.
  This will result in reporting cluster robust SEs. This
  option overrides anything specified in \code{se.type}. It
  is suggested that data with a discrete running variable
  be clustered by each unique value of the running variable
  (Lee and Card 2008).}

  \item{verbose}{will provide some additional information
  printed to the terminal.}

  \item{frame}{logical. If \code{TRUE}, the data frame used
  in model fitting will be returned.}

  \item{model}{logical. If \code{TRUE}, the model object
  will be returned.}
}
\value{
  \code{RDestimate} returns an object of \link{class}
  "\code{RD}". The functions \code{summary} and \code{plot}
  are used to obtain and print a summary and plot of the
  estimated regression discontinuity. The object of class
  \code{RD} is a list containing the following components:
  \item{type}{a string denoting either \code{"sharp"} or
  \code{"fuzzy"} RDD.} \item{est}{the estimate of the
  discontinuity in the outcome under a sharp design, or the
  Wald estimator in the fuzzy design} \item{se}{the
  standard error} \item{z}{the z statistic} \item{p}{the p
  value} \item{ci}{the vector of the 95% confidence
  interval, \code{c("CI Lower Bound","CI Upper Bound")}}
  \item{bw}{the bandwidth} \item{call}{the matched call}
  \item{na.action}{the observations removed from fitting
  due to missingness} \item{model}{(if requested) For a
  sharp design, the \code{lm} object is returned. For a
  fuzzy design, a list is returned with two elements:
  \code{firststage}, the first stage \code{lm} object, and
  \code{iv}, the \code{ivreg} object.} \item{frame}{(if
  requested) Returns the model frame used in fitting.}
}
\description{
  \code{RDestimate} supports both sharp and fuzzy RDD
  utilizing the \pkg{AER} package for 2SLS regression under
  the fuzzy design. Local linear regressions are performed
  to either side of the cutpoint using the
  Imbens-Kalyanaraman optimal bandwidth calculation,
  \code{\link{IKbandwidth}}.
}
\examples{
x<-runif(1000,-1,1)
cov<-rnorm(1000)
y<-3+2*x+3*cov+10*(x>=0)+rnorm(1000)
RDestimate(y~x)
# Efficiency gains can be made by including covariates
RDestimate(y~x|cov)
}
\author{
  Drew Dimmery <\email{drewd@nyu.edu}>
}
\references{
  Lee, David and Thomas Lemieux. (2010) "Regression
  Discontinuity Designs in Economics," \emph{Journal of
  Economic Literature}. 48(2): 281-355.
  \url{http://www.aeaweb.org/articles.php?doi=10.1257/jel.48.2.281}

  Imbens, Guido and Thomas Lemieux. (2010) "Regression
  discontinuity designs: A guide to practice,"
  \emph{Journal of Econometrics}. 142(2): 615-635.
  \url{http://dx.doi.org/10.1016/j.jeconom.2007.05.001}

  Lee, David and David Card. (2010) "Regression
  discontinuity inference with specification error,"
  \emph{Journal of Econometrics}. 142(2): 655-674.
  \url{http://dx.doi.org/10.1016/j.jeconom.2007.05.003}

  Angrist, Joshua and Jorn-Steffen Pischke. (2009)
  \emph{Mostly Harmless Econometrics}. Princeton: Princeton
  University Press.
}
\seealso{
  \code{\link{summary.RD}}, \code{\link{plot.RD}},
  \code{\link{DCdensity}} \code{\link{IKbandwidth}},
  \code{\link{kernelwts}}, \code{\link{vcovHC}},
  \code{\link{ivreg}}, \code{\link{lm}}
}

