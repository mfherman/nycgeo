#' NYC census tract spatial dataset
#'
#' A dataset in sf format containing boundaries of all census tracts in New York
#' City.
#'
#' @format An sf object with 2166 rows and 12 variables:
#' \describe{
#'   \item{boro_tract_id}{NYC DCP borough code and census tract number}
#'   \item{geoid}{Census Bureau GEOID; can be used to join spatial data with
#'   Census estimates}
#'   \item{state_fips}{ANSI state FIPS code}
#'   \item{county_fips}{ANSI county FIPS code}
#'   \item{tract_id}{Census Bureau tract number}
#'   \item{county_name}{County name}
#'   \item{boro_name}{Borough name}
#'   \item{boro_id}{NYC DCP borough code and census tract number}
#'   \item{nta_id}{NYC neighborhood tabulation area id}
#'   \item{nta_name}{NYC neighborhood tabulation area name}
#'   \item{puma_id}{Census Bureau public use microdata area id}
#'   \item{puma_name}{Census Bureau public use microdata area name}
#'   \item{geometry}{sfc_MULTIPOLYGON \cr
#'   NAD83 / New York Long Island (ftUS); EPSG:2263}
#' }
#' @source \url{https://www1.nyc.gov/site/planning/data-maps/open-data/districts-download-metadata.page}
"nyc_tract"