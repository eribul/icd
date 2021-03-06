% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/real.R
\name{icd9cm_is_billable}
\alias{icd9cm_is_billable}
\alias{icd9cm_is_billable.icd_decimal_code}
\alias{icd9cm_is_billable.icd_short_code}
\title{Check whether ICD-9 code(s) is/are billable}
\usage{
icd9cm_is_billable(x, version = icd9cm_latest_edition())

\method{icd9cm_is_billable}{icd_short_code}(x,
  version = icd9cm_latest_edition())

\method{icd9cm_is_billable}{icd_decimal_code}(x,
  version = icd9cm_latest_edition())
}
\description{
Tests ICD-9 codes to see whether they are leaf nodes in the ICD-9-CM hierarchy
}
\section{Methods (by class)}{
\itemize{
\item \code{icd_short_code}: Are the given short-form codes leaf (billable)
codes in the hierarchy?

\item \code{icd_decimal_code}: Are the given decimal-form codes leaf (billable)
codes in the hierarchy?
}}
\keyword{internal}

