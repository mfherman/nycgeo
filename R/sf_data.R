#' NYC census tract boundaries
#'
#' A simple features (sf) dataset containing the geometry of all census tracts
#' in New York City from the 2010 Census.
#'
#' @format An sf object with 2166 rows and 13 variables:
#' \describe{
#'   \item{geoid}{Census Bureau GEOID; can be used to join spatial data with
#'   Census estimates}
#'   \item{borough_tract_id}{NYC DCP borough code and census tract number}
#'   \item{state_fips}{ANSI state FIPS code}
#'   \item{county_fips}{ANSI county FIPS code}
#'   \item{tract_id}{Census Bureau tract number}
#'   \item{county_name}{County name}
#'   \item{borough_name}{Borough name}
#'   \item{borough_id}{NYC DCP borough code and census tract number}
#'   \item{nta_id}{NYC neighborhood tabulation area id}
#'   \item{nta_name}{NYC neighborhood tabulation area name}
#'   \item{puma_id}{Census Bureau public use microdata area id}
#'   \item{puma_name}{Census Bureau public use microdata area name}
#'   \item{geometry}{sfc_MULTIPOLYGON \cr
#'   NAD83 / New York Long Island (ftUS); EPSG:2263}
#' }
#'
#' @source <https://www1.nyc.gov/site/planning/data-maps/open-data/districts-download-metadata.page>
"tract_sf"

#' @rdname tract_sf
"tract_sf_simple"


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
#'   \item{borough_name}{Borough name}
#'   \item{borough_id}{NYC DCP borough code and census tract number}
#'   \item{puma_id}{Census Bureau public use microdata area id}
#'   \item{puma_name}{Census Bureau public use microdata area name}
#'   \item{geometry}{sfc_MULTIPOLYGON \cr
#'   NAD83 / New York Long Island (ftUS); EPSG:2263}
#' }
#'
#' @source <https://www1.nyc.gov/site/planning/data-maps/open-data/dwn-nynta.page>
"nta_sf"

#' @rdname nta_sf
"nta_sf_simple"


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
#'   \item{borough_name}{Borough name}
#'   \item{borough_id}{NYC DCP borough code and census tract number}
#'   \item{geometry}{sfc_MULTIPOLYGON \cr
#'   NAD83 / New York Long Island (ftUS); EPSG:2263}
#' }
#'
#' @source <https://www1.nyc.gov/site/planning/data-maps/open-data/districts-download-metadata.page>
"borough_sf"

#' @rdname borough_sf
"borough_sf_simple"

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
#'   \item{borough_name}{Borough name}
#'   \item{borough_id}{NYC DCP borough code and census tract number}
#'   \item{geometry}{sfc_MULTIPOLYGON \cr
#'   NAD83 / New York Long Island (ftUS); EPSG:2263}
#' }
#'
#' @source <https://www1.nyc.gov/site/planning/data-maps/open-data.page#other>
"puma_sf"

#' @rdname puma_sf
"puma_sf_simple"

#' NYC census block boundaries
#'
#' A simple features (sf) dataset containing the geometry of all census blocks
#' in New York City from the 2010 Census.
#'
#' @format An sf object with 38796 rows and 14 variables:
#' \describe{
#'   \item{geoid}{Census Bureau GEOID; can be used to join spatial data with
#'   Census estimates}
#'   \item{borough_tract_block_id}{NYC DCP borough code and census tract number}
#'   \item{state_fips}{ANSI state FIPS code}
#'   \item{county_fips}{ANSI county FIPS code}
#'   \item{block_id}{Census Bureau block number}
#'   \item{tract_id}{Census Bureau tract number}
#'   \item{county_name}{County name}
#'   \item{borough_name}{Borough name}
#'   \item{borough_id}{NYC DCP borough code and census tract number}
#'   \item{nta_id}{NYC neighborhood tabulation area id}
#'   \item{nta_name}{NYC neighborhood tabulation area name}
#'   \item{puma_id}{Census Bureau public use microdata area id}
#'   \item{puma_name}{Census Bureau public use microdata area name}
#'   \item{geometry}{sfc_MULTIPOLYGON \cr
#'   NAD83 / New York Long Island (ftUS); EPSG:2263}
#' }
#'
#' @source <https://www1.nyc.gov/site/planning/data-maps/open-data/districts-download-metadata.page>
"block_sf"

