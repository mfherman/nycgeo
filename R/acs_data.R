#' Tract-level American Community Survey estimates
#'
#' A dataset containing U.S. Census Bureau American Community Survey (ACS)
#' estimates and margins of error of selected demographic, social, and economic
#' variables for all census tracts in New York City. Variables are five-year
#' estimates from the 2012-2017 ACS.
#'
#' @format A tibble with 2177 rows and 30 variables:
#' \describe{
#'   \item{geoid}{Census Bureau GEOID}
#'   \item{pop_total}{Total population; B01001_001}
#'   \item{med_age}{Median age; B01002_001}
#'   \item{med_hhinc}{Median annual household income (dollars); B19013_001}
#'   \item{pop_white, pop_white_pct}{Non-hispanic white population; B03002_003}
#'   \item{pop_black, pop_black_pct}{Non-hispanic black population; B03002_004}
#'   \item{pop_hisp, pop_hisp_pct}{Hispanic, any race population; B03002_012}
#'   \item{pop_asian, pop_asian_pct}{Non-hispanic asian population; B03002_006}
#'   \item{pop_ba_above, pop_ba_above_pct}{Population 25 years or older with at
#'    least a Bachelor's degree; B15003_022, B15003_023, B15003_024, B15003_025}
#'   \item{pop_inpov, pop_inpov_pct}{Population with income below poverty line;
#'    B17021002}
#' }
#'
#'
#' @source <https://factfinder.census.gov/faces/nav/jsf/pages/index.xhtml>
"tracts_acs_data"


#' Neighborhood tabulation area-level American Community Survey estimates
#'
#' A dataset containing U.S. Census Bureau American Community Survey (ACS)
#' estimates and margins of error of selected demographic, social, and economic
#' variables for all neighborhood tabulation areas (NTAs) in New York City.
#' Variables are five-year tract-level estimates from the 2012-2017 ACS
#' aggregated to NTAs.
#'
#' NTAs were created by the NYC Department of City Planning to project
#' populations at a small area level. The boundaries roughly match
#' neighborhoods, but some neighborhoods were combined to reach the minimum
#' population of 15,000 per NTA. Each NTA was created from whole census tracts
#' to allow for aggregating census data to the NTA level. Additionally, NTAs do
#' not cross public use microdata area (PUMA) boundaries.
#'
#' NTAs are useful geographies because they offer a compromise between very
#' small areas like census blocks or tracts and larger areas like counties,
#' community districts, or PUMAs. Especially when using data from the American
#' Community Survey, NTAs can be useful to reduce the margin of error of single
#' census tract estimates.
#'
#' @format A tibble with 195 rows and 27 variables:
#' \describe{
#'   \item{nta_id}{NYC neighborhood tabulation area id}
#'   \item{pop_total_est, pop_total_moe}{Total population; B01001_001}
#'   \item{pop_white_est, pop_white_moe, pop_white_pct_est,
#'   pop_white_pct_moe}{Non-hispanic white population; B03002_003}
#'   \item{pop_black, pop_black_pct}{Non-hispanic black population; B03002_004}
#'   \item{pop_hisp, pop_hisp_pct}{Hispanic, any race population; B03002_012}
#'   \item{pop_asian, pop_asian_pct}{Non-hispanic asian population; B03002_006}
#'   \item{pop_ba_above, pop_ba_above_pct}{Population 25 years or older with at
#'   least a Bachelor's degree; B15003_022, B15003_023, B15003_024, B15003_025}
#'   \item{pop_inpov, pop_inpov_pct}{Population with income below poverty line;
#'   B17021002}
#' }
#'
#'
#' @source <https://factfinder.census.gov/faces/nav/jsf/pages/index.xhtml>
"ntas_acs_data"


#' Public use microdata area-level American Community Survey estimates
#'
#' A dataset containing U.S. Census Bureau American Community Survey (ACS)
#' estimates and margins of error of selected demographic, social, and economic
#' variables for all public use microdata areas (PUMAs) in New York City.
#' Variables are five-year estimates from the 2012-2017 ACS.
#'
#' @format A tibble with 55 rows and 35 variables:
#'
#' \describe{
#'   \item{geoid}{Census Bureau GEOID}
#'   \item{pop_total}{Total population; B01001_001}
#'   \item{med_age}{Median age; B01002_001}
#'   \item{med_hhinc}{Median annual household income (dollars); B19013_001}
#'   \item{pop_white, pop_white_pct}{Non-hispanic white population; B03002_003}
#'   \item{pop_black, pop_black_pct}{Non-hispanic black population; B03002_004}
#'   \item{pop_hisp, pop_hisp_pct}{Hispanic, any race population; B03002_012}
#'   \item{pop_asian, pop_asian_pct}{Non-hispanic asian population; B03002_006}
#'   \item{pop_ba_above, pop_ba_above_pct}{Population 25 years or older with at
#'    least a Bachelor's degree; B15003_022, B15003_023, B15003_024, B15003_025}
#'   \item{pop_inpov, pop_inpov_pct}{Population with income below poverty line;
#'    B17021002}
#' }
#'
#' @source <https://factfinder.census.gov/faces/nav/jsf/pages/index.xhtml>
"pumas_acs_data"