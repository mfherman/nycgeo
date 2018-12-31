#' Tract-level American Community Survey estimates
#'
#' A dataset containing U.S. Census Bureau American Community Survey (ACS)
#' estimates and margins of error of selected demographic, social, and economic
#' variables for all census tracts in New York City. Variables are five-year
#' estimates from the 2013-2017 ACS.
#'
#' @format A tibble with 2167 rows and 35 variables:
#' \describe{
#'   \item{geoid}{Census Bureau GEOID}
#'   \item{pop_total_est}{Total population estimate; B01001_001}
#'   \item{med_age_est}{Median age estimate; B01002_001}
#'   \item{med_age_moe}{Median age margin of error; B01002_001}
#'   \item{med_hhinc_est}{Median annual household income estimate (dollars);
#'   B19013_001}
#'   \item{med_hhinc_moe}{Median annual household income margin of error
#'   (dollars); B19013_001}
#'   \item{pop_white_est, pop_white_pct_est}{Non-hispanic white population
#'   estimate; B03002_003}
#'   \item{pop_white_moe, pop_white_pct_moe}{Non-hispanic white population
#'   margin of error; B03002_003}
#'   \item{pop_black_est, pop_black_pct_est}{Non-hispanic black population
#'   estimate; B03002_004}
#'   \item{pop_black_moe, pop_black_pct_moe}{Non-hispanic black population
#'   margin of error; B03002_004}
#'   \item{pop_asian_est, pop_asian_pct_est}{Non-hispanic asian population
#'   estimate; B03002_006}
#'   \item{pop_asian_moe, pop_asian_pct_moe}{Non-hispanic asian population
#'   margin of error; B03002_006}
#'   \item{pop_hisp_est, pop_hisp_pct_est}{Hispanic, any race population
#'   estimate; B03002_012}
#'   \item{pop_hisp_moe, pop_hisp_pct_moe}{Hispanic, any race population margin
#'   of error; B03002_012}
#'   \item{pop_ba_above_est, pop_ba_above_pct_est}{Population 25 years or older
#'   with at least a Bachelor's degree estimate; B15003_022, B15003_023,
#'   B15003_024, B15003_025}
#'   \item{pop_ba_above_moe, pop_ba_above_pct_moe}{Population 25 years or older
#'   with at least a Bachelor's degree margin of error; B15003_022, B15003_023,
#'   B15003_024, B15003_025}
#'   \item{pop_educ_denom_est}{Population 25 years or older estimate;
#'   Denominator used to calculate Bachelor's and above percentage; B15003_001}
#'   \item{pop_educ_denom_moe}{Population 25 years or older margin of error;
#'   Denominator used to calculate Bachelor's and above percentage; B15003_001}
#'   \item{pop_inpov_est, pop_inpov_pct_est}{Population with income below
#'   poverty line estimate; B17021_002}
#'   \item{pop_inpov_moe, pop_inpov_pct_moe}{Population with income below
#'   poverty line margin of error; B17021_002}
#'   \item{pop_inpov_denom_est}{Population for whom poverty status is determined
#'   estimate; Denominator used to calculate in poverty percentage; B17021_001}
#'   \item{pop_inpov_denom_moe}{Population for whom poverty status is determined
#'   margin of error; Denominator used to calculate in poverty percentage;
#'   B17021_001}
#'   }
#'
#' @source <https://factfinder.census.gov/faces/nav/jsf/pages/index.xhtml>
"tract_acs_data"


