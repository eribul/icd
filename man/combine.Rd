% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/class.R
\name{combine}
\alias{c.icd10}
\alias{c.icd10cm}
\alias{c.icd10who}
\alias{c.icd9}
\alias{c.icd9cm}
\alias{c.icd_decimal_code}
\alias{c.icd_short_code}
\alias{combine}
\title{combine ICD codes}
\usage{
\method{c}{icd9}(...)

\method{c}{icd9cm}(...)

\method{c}{icd10}(...)

\method{c}{icd10cm}(...)

\method{c}{icd10who}(...)

\method{c}{icd_short_code}(...)

\method{c}{icd_decimal_code}(...)
}
\arguments{
\item{...}{elements to combine}
}
\description{
These function implement combination of lists or vectors of codes, while
preserving ICD classes. Base R \code{c} just drops all user defined classes
and casts down to lowest common denominator, e.g. if mixing numbers and
characters. No attempt here to catch all possible combinations of feeding in
mixed ICD types and other types. Let R do what it normally does, but just try
to keep classes of the first item in the list.
}
\examples{
\dontrun{
# throw an error
c(icd9("E998"), icd10("A10"))
}
}
\keyword{internal}

