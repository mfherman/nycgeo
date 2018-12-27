library(devtools)
library(tidyverse)
library(tidycensus)

# variables to download from acs
variables <- c(
  "P001001",  # total population
  "P005003",  # non hispanic white
  "P005004",  # non hispanic black
  "P005006",  # non hispanic asian
  "P004003",  # hispanic
  "P013001"  # median age
  )

nyc_counties <- c("New York", "Bronx", "Queens", "Richmond", "Kings")

# get acs data for all tracts each of the counties
block_data <- map_dfr(
  nyc_counties, ~ get_decennial(
    state = "NY",
    county = .x,
    geography = "block",
    variables = variables,
    year = 2010,
    geometry = FALSE,
    output = "wide"
    )
  )

# calculate new vars, pcts, moes, etc
block_census_data <- block_data %>%
  mutate(
    pop_white_pct = P005003 / P001001,
    pop_black_pct = P005004 / P001001,
    pop_asian_pct = P005006 / P001001,
    pop_hisp_pct = P004003 / P001001
  ) %>%
  select(
    geoid = GEOID,
    pop_total = P001001,
    med_age = P013001,
    pop_white = P005003,
    pop_black = P005004,
    pop_asian = P005006,
    pop_hisp = P004003,
    pop_white_pct:pop_hisp_pct
  ) %>%
  mutate_at(vars(contains("pct")),
            ~ as.numeric(round(.x * 100, digits = 1))) %>%
  mutate_all(~ replace(.x, is.nan(.x), NA))

use_data(block_census_data, overwrite = TRUE)