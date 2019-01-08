library(tidyverse)
library(sf)
library(devtools)
library(areal)
library(nycgeo)

cds <- nyc_boundaries(geography = "cd", resolution = "high") %>%
  select(boro_cd_id)

tracts <- nyc_boundaries(
  geography = "tract",
  add_acs_data = TRUE,
  resolution = "high"
  ) %>%
  select(geoid, contains("est"), -contains("pct"), -contains("med"))

cd_tract_interp <- aw_interpolate(
  .data = cds,
  tid = boro_cd_id,
  source = tracts,
  sid = geoid,
  weight = "sum",
  output = "tibble",
  extensive = names(tracts)[which(!names(tracts) %in% c("geoid", "geometry"))]
  )

cds_acs_data <- cd_tract_interp %>%
  mutate(
    pop_white_pct_est = pop_white_est / pop_total_est,
    pop_white_pct_moe = moe_prop(pop_white_est, pop_total_est,
                                 pop_white_moe, pop_total_moe),
    pop_black_pct_est = pop_black_est / pop_total_est,
    pop_black_pct_moe = moe_prop(pop_black_est, pop_total_est,
                                 pop_black_moe, pop_total_moe),
    pop_hisp_pct_est = pop_hisp_est / pop_total_est,
    pop_hisp_pct_moe = moe_prop(pop_hisp_est, pop_total_est,
                                pop_hisp_moe, pop_total_moe),
    pop_asian_pct_est = pop_asian_est / pop_total_est,
    pop_asian_pct_moe = moe_prop(pop_asian_est, pop_total_est,
                                 pop_asian_moe, pop_total_moe),
    pop_ba_above_pct_est = pop_ba_above_est / pop_educ_denom_est,
    pop_ba_above_pct_moe = moe_prop(pop_ba_above_est, pop_educ_denom_est,
                                    pop_ba_above_moe, pop_educ_denom_moe),
    pop_inpov_pct_est = pop_inpov_est / pop_inpov_denom_est,
    pop_inpov_pct_moe = moe_prop(pop_inpov_est, pop_inpov_denom_est,
                                 pop_inpov_moe, pop_inpov_denom_moe)
  ) %>%
  select(nta_id, pop_total_est, pop_total_moe, vars_to_select)

use_data(ntas_acs_data, overwrite = TRUE)