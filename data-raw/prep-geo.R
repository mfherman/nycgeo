library(tidyverse)
library(sf)
library(devtools)
library(rmapshaper)

# reference tables --------------------------------------------------------

# create boro code to county lookup table
# Boro Codes
# 1 = Manhattan
# 2 = Bronx
# 3 = Brooklyn
# 4 = Queens
# 5 = Staten Island

boro_id_lookup <- tribble(
  ~boro_id, ~boro_name, ~county_fips, ~county_name,
  "1",      "Manhattan", "061",       "New York",
  "2",      "Bronx",     "005",       "Bronx",
  "3",      "Brooklyn",  "047",       "Kings",
  "4",      "Queens",    "081",       "Queens",
  "5",      "Richmond",  "085",       "Richmond"
)

# read in puma name lookup table
puma_name_lookup <- read_csv("data-raw/puma-names.csv", col_types = "cc") %>%
  mutate(BoroCode = case_when(
    str_detect(puma_name, "Manhattan")     ~ "1",
    str_detect(puma_name, "Bronx")         ~ "2",
    str_detect(puma_name, "Brooklyn")      ~ "3",
    str_detect(puma_name, "Queens")        ~ "4",
    str_detect(puma_name, "Staten Island") ~ "5"
    )
  )

# import geo files --------------------------------------------------------

# https://www1.nyc.gov/site/planning/data-maps/open-data/districts-download-metadata.page
# set up urls for dowloading geojson boundaries from nyc dcp
base_url <- "http://services5.arcgis.com/GfwWNkhOj9bNBqoJ/arcgis/rest/services/"
tail_url <- "/FeatureServer/0/query?where=1=1&outFields=*&outSR=4326&f=geojson"

# geographies to download
geos <- list(
  tract = "nyct2010",
  nta = "nynta",
  boro = "nybb",
  puma = "nypuma"
  )

# build list of urls
urls <- map(geos, ~ paste0(base_url, .x, tail_url))

# download geojson and covert to sf
nyc_sf <- map(urls, read_sf) %>%
  map(~ mutate_at(.x, vars(-geometry), as.character)) %>%
  modify_at("puma",
            ~ left_join(.x, puma_name_lookup, by = c("PUMA" = "puma_id"))
            ) %>%
  map(~ left_join(.x, boro_id_lookup, by = c("BoroCode" = "boro_id"))) %>%
  map(~ mutate(.x, state_fips = "36")) %>%
  map(st_transform, 2263)


# process tracts ----------------------------------------------------------

tracts_sf <- nyc_sf %>%
  pluck("tract") %>%
  mutate(geoid = paste0(state_fips, county_fips, CT2010)) %>%
  select(
    boro_tract_id = BoroCT2010,
    geoid,
    state_fips,
    county_fips,
    tract_id = CT2010,
    county_name,
    boro_name,
    boro_id = BoroCode,
    nta_id = NTACode,
    nta_name = NTAName,
    puma_id = PUMA
  ) %>%
  left_join(puma_name_lookup, by = "puma_id") %>%
  select(-BoroCode) %>%
  arrange(boro_tract_id)


# build geo crosswalks ----------------------------------------------------

# create crosswalk to add nta, puma info to blocks
tract_nta_puma_crosswalk <- tracts_sf %>%
  st_set_geometry(NULL) %>%
  select(county_fips, tract_id, nta_id, nta_name, puma_id, puma_name)

# create crosswalk to add puma info to ntas
nta_puma_crosswalk <- tract_nta_puma_crosswalk %>%
  distinct(nta_id, puma_id, puma_name) %>%
  filter(!str_detect(nta_id, "98|99")) # remove ntas with pumas (park, cemetary, etc)


# process boroughs --------------------------------------------------------

boros_sf <- nyc_sf %>%
  pluck("boro") %>%
  mutate(geoid = paste0(state_fips, county_fips)) %>%
  select(
    geoid,
    state_fips,
    county_fips,
    county_name,
    boro_name,
    boro_id = BoroCode
  ) %>%
  arrange(boro_id)


# process ntas ------------------------------------------------------------

ntas_sf <- nyc_sf %>%
  pluck("nta") %>%
  select(
    nta_id = NTACode,
    nta_name = NTAName,
    state_fips,
    county_fips,
    county_name,
    boro_name,
    boro_id = BoroCode
  ) %>%
  left_join(nta_puma_crosswalk, by = "nta_id") %>%
  arrange(boro_id, nta_id)



# process pumas -----------------------------------------------------------

pumas_sf <- nyc_sf %>%
  pluck("puma") %>%
  select(
    puma_id = PUMA,
    puma_name,
    state_fips,
    county_fips,
    county_name,
    boro_name,
    boro_id = BoroCode
    ) %>%
  arrange(boro_id, puma_id)


# simplify sf objects -----------------------------------------------------

# set up list of sf objects to simplify
boundaries <- lst(boros_sf, ntas_sf, tracts_sf, pumas_sf)

# simplify each object to make smaller boundary files available
boundaries_simple <- map(boundaries, ~ ms_simplify(.x, keep_shapes = TRUE)) %>%
  set_names(paste0(names(boundaries), "_simple")) %>%
  map(~ st_as_sf(as_tibble(.x)))

# save data ---------------------------------------------------------------

# loop over list of boundaries and save to /data
walk2(boundaries, names(boundaries), function(obj, name) {
  assign(name, obj)
  invoke(use_data, list(as.name(name), overwrite = TRUE))
})

# loop over list of simplified boundaries and save to /data
walk2(boundaries_simple, names(boundaries_simple), function(obj, name) {
  assign(name, obj)
  invoke(use_data, list(as.name(name), overwrite = TRUE))
})