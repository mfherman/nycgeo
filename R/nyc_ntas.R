#' NYC neighborhood tabulation area boundaries
#'
#' Get current boundaries for neighborhood tabulation areas (NTAs) in New York
#' City in the simple features {sf} format. Either get all NTAs or a subset of
#' NTAs filtered by borough or public use microdata area (PUMA).
#'
#' @param filter_by The geography to filter by. Possible values are "borough",
#'   "puma", or "nta". If `NULL`, all NTAs are returned.
#' @param region A character vector of boroughs, PUMAs, or NTAs. Selected
#'   regions much match the geography indicated by `filter_by` argument.
#' @param add_acs_data If `TRUE`, selected demographic, social, and economic
#'   data from the U.S. Census Bureau American Community Survey is appended to
#'   NTA boundaries.
#' @param resolution The resolution of the map. Defaults to lower resolution.
#'
#' @return An `sf` object of NTA boundaries
#'
#' @details For more information about the metadata included with boundaries,
#'   see [ntas_sf].
#'
#' @examples
#' if (require(sf)) {
#'
#'   # get sf boundaires
#'   all_nyc_ntas <- nyc_ntas()
#'
#'   greenpoint_williamsburg_nta <- nyc_ntas(
#'     filter_by = "puma",
#'     region = "4001",
#'     resolution = "high"
#'     )
#'
#'   queens_brooklyn_ntas <- nyc_ntas(
#'     filter_by = "boro",
#'     region = c("queens", "brooklyn"),
#'     add_acs_data = TRUE
#'   )
#'
#'   # plot boundaries
#'   plot(st_geometry(all_nyc_ntas))
#'
#'   plot(st_geometry(greenpoint_williamsburg_nta))
#'
#'   plot(queens_brooklyn_ntas["pop_white_pct_est"])
#' }
#' @export

nyc_ntas <- function(filter_by = NULL,
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
    shp <- nycgeo::ntas_sf_simple
  } else if (resolution == "high") {
    shp <- nycgeo::ntas_sf
  }

  # if filter is requested subset by region(s)
  if (!is.null(filter_by) || !is.null(region)) {
    shp <- filter_by_region(shp, filter_by, region)
  }

  # append census data?
  if (add_acs_data) {
    shp <- merge(shp, nycgeo::ntas_acs_data, by = "nta_id", all.x = TRUE)
  }

  if (requireNamespace("sf", quietly = TRUE) &&
      requireNamespace("tibble", quietly = TRUE)) {
    shp <- sf::st_as_sf(tibble::as_tibble(shp))
  }
  shp
}