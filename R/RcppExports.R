# This file was generated by Rcpp::compileAttributes
# Generator token: 10BE3573-1514-4C36-9D1C-5A225CD40393

#' @rdname icd_comorbid
#' @description \link{Rcpp} approach to comorbidity assignment with OpenMP and
#'   vector of integers strategy. It is very fast, and most time is now spent
#'   setting up the data to be passed in.
#' @param aggregate single logical value, if \code{TRUE}, then take (possible
#'   much) more time to aggregate out-of-sequence visit IDs in the input
#'   data.frame. If this is \code{FALSE}, then each contiguous group of visit
#'   IDs will result in a row of comorbidities in the output data. If you know
#'   whether your visit IDs are disordered, then use \code{TRUE}.
#' @keywords internal
icd9ComorbidShortCpp <- function(icd9df, icd9Mapping, visitId, icd9Field, threads = 8L, chunk_size = 256L, omp_chunk_size = 1L, aggregate = TRUE) {
    .Call('icd_icd9ComorbidShortCpp', PACKAGE = 'icd', icd9df, icd9Mapping, visitId, icd9Field, threads, chunk_size, omp_chunk_size, aggregate)
}

icd9MajMinToCode <- function(major, minor, isShort) {
    .Call('icd_icd9MajMinToCode', PACKAGE = 'icd', major, minor, isShort)
}

icd9MajMinToShort <- function(major, minor) {
    .Call('icd_icd9MajMinToShort', PACKAGE = 'icd', major, minor)
}

icd9MajMinToDecimal <- function(major, minor) {
    .Call('icd_icd9MajMinToDecimal', PACKAGE = 'icd', major, minor)
}

#' @rdname convert
#' @keywords internal manip
icd9PartsToShort <- function(parts) {
    .Call('icd_icd9PartsToShort', PACKAGE = 'icd', parts)
}

#' @rdname convert
#' @keywords internal manip
icd9PartsToDecimal <- function(parts) {
    .Call('icd_icd9PartsToDecimal', PACKAGE = 'icd', parts)
}

icd9MajMinToParts <- function(major, minor) {
    .Call('icd_icd9MajMinToParts', PACKAGE = 'icd', major, minor)
}

#' @rdname convert
#' @keywords internal manip
icd9ShortToPartsCpp <- function(icd9Short, minorEmpty) {
    .Call('icd_icd9ShortToPartsCpp', PACKAGE = 'icd', icd9Short, minorEmpty)
}

#' @rdname convert
#' @keywords internal manip
icd9DecimalToPartsCpp <- function(icd9Decimal, minorEmpty) {
    .Call('icd_icd9DecimalToPartsCpp', PACKAGE = 'icd', icd9Decimal, minorEmpty)
}

icd9ShortToDecimalCpp <- function(x) {
    .Call('icd_icd9ShortToDecimal', PACKAGE = 'icd', x)
}

icd9DecimalToShortCpp <- function(x) {
    .Call('icd_icd9DecimalToShort', PACKAGE = 'icd', x)
}

#' @describeIn icd_get_major Get major part of ICD-9 code, i.e. first three
#' digits of numeric or V code, or first four digits of E code. This is the part
#' before the decimal, when a decimal point is used.
#' @keywords internal manip
icd_get_major.icd9 <- function(x, short_code) {
    .Call('icd_icd9GetMajor', PACKAGE = 'icd', x, short_code)
}

#' Do elements of vector begin with V, E (or any other character)?
#'
#' Current returns a vector of \code{bool} which is not thread safe, or
#' particularly fast, although it is memory efficient in the standard
#' implementation. As of \code{icd9} (now known as \code{icd}) version 1.2,
#' this is not called by threaded code, but this could change, so beware! ASCII
#' spaces are trimmed from the start of the string before testing, but no other
#' white space
#' @param sv vector of strings
#' @param x \code{const char*} of choices of first character to match
#' @param invert single logical, if TRUE, negates the condition
#' @keywords internal
icd9_is_n_cpp <- function(sv) {
    .Call('icd_icd9_is_n_cpp', PACKAGE = 'icd', sv)
}

#' @rdname icd9_is_n_cpp
#' @keywords internal
icd9_is_v_cpp <- function(sv) {
    .Call('icd_icd9_is_v_cpp', PACKAGE = 'icd', sv)
}

#' @rdname icd9_is_n_cpp
#' @keywords internal
icd9_is_e_cpp <- function(sv) {
    .Call('icd_icd9_is_e_cpp', PACKAGE = 'icd', sv)
}

icd_long_to_wide_cpp <- function(icd9df, visitId, icd9Field, aggregate = TRUE) {
    .Call('icd_icd9LongToWideCpp', PACKAGE = 'icd', icd9df, visitId, icd9Field, aggregate)
}

icd9AddLeadingZeroesMajorSingle <- function(major) {
    .Call('icd_icd9AddLeadingZeroesMajorSingle', PACKAGE = 'icd', major)
}

icd9AddLeadingZeroesMajorSingleStd <- function(m) {
    .Call('icd_icd9AddLeadingZeroesMajorSingleStd', PACKAGE = 'icd', m)
}

icd9_add_leading_zeroes_major <- function(major) {
    .Call('icd_icd9AddLeadingZeroesMajor', PACKAGE = 'icd', major)
}

#' @rdname icd9AddLeadingZeroes
icd9_add_leading_zeroes.icd_short_code <- function(x) {
    .Call('icd_icd9AddLeadingZeroesShort', PACKAGE = 'icd', x)
}

#' @rdname icd9AddLeadingZeroes
icd9_add_leading_zeroes.icd_decimal_code <- function(x) {
    .Call('icd_icd9AddLeadingZeroesDecimal', PACKAGE = 'icd', x)
}

