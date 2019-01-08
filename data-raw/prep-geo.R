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
  ~borough_id, ~borough_name, ~county_fips, ~county_name,
  "1",      "Manhattan", "061",       "New York",
  "2",      "Bronx",     "005",       "Bronx",
  "3",      "Brooklyn",  "047",       "Kings",
  "4",      "Queens",    "081",       "Queens",
  "5",      "Staten Island", "085",   "Richmond"
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

school_boro_lookup <- read_csv("data-raw/school-boro.csv", col_types = "cc")
police_boro_lookup <- read_csv("data-raw/police-boro.csv", col_types = "cc")
block_cong_crosswalk <- read_csv("data-raw/block-cong.csv", col_types = "cc")

# import geo files --------------------------------------------------------

# https://www1.nyc.gov/site/planning/data-maps/open-data/districts-download-metadata.page
# set up urls for dowloading geojson boundaries from nyc dcp
base_url <- "http://services5.arcgis.com/GfwWNkhOj9bNBqoJ/arcgis/rest/services/"
tail_url <- "/FeatureServer/0/query?where=1=1&outFields=*&outSR=4326&f=geojson"

# geographies to download
geos <- list(
  tract = "nyct2010",
  nta = "nynta",
  borough = "nybb",
  puma = "nypuma",
  block = "nycb2010",
  cd = "nycd",
  school = "nysd",
  police = "nypp",
  council = "nycc",
  cong = "nycg"
  )

# build list of urls
urls <- map(geos, ~ paste0(base_url, .x, tail_url))

# download geojson and covert to sf
nyc_sf <- map(urls, read_sf) %>%
  map(~ mutate_at(.x, vars(-geometry), as.character))

nyc_sf_processed <- nyc_sf %>%
  modify_at("puma", ~ left_join(.x, puma_name_lookup,
                                by = c("PUMA" = "puma_id"))) %>%
  modify_at("cd",
            ~ mutate(.x, BoroCode = str_sub(BoroCD, end = 1L))) %>%
  modify_at("school", ~ left_join(.x, school_boro_lookup)) %>%
  modify_at("police", ~ left_join(.x, police_boro_lookup)) %>%
  modify_at(.at = 1:8, ~ left_join(.x, boro_id_lookup,
                                by = c("BoroCode" = "borough_id"))) %>%
  map(~ mutate(.x, state_fips = "36")) %>%
  map(st_transform, 2263)


# process tracts ----------------------------------------------------------

tract_sf <- nyc_sf_processed %>%
  pluck("tract") %>%
  mutate(geoid = paste0(state_fips, county_fips, CT2010)) %>%
  select(
    geoid,
    borough_tract_id = BoroCT2010,
    state_fips,
    county_fips,
    tract_id = CT2010,
    county_name,
    borough_name,
    borough_id = BoroCode,
    nta_id = NTACode,
    nta_name = NTAName,
    puma_id = PUMA
  ) %>%
  left_join(puma_name_lookup, by = "puma_id") %>%
  select(-BoroCode) %>%
  arrange(borough_tract_id)


# build geo crosswalks ----------------------------------------------------

# create crosswalk to add nta, puma info to blocks
tract_nta_puma_crosswalk <- tract_sf %>%
  st_set_geometry(NULL) %>%
  select(county_fips, tract_id, nta_id, nta_name, puma_id, puma_name)

# create crosswalk to add puma info to ntas
nta_puma_crosswalk <- tract_nta_puma_crosswalk %>%
  distinct(nta_id, puma_id, puma_name) %>%
  filter(!str_detect(nta_id, "98|99")) # remove ntas with pumas (park, cemetary, etc)

# process boroughs --------------------------------------------------------

borough_sf <- nyc_sf_processed %>%
  pluck("borough") %>%
  mutate(geoid = paste0(state_fips, county_fips)) %>%
  select(
    geoid,
    state_fips,
    county_fips,
    county_name,
    borough_name,
    borough_id = BoroCode
  ) %>%
  arrange(borough_id)


# process ntas ------------------------------------------------------------

nta_sf <- nyc_sf_processed %>%
  pluck("nta") %>%
  select(
    nta_id = NTACode,
    nta_name = NTAName,
    state_fips,
    county_fips,
    county_name,
    borough_name,
    borough_id = BoroCode
  ) %>%
  left_join(nta_puma_crosswalk, by = "nta_id") %>%
  arrange(borough_id, nta_id)


# process pumas -----------------------------------------------------------