#' Neighborhood tabulation area-level American Community Survey estimates
#'
#' A dataset containing U.S. Census Bureau American Community Survey (ACS)
#' estimates and margins of error of selected demographic, social, and economic
#' variables for all neighborhood tabulation areas (NTAs) in New York City.
#' Variables are five-year tract-level estimates from the 2013-2017 ACS
#' aggregated to NTAs. Six of the 195 NTAs cover parks, cemeteries, and airports
#' and do not have any population. They are not included in this dataset.
#'
#' @details NTAs were created by the NYC Department of City Planning to project
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
#' @format A tibble with 189 rows and 27 variables:
#' \describe{
#'   \item{geoid}{Census Bureau GEOID}
#'   \item{pop_total_est}{Total population estimate; B01001_001}
#'   \item{pop_white_est, pop_white_pct_est}{Non-hispanic white population
#'   estimate; B03002_003}
#'   \item{pop_white_moe, pop_white_pct_moe}{Non-hispanic white population
#'   margin of error; B03002_003}
#'   \item{pop_black_est, pop_black_pct_est}{Non-hispanic black population
#'   estimate; B03002_004}
#'   \item{pop_black_moe, pop_black_pct_moe}{Non-hispanic black population
#'   margin of error; B03002_004}
#'   \item{pop_asian_est, pop_asian_pct_est}{Non-hispanic asian population
#'   estimate; B03002_006}
#'   \item{pop_asian_moe, pop_asian_pct_moe}{Non-hispanic asian population
#'   margin of error; B03002_006}
#'   \item{pop_hisp_est, pop_hisp_pct_est}{Hispanic, any race population
#'   estimate; B03002_012}
#'   \item{pop_hisp_moe, pop_hisp_pct_moe}{Hispanic, any race population margin
#'   of error; B03002_012}
#'   \item{pop_ba_above_est, pop_ba_above_pct_est}{Population 25 years or older
#'   with at least a Bachelor's degree estimate; B15003_022, B15003_023,
#'   B15003_024, B15003_025}
#'   \item{pop_ba_above_moe, pop_ba_above_pct_moe}{Population 25 years or older
#'   with at least a Bachelor's degree margin of error; B15003_022, B15003_023,
#'   B15003_024, B15003_025}
#'   \item{pop_educ_denom_est}{Population 25 years or older estimate;
#'   Denominator used to calculate Bachelor's and above percentage; B15003_001}
#'   \item{pop_educ_denom_moe}{Population 25 years or older margin of error;
#'   Denominator used to calculate Bachelor's and above percentage; B15003_001}
#'   \item{pop_inpov_est, pop_inpov_pct_est}{Population with income below
#'   poverty line estimate; B17021_002}
#'   \item{pop_inpov_moe, pop_inpov_pct_moe}{Population with income below
#'   poverty line margin of error; B17021_002}
#'   \item{pop_inpov_denom_est}{Population for whom poverty status is determined
#'   estimate; Denominator used to calculate in poverty percentage; B17021_001}
#'   \item{pop_inpov_denom_moe}{Population for whom poverty status is determined
#'   margin of error; Denominator used to calculate in poverty percentage;
#'   B17021_001}
#'   }
#'
#' @source <https://factfinder.census.gov/faces/nav/jsf/pages/index.xhtml>
"nta_acs_data"


#' Public use microdata area-level American Community Survey estimates
#'
#' A dataset containing U.S. Census Bureau American Community Survey (ACS)
#' estimates and margins of error of selected demographic, social, and economic
#' variables for all public use microdata areas (PUMAs) in New York City.
#' Variables are five-year estimates from the 2013-2017 ACS.
#'
#' @format A tibble with 55 rows and 35 variables:
#'
#' \describe{
#'   \item{geoid}{Census Bureau GEOID}
#'   \item{pop_total_est}{Total population estimate; B01001_001}
#'   \item{med_age_est}{Median age estimate; B01002_001}
#'   \item{med_age_moe}{Median age margin of error; B01002_001}
#'   \item{med_hhinc_est}{Median annual household income estimate (dollars);
#'   B19013_001}
#'   \item{med_hhinc_moe}{Median annual household income margin of error
#'   (dollars); B19013_001}
#'   \item{pop_white_est, pop_white_pct_est}{Non-hispanic white population
#'   estimate; B03002_003}
#'   \item{pop_white_moe, pop_white_pct_moe}{Non-hispanic white population
#'   margin of error; B03002_003}
#'   \item{pop_black_est, pop_black_pct_est}{Non-hispanic black population
#'   estimate; B03002_004}
#'   \item{pop_black_moe, pop_black_pct_moe}{Non-hispanic black population
#'   margin of error; B03002_004}
#'   \item{pop_asian_est, pop_asian_pct_est}{Non-hispanic asian population
#'   estimate; B03002_006}
#'   \item{pop_asian_moe, pop_asian_pct_moe}{Non-hispanic asian population
#'   margin of error; B03002_006}
#'   \item{pop_hisp_est, pop_hisp_pct_est}{Hispanic, any race population
#'   estimate; B03002_012}
#'   \item{pop_hisp_moe, pop_hisp_pct_moe}{Hispanic, any race population margin
#'   of error; B03002_012}
#'   \item{pop_ba_above_est, pop_ba_above_pct_est}{Population 25 years or older
#'   with at least a Bachelor's degree estimate; B15003_022, B15003_023,
#'   B15003_024, B15003_025}
#'   \item{pop_ba_above_moe, pop_ba_above_pct_moe}{Population 25 years or older
#'   with at least a Bachelor's degree margin of error; B15003_022, B15003_023,
#'   B15003_024, B15003_025}
#'   \item{pop_educ_denom_est}{Population 25 years or older estimate;
#'   Denominator used to calculate Bachelor's and above percentage; B15003_001}
#'   \item{pop_educ_denom_moe}{Population 25 years or older margin of error;
#'   Denominator used to calculate Bachelor's and above percentage; B15003_001}
#'   \item{pop_inpov_est, pop_inpov_pct_est}{Population with income below
#'   poverty line estimate; B17021_002}
#'   \item{pop_inpov_moe, pop_inpov_pct_moe}{Population with income below
#'   poverty line margin of error; B17021_002}
#'   \item{pop_inpov_denom_est}{Population for whom poverty status is determined
#'   estimate; Denominator used to calculate in poverty percentage; B17021_001}
#'   \item{pop_inpov_denom_moe}{Population for whom poverty status is determined
#'   margin of error; Denominator used to calculate in poverty percentage;
#'   B17021_001}
#'   }
#'
#' @source <https://factfinder.census.gov/faces/nav/jsf/pages/index.xhtml>
"puma_acs_data"