#' NYC community district boundaries
#'
#' A simple features (sf) dataset containing the geometry of all community
#' districts (CDs) and joint interest areas in New York City.
#'
#' @format An sf object with 71 rows and 9 variables:
#' \describe{
#'   \item{borough_cd_id}{NYC borough and community district id; unique ids}
#'   \item{cd_id}{NYC community district id; ids repeat across boroughs}
#'   \item{cd_name}{NYC community district names}
#'   \item{state_fips}{ANSI state FIPS code}
#'   \item{county_fips}{ANSI county FIPS code}
#'   \item{county_name}{County name}
#'   \item{borough_name}{Borough name}
#'   \item{borough_id}{NYC DCP borough code and census tract number}
#'   \item{geometry}{sfc_MULTIPOLYGON \cr
#'   NAD83 / New York Long Island (ftUS); EPSG:2263}
#' }
#'
#' @source <https://www1.nyc.gov/site/planning/data-maps/open-data.page#other>
"cd_sf"

#' @rdname cd_sf
"cd_sf_simple"

#' NYC school district boundaries
#'
#' A simple features (sf) dataset containing the geometry of all community
#' school districts in New York City.
#'
#' @format An sf object with 32 rows and 4 variables:
#' \describe{
#'   \item{school_dist_id}{NYC school district id}
#'   \item{school_dist_name}{NYC school district name}
#'   \item{state_fips}{ANSI state FIPS code}
#'   \item{geometry}{sfc_MULTIPOLYGON \cr
#'   NAD83 / New York Long Island (ftUS); EPSG:2263}
#' }
#'
#' @source <https://www1.nyc.gov/site/planning/data-maps/open-data.page#other>
"school_sf"

#' @rdname school_sf
"school_sf_simple"

#' NYC police precinct boundaries
#'
#' A simple features (sf) dataset containing the geometry of all police
#' precincts in New York City.
#'
#' @format An sf object with 77 rows and 4 variables:
#' \describe{
#'   \item{police_precinct_id}{NYC police precinct id}
#'   \item{police_precinct_name}{NYC police precinct name}
#'   \item{state_fips}{ANSI state FIPS code}
#'   \item{geometry}{sfc_MULTIPOLYGON \cr
#'   NAD83 / New York Long Island (ftUS); EPSG:2263}
#' }
#'
#' @source <https://www1.nyc.gov/site/planning/data-maps/open-data.page#other>
"police_sf"

#' @rdname police_sf
"police_sf_simple"

#' NYC city council district boundaries
#'
#' A simple features (sf) dataset containing the geometry of all city council
#' districts in New York City.
#'
#' @format An sf object with 51 rows and 4 variables:
#' \describe{
#'   \item{council_dist_id}{NYC city council district id}
#'   \item{council_dist_name}{NYC city council district name}
#'   \item{state_fips}{ANSI state FIPS code}
#'   \item{geometry}{sfc_MULTIPOLYGON \cr
#'   NAD83 / New York Long Island (ftUS); EPSG:2263}
#' }
#'
#' @source <https://www1.nyc.gov/site/planning/data-maps/open-data.page#other>
"council_sf"

#' @rdname council_sf
"council_sf_simple"

#' U.S Congressional district boundaries in NYC
#'
#' A simple features (sf) dataset containing the geometry of all U.S.
#' Congressional districts in New York City.
#'
#' @format An sf object with 13 rows and 5 variables:
#' \describe{
#'   \item{geoid}{Census Bureau GEOID; can be used to join spatial data with
#'   Census estimates}
#'   \item{council_dist_id}{NYC city council district id}
#'   \item{council_dist_name}{NYC city council district name}
#'   \item{state_fips}{ANSI state FIPS code}
#'   \item{geometry}{sfc_MULTIPOLYGON \cr
#'   NAD83 / New York Long Island (ftUS); EPSG:2263}
#' }
#'
#' @source <https://www1.nyc.gov/site/planning/data-maps/open-data.page#other>
"cong_sf"

#' @rdname cong_sf
"cong_sf_simple"