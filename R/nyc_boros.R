#' NYC borough (county) boundaries
#'
#' Get current boundaries for public use boroughs (counties) in New York City in
#' the simple features {sf} format. Either get all boroughs or a subset of
#' boroughs.
#'
#' @param region A character vector of boroughs. If `NULL`, all boroughs are
#'   returned.
#' @param add_acs_data If `TRUE`, selected demographic, social, and economic
#'   data from the U.S. Census Bureau American Community Survey is appended to
#'   borough boundaries.
#' @param resolution The resolution of the map. Defaults to lower resolution.
#'
#' @return An `sf` object of borough boundaries
#'
#' @details For more information about the metadata included with boundaries,
#'   see [boros_sf].
#'
#' @examples
#' if (require(sf)) {
#'
#'   # get sf boundaires
#'   all_nyc_boros <- nyc_boros()
#'
#'   mn_bx_boros <- nyc_boros(
#'     region = c("mahattan", "bronx"),
#'     resolution = "high"
#'     )
#'
#'   nyc_boros_acs <- nyc_boros(add_acs_data = TRUE)
#'
#'   # plot boundaries
#'   plot(st_geometry(all_nyc_boros))
#'
#'   plot(st_geometry(mn_bx_boros))
#'
#'   plot(nyc_boros_acs["pop_hisp_est"])
#' }
#' @export

nyc_boros <- function(region = NULL,
                      add_acs_data = FALSE,
                      resolution = c("low", "high")) {

  # set low or high resolution
  resolution <- match.arg(resolution)

  # get low or high resolution sf file
  if (resolution == "low") {
    shp <- nycgeo::boros_sf_simple
  } else if (resolution == "high") {
    shp <- nycgeo::boros_sf
  }

  # if filter is requested subset by region(s)
  if (!is.null(region)) {
    shp <- filter_by_region(shp, filter_by = "boro", region)
  }

  # append census data?
  if (add_acs_data) {
    shp <- merge(shp, nycgeo::boros_acs_data, by = "geoid", all.x = TRUE)

    if (requireNamespace("sf", quietly = TRUE) &&
        requireNamespace("tibble", quietly = TRUE)) {
      shp <- sf::st_as_sf(tibble::as_tibble(shp))
    }
  }
  shp
}