#' Borough-level American Community Survey estimates
#'
#' A dataset containing U.S. Census Bureau American Community Survey (ACS)
#' estimates and margins of error of selected demographic, social, and economic
#' variables for all boroughs in New York City. Variables are five-year
#' estimates from the 2013-2017 ACS.
#'
#' @format A tibble with 5 rows and 35 variables:
#'
#' \describe{
#'   \item{geoid}{Census Bureau GEOID}
#'   \item{pop_total_est}{Total population estimate; B01001_001}
#'   \item{med_age_est}{Median age estimate; B01002_001}
#'   \item{med_age_moe}{Median age margin of error; B01002_001}
#'   \item{med_hhinc_est}{Median annual household income estimate (dollars);
#'   B19013_001}
#'   \item{med_hhinc_moe}{Median annual household income margin of error
#'   (dollars); B19013_001}
#'   \item{pop_white_est, pop_white_pct_est}{Non-hispanic white population
#'   estimate; B03002_003}
#'   \item{pop_white_moe, pop_white_pct_moe}{Non-hispanic white population
#'   margin of error; B03002_003}
#'   \item{pop_black_est, pop_black_pct_est}{Non-hispanic black population
#'   estimate; B03002_004}
#'   \item{pop_black_moe, pop_black_pct_moe}{Non-hispanic black population
#'   margin of error; B03002_004}
#'   \item{pop_asian_est, pop_asian_pct_est}{Non-hispanic asian population
#'   estimate; B03002_006}
#'   \item{pop_asian_moe, pop_asian_pct_moe}{Non-hispanic asian population
#'   margin of error; B03002_006}
#'   \item{pop_hisp_est, pop_hisp_pct_est}{Hispanic, any race population
#'   estimate; B03002_012}
#'   \item{pop_hisp_moe, pop_hisp_pct_moe}{Hispanic, any race population margin
#'   of error; B03002_012}
#'   \item{pop_ba_above_est, pop_ba_above_pct_est}{Population 25 years or older
#'   with at least a Bachelor's degree estimate; B15003_022, B15003_023,
#'   B15003_024, B15003_025}
#'   \item{pop_ba_above_moe, pop_ba_above_pct_moe}{Population 25 years or older
#'   with at least a Bachelor's degree margin of error; B15003_022, B15003_023,
#'   B15003_024, B15003_025}
#'   \item{pop_educ_denom_est}{Population 25 years or older estimate;
#'   Denominator used to calculate Bachelor's and above percentage; B15003_001}
#'   \item{pop_educ_denom_moe}{Population 25 years or older margin of error;
#'   Denominator used to calculate Bachelor's and above percentage; B15003_001}
#'   \item{pop_inpov_est, pop_inpov_pct_est}{Population with income below
#'   poverty line estimate; B17021_002}
#'   \item{pop_inpov_moe, pop_inpov_pct_moe}{Population with income below
#'   poverty line margin of error; B17021_002}
#'   \item{pop_inpov_denom_est}{Population for whom poverty status is determined
#'   estimate; Denominator used to calculate in poverty percentage; B17021_001}
#'   \item{pop_inpov_denom_moe}{Population for whom poverty status is determined
#'   margin of error; Denominator used to calculate in poverty percentage;
#'   B17021_001}
#'   }
#'
#' @source <https://factfinder.census.gov/faces/nav/jsf/pages/index.xhtml>
"borough_acs_data"

#' Block-level Decennial Census counts
#'
#' A dataset containing U.S. Census Bureau Decennial Census population and race
#' counts for all census blocks in New York City. Counts are from the 2010
#' Decennial Census. Margins of error are not included because this data
#' represents an enumeration of the entire population, rather than a sample.
#'
#'
#' @format A tibble with 39148 rows and 11 variables:
#' \describe{
#'   \item{geoid}{Census Bureau GEOID}
#'   \item{pop_total}{Total population; P001001}
#'   \item{med_age}{Median age; P013001}
#'   \item{pop_white, pop_white_pct}{Non-hispanic white population; P005003}
#'   \item{pop_black, pop_black_pct}{Non-hispanic black population; P005004}
#'   \item{pop_asian, pop_asian_pct}{Non-hispanic asian population; P005006}
#'   \item{pop_hisp, pop_hisp_pct}{Hispanic, any race population; P004003}
#' }
#'
#' @source <https://factfinder.census.gov/faces/nav/jsf/pages/index.xhtml>
"block_census_data"