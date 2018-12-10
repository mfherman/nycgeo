#' NYC borough boundaries
#'
#' A simple features (sf) dataset containing the geometry of the five boroughs
#' of New York City. The boroughs of New York City are equivalent to counties.
#'
#'
#' @format An sf object with 5 rows and 8 variables:
#' \describe{
#'   \item{geoid}{Census Bureau GEOID; can be used to join spatial data with
#'   Census estimates}
#'   \item{state_fips}{ANSI state FIPS code}
#'   \item{county_fips}{ANSI county FIPS code}
#'   \item{county_name}{County name}
#'   \item{boro_name}{Borough name}
#'   \item{boro_id}{NYC DCP borough code and census tract number}
#'   \item{geometry}{sfc_MULTIPOLYGON \cr
#'   NAD83 / New York Long Island (ftUS); EPSG:2263}
#' }
#'
#' @source <https://www1.nyc.gov/site/planning/data-maps/open-data/districts-download-metadata.page>
"nyc_boro"

#' @rdname nyc_boro
"nyc_boro_simple"