puma_sf <- nyc_sf_processed %>%
  pluck("puma") %>%
  mutate(geoid = paste0("360", PUMA)) %>%
  select(
    geoid,
    puma_id = PUMA,
    puma_name,
    state_fips,
    county_fips,
    county_name,
    borough_name,
    borough_id = BoroCode
    ) %>%
  arrange(borough_id, puma_id)

# process cds -------------------------------------------------------------

cd_sf <- nyc_sf_processed %>%
  pluck("cd") %>%
  mutate(
    cd_id = as.character(as.integer(str_sub(BoroCD, 2, 3))),
    cd_name = case_when(
      cd_id %in% c(26:28, 55:56, 64, 80:84, 95) ~
        paste(borough_name, "Joint Interest Area", cd_id),
      TRUE ~
        paste(borough_name, "Community District", cd_id)
      )
    ) %>%
  select(
    borough_cd_id = BoroCD,
    cd_id,
    cd_name,
    state_fips,
    county_fips,
    county_name,
    borough_name,
    borough_id = BoroCode
  ) %>%
  arrange(borough_cd_id)

# process school ----------------------------------------------------------

school_sf <- nyc_sf_processed %>%
  pluck("school") %>%
  mutate(
    school_dist_name = paste("Community School District", SchoolDist)
  ) %>%
  select(
    school_dist_id = SchoolDist,
    school_dist_name,
    state_fips
  ) %>%
  group_by(school_dist_id, school_dist_name, state_fips) %>%
  summarise() %>% # dissolve 2 parts of SD 10 that are split
  ungroup() %>%
  arrange(as.numeric(school_dist_id))

# process police ----------------------------------------------------------

police_sf <- nyc_sf_processed %>%
  pluck("police") %>%
  transmute(
    police_precinct_id = Precinct,
    police_precinct_name = case_when(
      police_precinct_id == "14" ~ "Midtown South Precinct",
      police_precinct_id == "18" ~ "Midtown North Precinct",
      police_precinct_id == "22" ~ "Central Park Precinct",
      TRUE ~ paste(scales::ordinal(as.numeric(police_precinct_id)), "Precinct")
      ),
    state_fips
    ) %>%
  arrange(as.numeric(police_precinct_id))

# process cong ------------------------------------------------------------

cong_sf <- nyc_sf_processed %>%
  pluck("cong") %>%
  transmute(
    geoid = paste0(state_fips, str_pad(CongDist, 2, pad = "0")),
    cong_dist_id = CongDist,
    cong_dist_name = paste0("NY-", cong_dist_id),
    state_fips
    ) %>%
  arrange(as.numeric(geoid))

# process council ---------------------------------------------------------

council_sf <- nyc_sf_processed %>%
  pluck("council") %>%
  transmute(
    council_dist_id = CounDist,
    council_dist_name = paste("City Council District", council_dist_id),
    state_fips
  ) %>%
  arrange(as.numeric(council_dist_id))

# process blocks ----------------------------------------------------------

block_sf <- nyc_sf_processed %>%
  pluck("block") %>%
  mutate(geoid = paste0(state_fips, county_fips, CT2010, CB2010)) %>%
  left_join(
    tract_nta_puma_crosswalk,
    by = c("CT2010" = "tract_id", "county_fips")
  ) %>%
  left_join(block_cong_crosswalk, by = "geoid") %>%
  left_join(st_set_geometry(cong_sf, NULL), by = "cong_dist_id") %>%
  select(
    geoid = geoid.x,
    borough_tract_block_id = BCTCB2010,
    state_fips = state_fips.x,
    county_fips,
    block_id = CB2010,
    tract_id = CT2010,
    county_name,
    borough_name,
    borough_id = BoroCode,
    nta_id,
    nta_name,
    puma_id,
    puma_name,
    cong_dist_id,
    cong_dist_name
  ) %>%
  arrange(borough_tract_block_id)

# simplify sf objects -----------------------------------------------------

# set up list of sf objects to simplify
boundaries <- lst(borough_sf, nta_sf, tract_sf, puma_sf, block_sf, cd_sf,
                  council_sf, school_sf, police_sf, cong_sf)

# simplify each object to make smaller boundary files available
boundaries_simple <- boundaries %>%
  list_modify("block_sf" = NULL) %>% # don't simplify blocks_sf
  map(~ ms_simplify(.x, keep_shapes = TRUE)) %>%
  set_names(paste0(names(list_modify(boundaries, "block_sf" = NULL)), "_simple")) %>%
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
