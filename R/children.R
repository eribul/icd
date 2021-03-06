# Copyright (C) 2014 - 2016  Jack O. Wasey
#
# This file is part of icd.
#
# icd is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# icd is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with icd. If not, see <http:#www.gnu.org/licenses/>.

#' Get children of ICD codes
#'
#' Expand ICD codes to all possible sub-codes, optionally limiting to those
#' codes which are \emph{defined} or \emph{billable} (leaf nodes).
#' @param x data, e.g. character vector of ICD codes.
#' @param defined single logical value, whether returned codes should only
#'   include those which have definitions. Definition is based on the ICD
#'   version being used, e.g. ICD-9-CM, the WHO version of ICD-10, or other.
#' @param billable single logical value, whether to limit return codes also by
#'   whether they are billable, i.e. leaf nodes. This is really only designed
#'   for use with ICD-9-CM, ICD-10-CM etc, since the WHO versions are not
#'   designed for billing, but for public health and death reporting.
#' @template short_code
#' @template dotdotdot
#' @keywords manip
#' @family ICD-9 ranges
#' @examples
#' library(magrittr, warn.conflicts = FALSE, quietly = TRUE) # optional
#'
#' # no children other than self
#' icd_children("10201", short_code = TRUE, defined =FALSE)
#'
#' # guess it was ICD-9 and a short, not decimal code
#' icd_children("0032")
#'
#' # empty because 102.01 is not meaningful
#' icd_children("10201", short_code = TRUE, defined =TRUE)
#' icd_children("003", short_code = TRUE, defined =TRUE) %>%
#'   icd_explain(condense = FALSE, short_code = TRUE)
#'
#' icd_children(short_code = FALSE, "100.0")
#' icd_children(short_code = FALSE, "100.00")
#' icd_children(short_code = FALSE, "2.34")
#' @export
icd_children <- function(x, ...)
  UseMethod("icd_children")

#' @describeIn icd_children Get child codes, guessing ICD version and short
#'   versus decimal format
#' @export
icd_children.character <- function(x, ...) {
  ver <- icd_guess_version(x)
  # eventually UseMethod again, but this would be circular until the icd10
  # method is defined.
  switch(ver,
         "icd9" = icd_children.icd9(x = x, ...),
         "icd10" = icd_children.icd10(x = x, ...),
         NULL)
}

#' @describeIn icd_children Get children of ICD-9 codes
#' @export
icd_children.icd9 <- function(x, short_code = icd_guess_short(x),
                              defined = TRUE, billable = FALSE, ...) {
  assert(checkmate::checkFactor(x), checkmate::checkCharacter(x))
  assert_flag(short_code)
  assert_flag(defined)
  assert_flag(billable)

  if (short_code)
    res <- .Call("icd_icd9ChildrenShortCpp", PACKAGE = "icd", toupper(x), defined)
  else
    res <- .Call("icd_icd9ChildrenDecimalCpp", PACKAGE = "icd", toupper(x), defined)

  res <- icd_guess_short_update(res)

  if (billable)
    icd_get_billable.icd9cm(icd9cm(res), short_code)
  else
    icd9(res)
}

#' @describeIn icd_children Get children of ICD-10 codes (warns because this
#'   only applies to ICD-10-CM for now)
#' @export
#' @keywords internal
icd_children.icd10 <- function(x, short_code = icd_guess_short.icd10(x), defined, billable = FALSE, ...) {
  warning("Finding children of ICD-10 codes currently assumes ICD-10-CM (2016)")
  icd_children.icd10cm(x, short_code, defined, billable, ...)
}

#' @describeIn icd_children Get children of ICD-10-CM codes
#' @export
#' @keywords internal
icd_children.icd10cm <- function(x, short_code = icd_guess_short.icd10(x), defined, billable = FALSE, ...) {
  assert(checkmate::checkFactor(x), checkmate::checkCharacter(unclass(x)))
  assert_flag(short_code)
  assert_flag(billable)

  if (!missing(defined) && !defined)
    stop("Finding children of anything but defined ICD-10-CM codes is current not supported.")

  icd_children_defined.icd10cm(x = x, short_code = short_code)
}

# this is just lazy package data, but apparently need to declare it to keep CRAN
# happy. May not be needed if doing icd::
utils::globalVariables("icd10cm2016")

#' defined children of ICD codes
#'
#' defined ICD-10 children based on 2016 ICD-10-CM list. "defined" may be a
#' three digit code, or a leaf node. This is distinct from 'billable'.
#'
#' @keywords internal
icd_children_defined <- function(x)
  UseMethod("icd_children_defined")

#' @describeIn icd_children_defined get the children of ICD-10 code(s)
#' @keywords internal
icd_children_defined.icd10cm <- function(x, short_code = icd_guess_short.icd10(x)) {

  assert_character(x)
  assert_flag(short_code)

  x <- str_trim(x)
  icd10Short <- if (short_code) x else icd_decimal_to_short.icd10cm(x)

  matches_bool <- icd10Short %in% icd::icd10cm2016[["code"]]
  # if the codes are not in the source file, we ignore, warn, drop silently?
  if (!all(matches_bool)) warning("some values did not match any ICD-10-CM codes: ",
                                  paste(icd10Short[!matches_bool], collapse = ", "))

  icd10Short <- icd10Short[matches_bool]
  matches <- match(icd10Short, icd::icd10cm2016[["code"]])
  last_row <- nrow(icd::icd10cm2016)

  # TODO: pre-compute and save in package data?
  nc <- nchar(icd::icd10cm2016[["code"]])

  kids <- character(0)

  if (length(icd10Short) == 0) {
    if (length(x) > 0)
      warning("none of the provided ICD-10 codes matched the canonical list")
    return(icd10cm(character(0)))
  }

  for (i in seq_along(icd10Short)) {
    # now the children, assuming the source file is sorted logically, will be
    # subsequent codes, until a code of the same length is found
    check_row <- matches[i] + 1
    parent_len <- nc[matches[i]]
    while (nc[check_row] > parent_len && check_row != last_row + 1)
      check_row <- check_row + 1

    kids <- c(kids, icd::icd10cm2016[matches[i]:(check_row - 1), "code"])
  }

  if (short_code)
    icd10cm(icd_short_code(kids))
  else
    icd10cm(icd_decimal_code(kids))
}
