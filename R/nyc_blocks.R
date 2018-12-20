#' NYC census block boundaries
#'
#' Get current (2010) boundaries for census blocks in New York City in the
#' simple features {sf} format. Either get all census blocks or subset of blocks
#' filtered by borough, neighborhood tabulation area (NTA), or public use
#' microdata area (PUMA).
#'
#' @param filter_by The geography to filter by. Possible values are `borough,
#'   nta, puma`. If `NULL`, all census blocks are returned.
#' @param region A character vector of boroughs, NTAs, or PUMAs. Selected
#' regions much match the geography indicated by `filter_by` argument.
#' @param add_census_data If `TRUE`, selected demographic, social, and economic
#'   data from the U.S. Census 2010 decennial census is appended to block
#'   boundaries.
#'
#' @return An `sf` object of census block boundaries
#'
#' @details For more information about the metadata included with boundaries,
#'   see [blocks_sf].
#'
#' @examples
#' if (require(sf)) {
#'
#'   # get sf boundaires
#'   all_nyc_blocks <- nyc_blocks()
#'
#'   north_si_blocks <- nyc_blocks(
#'     filter_by = "nta",
#'     region = c("SI22", "SI35")
#'     )
#'
#'   queens_blocks <- nyc_blocks(
#'     filter_by = "borough",
#'     region = "Queens",
#'     add_census_data = TRUE
#'     )
#'
#'   # plot boundaries
#'   plot(st_geometry(all_nyc_blocks))
#'
#'   plot(st_geometry(queens_blocks))
#'
#'   plot(queens_blocks["med_age"])
#' }
#'
#' @export

nyc_blocks <- function(filter_by = NULL,
                      region = NULL,
                      add_census_data = FALSE) {

  # check argument validity
  # only one geography to filter by
  if (length(filter_by) > 1) {
    stop("Can only filter by one geography")
  }

  # must choose region(s) if filtering
  if (!is.null(filter_by) && is.null(region)) {
    stop("Please specify one or more regions to filter by")
  }

  # must choose geography if regions are specified
  if (is.null(filter_by) && !is.null(region)) {
    stop("Please specify a geography to filter by")
  }

   # make arguments lower case
  if (!is.null(filter_by) && !is.null(region)) {
    filter_by <- tolower(filter_by)
    region <- tolower(region)

    # geography must be boro, nta or puma
    if (!(filter_by %in% c("boro", "borough", "nta", "puma"))) {
         stop("Please choose a valid geography to filter by")
    }
  }

  # # only one version of blocks_sf for now
  # # set low or high resolution
  # resolution <- match.arg(resolution)
  #
  # # get low or high resolution sf file
  # if (resolution == "low") {
  #   shp <- nycgeo::blocks_sf_simple
  # } else if (resolution == "high") {
  #   shp <- nycgeo::blocks_sf
  # }

  shp <- nycgeo::blocks_sf

  # if filter is set, subset file by given regions
  if (!is.null(filter_by)) {
    if (filter_by %in% c("borough", "boro")) {
      shp <- filter_by_boro(shp, region)
    } else if (filter_by == c("nta")) {
      shp <- filter_by_nta(shp, region)
    } else if (filter_by == c("puma")) {
      shp <- filter_by_puma(shp, region)
    }
  }

  # append census data?
  if (add_census_data) {
    shp <- merge(shp, nycgeo::blocks_census_data, by = "geoid", all.x = TRUE)

    if (requireNamespace("sf", quietly = TRUE) &&
        requireNamespace("tibble", quietly = TRUE)) {
      shp <- sf::st_as_sf(tibble::as_tibble(shp))
    }
  }
  shp
}