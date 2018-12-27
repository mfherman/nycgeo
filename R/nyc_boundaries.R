#' Get NYC administrative boundaries and census data
#'
#' Get current boundaries for administrative boundaries in New York
#' City in the simple features {sf} format. Available boundaries are boroughs,
#' public use microdata areas (PUMAs), community districts (CDs), neighborhood
#' tabulation areas (NTAs), census tracts, and census blocks. Either get all
#' boundaries of a selected geography or a filtered subset.
#'
#' @param geography The requested administrative boundaries. Possible values are
#'   "borough", "puma", "cd", "nta", "tract", or "block".
#' @param filter_by The geography to filter by. If `NULL`, all boundaries of
#'   selected geography are returned.
#' @param region A character vector of regions to filter by. Selected
#'   regions much match the geography indicated by `filter_by` argument.
#' @param add_acs_data If `TRUE`, selected demographic, social, and economic
#'   data from the U.S. Census Bureau American Community Survey is appended to
#'   boundaries.
#' @param resolution The resolution of the map. Defaults to lower resolution.
#'
#' @return An `sf` object of administrative boundaries
#'
#' @details For more information about the metadata included with boundaries,
#'   see [borough_sf], [puma_sf], [cd_sf], [nta_sf], [tract_sf], or [block_sf].
#'   For information about the census estimates returned, see
#'   [borough_acs_data], [puma_acs_data], [nta_acs_data], [tract_acs_data], or
#'   [block_census_data].
#'
#' @examples
#' if (require(sf)) {
#'
#'   # get sf boundaires
#'   all_nyc_boroughs <- nyc_boundaries(geography = "borough")
#'
#'   greenpoint_williamsburg_ntas <- nyc_boundaries(
#'     geography = "nta",
#'     filter_by = "puma",
#'     region = "4001",
#'     resolution = "high"
#'     )
#'
#'   queens_brooklyn_tracts <- nyc_boundaries(
#'     geography = "tract",
#'     filter_by = "borough",
#'     region = c("queens", "brooklyn"),
#'     add_acs_data = TRUE
#'   )
#'
#'   # plot boundaries
#'   plot(st_geometry(all_nyc_boroughs))
#'
#'   plot(st_geometry(greenpoint_williamsburg_ntas))
#'
#'   plot(queens_brooklyn_tracts["pop_white_pct_est"])
#' }
#'
#' @export

nyc_boundaries <- function(geography = c("borough", "puma", "nta",
                                         "cd", "tract", "block"),
                           filter_by = NULL,
                           region = NULL,
                           add_acs_data = FALSE,
                           resolution = c("low", "high")) {

  # validate geography argument
  geography <- match.arg(geography)

  # make filter lowercase
  if (!is.null(filter_by)) {
    filter_by <- tolower(filter_by)
  }

  # set low or high resolution
  resolution <- match.arg(resolution)

  # define resolution helper functions
  get_boro <- function(res) {
    if (res == "high") nycgeo::borough_sf else nycgeo::borough_sf_simple
  }

  get_puma <- function(res) {
    if (res == "high") nycgeo::puma_sf else nycgeo::puma_sf_simple
  }

  get_cd <- function(res) {
    if (res == "high") nycgeo::cd_sf else nycgeo::cd_sf_simple
  }

  get_nta <- function(res) {
    if (res == "high") nycgeo::nta_sf else nycgeo::nta_sf_simple
  }

  get_tract <- function(res) {
    if (res == "high") nycgeo::tract_sf else nycgeo::tract_sf_simple
  }

  # validate filter for selected geography, get sf object, set ac
  if (geography == "borough") {
    if (!is.null(filter_by) && !(filter_by == "borough")) {
      stop("Can only filter by borough")
    } else {
      shp <- get_boro(resolution)
      merge_by <- "geoid"
    }
    if (add_acs_data) {
      acs_data <- nycgeo::borough_acs_data
    }
  } else if (geography == "puma") {
    if (!is.null(filter_by) && !(filter_by %in% c("borough", "puma"))) {
      stop("Can only filter by borough or puma")
    } else {
      shp <- get_puma(resolution)
      merge_by <- "geoid"
    }
    if (add_acs_data) {
      acs_data <- nycgeo::puma_acs_data
    }
  } else if (geography == "nta") {
    if (!is.null(filter_by) && !(filter_by %in% c("borough", "puma", "nta"))) {
      stop("Can only filter by borough, puma, or nta")
    } else {
      shp <- get_nta(resolution)
      merge_by <- "nta_id"
    }
    if (add_acs_data) {
      acs_data <- nycgeo::nta_acs_data
    }
  } else if (geography == "cd") {
    if (!is.null(filter_by) && !(filter_by %in% c("borough", "cd"))) {
      stop("Can only filter by borough or cd")
    } else {
      shp <- get_cd(resolution)
    }
    if (add_acs_data) {
      stop("ACS data for community districts is not yet available.")
    }
  } else if (geography == "tract") {
    if (!is.null(filter_by) && !(filter_by %in% c("borough", "puma", "nta"))) {
      stop("Can only filter by borough, puma, or nta")
    } else {
      shp <- get_tract(resolution)
      merge_by <- "geoid"
    }
    if (add_acs_data) {
      acs_data <- nycgeo::tract_acs_data
    }
  } else {
    if (!is.null(filter_by) && !(filter_by %in% c("borough", "puma", "nta"))) {
      stop("Can only filter by borough, puma, or nta")
    } else {
      shp <- nycgeo::block_sf
      merge_by <- "geoid"
    }
    if (add_acs_data) {
      acs_data <- nycgeo::block_census_data
    }
  }

  # if filter is requested subset by region(s)
  if (!is.null(filter_by) || !is.null(region)) {
    shp <- filter_by_region(shp, filter_by, region)
  }

  # append acs data?
  if (add_acs_data) {
    # merge appropriate census data and convert to sf tibble
    shp <- merge(shp, acs_data, by = merge_by, all.x = TRUE)
    shp <- sf_to_sf_tibble(shp)
  }

  shp
}