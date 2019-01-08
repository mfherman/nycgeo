context("test nyc_boundaries")
library(dplyr)

test_that("boundaries are correct dims", {
  expect_equal(nrow(nyc_boundaries("borough")), 5)
  expect_equal(ncol(nyc_boundaries("borough")), 7)
  expect_equal(ncol(nyc_boundaries("borough", add_acs_data = TRUE)),
               ncol(borough_sf) + ncol(borough_acs_data) - 1)
  expect_equal(nrow(nyc_boundaries("puma")), 55)
  expect_equal(ncol(nyc_boundaries("puma")), 9)
  expect_equal(ncol(nyc_boundaries("puma", add_acs_data = TRUE)),
               ncol(puma_sf) + ncol(puma_acs_data) - 1)
  expect_equal(nrow(nyc_boundaries("cd")), 71)
  expect_equal(ncol(nyc_boundaries("cd")), 9)
  expect_error(nyc_boundaries("cd", add_acs_data = TRUE))
  expect_equal(nrow(nyc_boundaries("nta")), 195)
  expect_equal(ncol(nyc_boundaries("nta")), 10)
  expect_equal(ncol(nyc_boundaries("nta", add_acs_data = TRUE)),
               ncol(nta_sf) + ncol(nta_acs_data) - 1)
  expect_equal(nrow(nyc_boundaries("tract")), 2166)
  expect_equal(ncol(nyc_boundaries("tract")), 13)
  expect_equal(ncol(nyc_boundaries("tract", add_acs_data = TRUE)),
               ncol(tract_sf) + ncol(tract_acs_data) - 1)
  expect_equal(nrow(nyc_boundaries("block")), 38796)
  expect_equal(ncol(nyc_boundaries("block")), 16)
  expect_equal(ncol(nyc_boundaries("block", add_acs_data = TRUE)),
               ncol(block_sf) + ncol(block_census_data) - 1)
})

test_that("filter gets correct number of rows", {
  expect_equal(nrow(nyc_boundaries(
    "borough", "borough", c("queens", "brooklyn"))), 2)
  expect_equal(nrow(nyc_boundaries("puma", "borough", "new york")), 10)
  expect_equal(nrow(nyc_boundaries("cd", "cd", 105:108)), 4)
  expect_equal(nrow(nyc_boundaries("nta", "puma", 4001:4005)), 14)
  expect_equal(nrow(nyc_boundaries("tract", "nta", "QN05")), 6)
  expect_equal(nrow(nyc_boundaries("block", "borough", "bronx")), 5465)
})

test_that("error with mismatched borough filter by", {
  expect_error(nyc_boundaries("borough", "puma"))
  expect_error(nyc_boundaries("borough", "cd"))
  expect_error(nyc_boundaries("borough", "nta"))
  expect_error(nyc_boundaries("borough", "tract"))
  expect_error(nyc_boundaries("borough", "block"))
})

test_that("error with mismatched puma filter by", {
  expect_error(nyc_boundaries("puma", "cd"))
  expect_error(nyc_boundaries("puma", "nta"))
  expect_error(nyc_boundaries("puma", "tract"))
  expect_error(nyc_boundaries("puma", "block"))
})

test_that("error with mismatched cd filter by", {
  expect_error(nyc_boundaries("cd", "tract"))
  expect_error(nyc_boundaries("cd", "block"))
})

test_that("error with mismatched nta filter by", {
  expect_error(nyc_boundaries("nta", "tract"))
  expect_error(nyc_boundaries("nta", "block"))
})

test_that("error with mismatched tract filter by", {
  expect_error(nyc_boundaries("tract", "tract"))
  expect_error(nyc_boundaries("tract", "block"))
})

test_that("error with mismatched block filter by", {
  expect_error(nyc_boundaries("block", "block"))
})

test_that("nta acs data properly aggregated", {
  expect_equal(
    nyc_boundaries("nta", add_acs_data = TRUE) %>%
      filter(nta_id == "QN07") %>%
      pull(pop_total_est),
    nyc_boundaries("tract", add_acs_data = TRUE) %>%
      group_by(nta_id) %>%
      summarise(pop_total_est = sum(pop_total_est, na.rm = TRUE)) %>%
      filter(nta_id == "QN07") %>%
      pull(pop_total_est)
  )
})
