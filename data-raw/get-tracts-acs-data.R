library(devtools)
library(tidyverse)
library(tidycensus)

# variables to download from acs
variables <- c(
  "B01001_001",  # total population
  "B03002_003",  # non hispanic white
  "B03002_004",  # non hispanic black
  "B03002_006",  # non hispanic asian
  "B03002_012",  # hispanic
  "B01002_001",  # median age
  "B19013_001",  # median hh income
  "B17021_002",  # below 100% poverty level
  "B17021_001",  # poverty level denom
  "B15003_001",  # pop 25 over
  "B15003_022",  # bachelors degree
  "B15003_023",  # masters degree
  "B15003_024",  # professional degree
  "B15003_025"   # doctorate
  )

nyc_counties <- c("New York", "Bronx", "Queens", "Richmond", "Kings")

# get acs data for all tracts each of the counties
tract_data <- map_dfr(
  nyc_counties, ~ get_acs(
    state = "NY",
    county = .x,
    geography = "tract",
    variables = variables,
    survey = "acs5",
    year = 2017,
    geometry = FALSE,
    output = "wide"
    )
  )

# calculate new vars, pcts, moes, etc
tracts_acs_data <- tract_data %>%
  mutate(
    pop_white_pct_est = B03002_003E / B01001_001E,
    pop_white_pct_moe = moe_prop(B03002_003E, B01001_001E,
                                 B03002_003M, B01001_001M),
    pop_black_pct_est = B03002_004E / B01001_001E,
    pop_black_pct_moe = moe_prop(B03002_004E, B01001_001E,
                                 B03002_004M, B01001_001M),
    pop_hisp_pct_est = B03002_012E / B01001_001E,
    pop_hisp_pct_moe = moe_prop(B03002_012E, B01001_001E,
                                B03002_012M, B01001_001M),
    pop_asian_pct_est = B03002_006E / B01001_001E,
    pop_asian_pct_moe = moe_prop(B03002_006E, B01001_001E,
                                 B03002_006M, B01001_001M),
    pop_ba_above_est = B15003_022E + B15003_023E + B15003_024E + B15003_025E,
    pop_ba_above_moe = pmap_dbl(
      list(B15003_022M, B15003_023M, B15003_024M, B15003_025M,
           B15003_022E, B15003_023E, B15003_024E, B15003_025E),
      ~ moe_sum(
        moe = c(..1, ..2, ..3, ..4),
        estimate = c(..5, ..6, ..7, ..8),
        na.rm = TRUE
      )
    ),
    pop_ba_above_pct_est = pop_ba_above_est / B15003_001E,
    pop_ba_above_pct_moe = moe_prop(pop_ba_above_est, B15003_001E,
                                    pop_ba_above_moe, B15003_001M),
    pop_inpov_pct_est = B17021_002E / B17021_001E,
    pop_inpov_pct_moe = moe_prop(B17021_002E, B17021_001E,
                                 B17021_002M, B17021_001M)
  ) %>%
  select(
    geoid = GEOID,
    pop_total_est = B01001_001E,
    pop_total_moe = B01001_001M,
    med_age_est = B01002_001E,
    med_age_moe = B01002_001M,
    med_hhinc_est = B19013_001E,
    med_hhinc_moe = B19013_001M,
    pop_white_est = B03002_003E,
    pop_white_moe = B03002_003M,
    pop_black_est = B03002_004E,
    pop_black_moe = B03002_004M,
    pop_hisp_est = B03002_012E,
    pop_hisp_moe = B03002_012M,
    pop_asian_est = B03002_006E,
    pop_asian_moe = B03002_006M,
    pop_ba_above_est,
    pop_ba_above_moe,
    pop_educ_denom_est = B15003_001E,
    pop_educ_denom_moe = B15003_001M,
    pop_inpov_est = B17021_002E,
    pop_inpov_moe = B17021_002M,
    pop_inpov_denom_est = B17021_001E,
    pop_inpov_denom_moe = B17021_001M,
    pop_white_pct_est:pop_inpov_pct_moe
  ) %>%
  mutate(pop_ba_above_moe = as.numeric(round(pop_ba_above_moe))) %>%
  mutate_at(vars(contains("pct")),
            ~ as.numeric(round(.x * 100, digits = 1))) %>%
  mutate_all(~ replace(.x, is.nan(.x), NA))

use_data(tracts_acs_data, overwrite = TRUE)
