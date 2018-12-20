#' NYC census tract boundaries
#'
#' A simple features (sf) dataset containing the geometry of all census tracts
#' in New York City from the 2010 Census.
#'
#' @format An sf object with 2166 rows and 13 variables:
#' \describe{
#'   \item{geoid}{Census Bureau GEOID; can be used to join spatial data with
#'   Census estimates}
#'   \item{boro_tract_id}{NYC DCP borough code and census tract number}
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
#'
#' @source <https://www1.nyc.gov/site/planning/data-maps/open-data/districts-download-metadata.page>
"tracts_sf"

#' @rdname tracts_sf
"tracts_sf_simple"


#' NYC neighborhood tabulation area boundaries
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
"ntas_sf"

#' @rdname ntas_sf
"ntas_sf_simple"


#' NYC borough boundaries
#'
#' A simple features (sf) dataset containing the geometry of the five boroughs
#' of New York City. The boroughs of New York City are equivalent to counties.
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
"boros_sf"

#' @rdname boros_sf
"boros_sf_simple"

#' NYC public use microdata area boundaries
#'
#' A simple features (sf) dataset containing the geometry of all public use
#' microdata areas (PUMAs) in New York City.
#'
#' @format An sf object with 55 rows and 9 variables:
#' \describe{
#'   \item{geoid}{Census Bureau GEOID; can be used to join spatial data with
#'   Census estimates}
#'   \item{puma_id}{Census Bureau public use microdata area id}
#'   \item{puma_name}{Census Bureau public use microdata area name}
#'   \item{state_fips}{ANSI state FIPS code}
#'   \item{county_fips}{ANSI county FIPS code}
#'   \item{county_name}{County name}
#'   \item{boro_name}{Borough name}
#'   \item{boro_id}{NYC DCP borough code and census tract number}
#'   \item{geometry}{sfc_MULTIPOLYGON \cr
#'   NAD83 / New York Long Island (ftUS); EPSG:2263}
#' }
#'
#' @source <https://www1.nyc.gov/site/planning/data-maps/open-data.page#other>
"pumas_sf"

#' @rdname pumas_sf
"pumas_sf_simple"

#' NYC census block boundaries
#'
#' A simple features (sf) dataset containing the geometry of all census blocks
#' in New York City from the 2010 Census.
#'
#' @format An sf object with 38796 rows and 14 variables:
#' \describe{
#'   \item{geoid}{Census Bureau GEOID; can be used to join spatial data with
#'   Census estimates}
#'   \item{boro_tract_block_id}{NYC DCP borough code and census tract number}
#'   \item{state_fips}{ANSI state FIPS code}
#'   \item{county_fips}{ANSI county FIPS code}
#'   \item{block_id}{Census Bureau block number}
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
#'
#' @source <https://www1.nyc.gov/site/planning/data-maps/open-data/districts-download-metadata.page>
"blocks_sf"

#' NYC community district boundaries
#'
#' A simple features (sf) dataset containing the geometry of all community
#' districts (CDs) and joint interest areas in New York City.
#'
#' @format An sf object with 71 rows and 9 variables:
#' \describe{
#'   \item{boro_cd_id}{NYC borough and community district id; unique ids}
#'   \item{cd_id}{NYC community district id; ids repeat across boroughs}
#'   \item{cd_name}{NYC community district names}
#'   \item{state_fips}{ANSI state FIPS code}
#'   \item{county_fips}{ANSI county FIPS code}
#'   \item{county_name}{County name}
#'   \item{boro_name}{Borough name}
#'   \item{boro_id}{NYC DCP borough code and census tract number}
#'   \item{geometry}{sfc_MULTIPOLYGON \cr
#'   NAD83 / New York Long Island (ftUS); EPSG:2263}
#' }
#'
#' @source <https://www1.nyc.gov/site/planning/data-maps/open-data.page#other>
"cds_sf"

#' @rdname cds_sf
"cds_sf_simple"