#' @title Add leading zeroes to incomplete ICD codes
#' @description Non-decimal ICD-9 codes with length<5 are often ambiguous. E.g.
#'   100 could be 1.00 10.0 or 100 if coded incorrectly. We must assume 100 is
#'   really 100
#' @template icd9-any
#' @template icd9-short
#' @template icd9-decimal
#' @template major
#' @return character vector of ICD codes (or major part thereof)
#' @keywords internal manip
icd9AddLeadingZeroes <- function(icd9, isShort) {
    .Call('icd_icd9AddLeadingZeroes', PACKAGE = 'icd', icd9, isShort)
}

icd9ExpandMinorShim <- function(minor, isE = FALSE) {
    .Call('icd_icd9ExpandMinorShim', PACKAGE = 'icd', minor, isE)
}

icd9ChildrenShortCpp <- function(icd9Short, onlyReal) {
    .Call('icd_icd9ChildrenShortCpp', PACKAGE = 'icd', icd9Short, onlyReal)
}

icd9ChildrenDecimalCpp <- function(icd9Decimal, onlyReal) {
    .Call('icd_icd9ChildrenDecimalCpp', PACKAGE = 'icd', icd9Decimal, onlyReal)
}

icd9ChildrenCpp <- function(icd9, isShort, onlyReal = TRUE) {
    .Call('icd_icd9ChildrenCpp', PACKAGE = 'icd', icd9, isShort, onlyReal)
}

#' @title match ICD9 codes
#' @description Finds children of \code{icd9Reference} and looks for \code{icd9} in the
#'   resulting vector.
#' @templateVar icd9AnyName "icd9,icd9Reference"
#' @template icd9-any
#' @template short_code
#' @param isShortReference logical, see argument \code{short_code}
#' @return logical vector
#' @keywords internal
icd_in_reference_code <- function(icd, icd_reference, short_code, short_reference = TRUE) {
    .Call('icd_icd_in_reference_code', PACKAGE = 'icd', icd, icd_reference, short_code, short_reference)
}

trimLeftCpp <- function(s) {
    .Call('icd_trimLeftCpp', PACKAGE = 'icd', s)
}

strimCpp <- function(s) {
    .Call('icd_strimCpp', PACKAGE = 'icd', s)
}

trimCpp <- function(sv) {
    .Call('icd_trimCpp', PACKAGE = 'icd', sv)
}

getOmpCores <- function() {
    .Call('icd_getOmpCores', PACKAGE = 'icd')
}

getOmpMaxThreads <- function() {
    .Call('icd_getOmpMaxThreads', PACKAGE = 'icd')
}

getOmpThreads <- function() {
    .Call('icd_getOmpThreads', PACKAGE = 'icd')
}

randomMajorCpp <- function(n) {
    .Call('icd_randomMajorCpp', PACKAGE = 'icd', n)
}

#' @rdname icd9RandomShort
#' @keywords internal
icd9RandomShortN <- function(n = 5L) {
    .Call('icd_icd9RandomShortN', PACKAGE = 'icd', n)
}

#' @rdname icd9RandomShort
#' @keywords internal
icd9RandomShortV <- function(n = 5L) {
    .Call('icd_icd9RandomShortV', PACKAGE = 'icd', n)
}

#' @rdname icd9RandomShort
#' @keywords internal
icd9RandomShortE <- function(n = 5L) {
    .Call('icd_icd9RandomShortE', PACKAGE = 'icd', n)
}

#' Generate random short-form ICD-9 codes
#'
#' Quick pseudo-random by picking numeric, 'V' or 'E' based on modulo three of
#' the number
#' @keywords internal
icd9RandomShort <- function(n = 5L) {
    .Call('icd_icd9RandomShort', PACKAGE = 'icd', n)
}

#' Fast convert integer vector to character vector
#'
#' Fast conversion from integer vector to character vector using C++
#' @param x vector of integers
#' @param bufferSize int if any input strings are longer than this number
#'   (default 16) there will be memory errors. No checks done for speed.
#' @examples
#' \dontrun{
#' pts <- generate_random_pts(1e7)
#' # conclusion: buffer size matters little (so default to be more generous),
#' # and Rcpp version fastest.
#' microbenchmark::microbenchmark(fastIntToStringStd(pts$visit_id, buffer = 8),
#'                                fastIntToStringStd(pts$visit_id, buffer = 16),
#'                                fastIntToStringStd(pts$visit_id, buffer = 64),
#'                                fastIntToStringRcpp(pts$visit_id, buffer = 8),
#'                                fastIntToStringRcpp(pts$visit_id, buffer = 16),
#'                                fastIntToStringRcpp(pts$visit_id, buffer = 64),
#'                                as.character(pts$visit_id),
#'                                asCharacterNoWarn(pts$visit_id), times = 5)
#' }
#' @rdname fastIntToString
#' @keywords internal
fastIntToStringStd <- function(x) {
    .Call('icd_fastIntToStringStd', PACKAGE = 'icd', x)
}

#' @rdname fastIntToString
fastIntToStringRcpp <- function(x) {
    .Call('icd_fastIntToStringRcpp', PACKAGE = 'icd', x)
}

valgrindCallgrindStart <- function(zerostats = FALSE) {
    .Call('icd_valgrindCallgrindStart', PACKAGE = 'icd', zerostats)
}

valgrindCallgrindStop <- function() {
    .Call('icd_valgrindCallgrindStop', PACKAGE = 'icd')
}

# Register entry points for exported C++ functions
methods::setLoadAction(function(ns) {
    .Call('icd_RcppExport_registerCCallable', PACKAGE = 'icd')
})
