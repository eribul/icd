% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/filter.R
\name{icd_filter_valid}
\alias{icd_filter_invalid}
\alias{icd_filter_invalid.icd9}
\alias{icd_filter_valid}
\alias{icd_filter_valid.icd9}
\title{Filter ICD-9 codes by validity.}
\usage{
icd_filter_valid(...)

icd_filter_invalid(...)

\method{icd_filter_valid}{icd9}(x, icd_name = NULL, short_code = NULL,
  invert = FALSE, ...)

\method{icd_filter_invalid}{icd9}(x, icd_name = NULL, short_code = NULL,
  invert = FALSE, ...)
}
\arguments{
\item{...}{arguments passed to the class-specific functions}

\item{x}{input vector of ICD codes}

\item{icd_name}{The column in the \code{data.frame} which contains the ICD
codes. This is a character vector of length one. If it is \code{NULL},
\code{icd9} will attempt to guess the column name, looking for
progressively less likely possibilities until it matches a single column.
Failing this, it will take the first column in the data frame. Specifying
the column using this argument avoids the guesswork.}

\item{short_code}{single logical value which determines whether the ICD-9
code provided is in short (\code{TRUE}) or decimal (\code{FALSE}) form.
Where reasonable, this is guessed from the input data.}

\item{invert}{Single logical value. Returns the inverse of the result. E.g.
if seeking valid ICD-9 codes, the invalid ones are returned.}
}
\description{
Filters a data.frame of patients for valid or invalid ICD-9
  codes
}
\section{Methods (by class)}{
\itemize{
\item \code{icd9}: Filter data frame for valid ICD-9 codes
}}

