#' NYC neigborhood tabulation area boundaries
#'
#' A simple features (sf) dataset containing the geometry of all neighborhood
#' tabulation areas (NTAs) in New York City.
#'
#' Neighborhood tabulation areas (NTAs) were created by the NYC Department of
#' City Planning to project populations at a small area level. The boundaries
#' roughly match neighborhoods, but some neighborhoods were combined to reach
#' the minimum population of 15,000 per NTA. Each NTA was created from whole
#' census tracts to allow for aggregating census data to the NTA level.
#' Additionally, NTAs do not cross public use microdata area (PUMA) boundaries.
#'
#' NTAs are useful geographies because they offer a compromise between very
#' small areas like census blocks or tracts and larger areas like counties,
#' community districts, or PUMAs. Especially when using data from the American
#' Community Survey, NTAs can be useful to reduce the margin of error of single
#' census tract estimates.
#'
#' @format An sf object with 195 rows and 10 variables:
#' \describe{
#'   \item{nta_id}{NYC neighborhood tabulation area id}
#'   \item{nta_name}{NYC neighborhood tabulation area name}
#'   \item{state_fips}{ANSI state FIPS code}
#'   \item{county_fips}{ANSI county FIPS code}
#'   \item{county_name}{County name}
#'   \item{boro_name}{Borough name}
#'   \item{boro_id}{NYC DCP borough code and census tract number}
#'   \item{puma_id}{Census Bureau public use microdata area id}
#'   \item{puma_name}{Census Bureau public use microdata area name}
#'   \item{geometry}{sfc_MULTIPOLYGON \cr
#'   NAD83 / New York Long Island (ftUS); EPSG:2263}
#' }
#'
#' @source <https://www1.nyc.gov/site/planning/data-maps/open-data/dwn-nynta.page>
"nyc_nta"
