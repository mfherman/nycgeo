library(sf)
library(devtools)
library(rmapshaper)
library(purrr)

# load all saved sf objects
walk(list.files("data", pattern = ".rda", full.names = TRUE),
     ~ load(.x, envir = .GlobalEnv))

load("data/nyc_tract.rda")
load("data/nyc_boro.rda")
load("data/nyc_nta.rda")

geos <- list(
  nyc_tract_simple = nyc_tract,
  nyc_boro_simple = nyc_boro,
  nyc_nta_simple = nyc_nta
  )

map(geos, ~ paste0(start, .x, end)) %>% map(load)



map(to_simplify, ~ ms_simplify(.x, keep_shapes = TRUE))

nyc_tract_simple <- ms_simplify(nyc_tract, keep_shapes = TRUE)
nyc_boro_simple <- ms_simplify(nyc_boro, keep_shapes = TRUE)
nyc_nta_simple <- ms_simplify(nyc_nta, keep_shapes = TRUE)

use_data(nyc_tract_simple, nyc_boro_simple, nyc_nta_simple, overwrite = TRUE)
