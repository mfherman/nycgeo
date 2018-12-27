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
#'   see [boros_sf], [pumas_sf], [cds_sf], [ntas_sf], [tracts_sf], or
#'   [blocks_sf]. For information about the census estimates returned, see
#'   [boros_acs_data], [pumas_acs_data], [ntas_acs_data], [tracts_acs_data], or
#'   [blocks_census_data].
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
#'     filter_by = "boro",
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

  # validate filter for selected geography and set geo prefix and merge by field
  if (geography == c("borough")) {
    if (!is.null(filter_by) && !(filter_by %in% c("boro", "borough"))) {
      stop("Please choose a valid geography to filter by")
    } else {
    .geo <- "boros"
    .merge_by <- "geoid"
    }
  } else if (geography == c("puma")) {
    if (!is.null(filter_by) && !(filter_by %in% c("boro", "borough", "puma"))) {
      stop("Please choose a valid geography to filter by")
    } else {
    .geo <- "pumas"
    .merge_by <- "geoid"
    }
  } else if (geography == c("nta")) {
    if (!is.null(filter_by) && !(filter_by %in% c("boro", "borough",
                                                  "puma", "nta"))) {
      stop("Please choose a valid geography to filter by")
    } else {
    .geo <- "ntas"
    .merge_by <- "nta_id"
    }
  } else if (geography == c("cd")) {
    if (!is.null(filter_by) && !(filter_by %in% c("boro", "borough", "cd"))) {
      stop("Please choose a valid geography to filter by")
    } else {
    .geo <- "cds"
    }
  } else if (geography == c("tract")) {
    if (!is.null(filter_by) && !(filter_by %in% c("boro", "borough",
                                                  "puma", "nta"))) {
      stop("Please choose a valid geography to filter by")
    } else {
    .geo <- "tracts"
    .merge_by <- "geoid"
    }
  } else {
    if (!is.null(filter_by) && !(filter_by %in% c("boro", "borough",
                                                  "puma", "nta"))) {
      stop("Please choose a valid geography to filter by")
    } else {
    .geo <- "blocks"
    .merge_by <- "geoid"
    }
  }

  # select low or hi res geometries and create call for appropriate sf file
  if (resolution == "low" && geography != "block") {
    .shp_call <- paste0(.geo, "_sf_simple")
  } else {
    .shp_call <- paste0(.geo, "_sf")
  }

  # get appropriate sf object
  shp <- get(.shp_call)

  # if filter is requested subset by region(s)
  if (!is.null(filter_by) || !is.null(region)) {
    shp <- filter_by_region(shp, filter_by, region)
  }

  # append census data?
  if (add_acs_data && geography != "cd") {

    # create call for appropriate census data
    if (geography == "block") {
      .acs_call <- paste0(.geo, "_census_data")
    } else {
      .acs_call <- paste0(.geo, "_acs_data")
    }

    # merge appropriate census data and convert to sf tibble
    shp <- merge(shp, get(.acs_call), by = .merge_by, all.x = TRUE)
    shp <- sf_to_sf_tibble(shp)

  }
  shp
}