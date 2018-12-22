#' NYC census tract boundaries
#'
#' Get current (2010) boundaries for census tracts in New York City in the
#' simple features {sf} format. Either get all census tracts or subset of tracts
#' filtered by borough, neighborhood tabulation area (NTA), or public use
#' microdata area (PUMA).
#'
#' @param filter_by The geography to filter by. Possible values are `borough,
#'   nta, puma`. If `NULL`, all census tracts are returned.
#' @param region A character vector of boroughs, NTAs, or PUMAs. Selected
#' regions much match the geography indicated by `filter_by` argument.
#' @param add_acs_data If `TRUE`, selected demographic, social, and economic
#'   data from the U.S. Census Bureau American Community Survey is appended to
#'   tract boundaries.
#' @param resolution The resolution of the map. Defaults to lower resolution.
#'
#' @return An `sf` object of census tract boundaries.
#'
#' @details For more information about the metadata included with boundaries,
#'   see [tracts_sf].
#'
#' @examples
#' if (require(sf)) {
#'
#'   # get sf boundaires
#'   all_nyc_tracts <- nyc_tracts()
#'
#'   north_si_tracts <- nyc_tracts(
#'     filter_by = "nta",
#'     region = c("SI22", "SI35"),
#'     resolution = "high"
#'     )
#'
#'   queens_tracts <- nyc_tracts(
#'     filter_by = "borough",
#'     region = "Queens",
#'     add_acs_data = TRUE
#'     )
#'
#'   # plot boundaries
#'   plot(st_geometry(all_nyc_tracts))
#'
#'   plot(st_geometry(queens_tracts))
#'
#'   plot(queens_tracts["med_hhinc_est"])
#' }
#'
#' @export

nyc_tracts <- function(filter_by = NULL,
                      region = NULL,
                      add_acs_data = FALSE,
                      resolution = c("low", "high")) {

  # validate filter by
  if (!is.null(filter_by)) {
    filter_by <- tolower(filter_by)

  # geography must be boro, nta or puma
    if (!is.null(filter_by) &&
      !(filter_by %in% c("boro", "borough", "nta", "puma"))) {
    stop("Please choose a valid geography to filter by")
    }
  }

  # set low or high resolution
  resolution <- match.arg(resolution)

  # get low or high resolution sf file
  if (resolution == "low") {
    shp <- nycgeo::tracts_sf_simple
  } else if (resolution == "high") {
    shp <- nycgeo::tracts_sf
  }

  # if filter is requested subset by region(s)
  if (!is.null(filter_by) || !is.null(region)) {
    shp <- filter_by_region(shp, filter_by, region)
  }

  # append census data?
  if (add_acs_data) {
    shp <- merge(shp, nycgeo::tracts_acs_data, by = "geoid", all.x = TRUE)
    shp <- sf_to_sf_tibble(shp)
  }
  shp
}