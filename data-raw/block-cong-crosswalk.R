# generate block/congressional district relationship file
# entire us file accessed here: https://www.census.gov/rdo/data/113th_congressional_and_2012_state_legislative_district_plans.html

library(tidyverse)
library(devtools)
library(sf)
load_all()

# read in block/cong relation ship file
block_cong_relate <- read_csv("data-raw/cd115-block.txt", col_types = "cc")

# join with blocks by geoid and write to csv
block_cong_join <- block_sf %>%
  st_set_geometry(NULL) %>%
  left_join(block_cong_relate, by = c("geoid"= "BLOCKID")) %>%
  mutate(cong_dist_id = as.character(as.numeric(CD115))) %>%
  select(geoid, cong_dist_id) %>%
  arrange(as.numeric(cong_dist_id))

write_csv(block_cong_join, "data-raw/block-cong.csv")
