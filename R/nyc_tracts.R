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
#'   regions much match the geography indicated by `filter_by` argument.
#' @param resolution The resolution of the map. Defaults to lower resolution.
#'
#' @return An `sf` object of census tract boundaries
#'
#' @examples
#' if (require(sf)) {
#'
#'   # get sf boundaires
#'   all_nyc_tracts <- nyc_tracts()
#'   queens_tracts <- nyc_tracts(filter_by = "borough", region = "Queens")
#'   north_si_tracts <- nyc_tracts(
#'     filter_by = "nta",
#'     region = c("SI22", "SI35"),
#'     resolution = "high"
#'     )
#'
#'   # plot boundaries
#'   plot(st_geometry(all_nyc_tracts))
#'   plot(st_geometry(queens_tracts))
#'   plot(st_geometry(queens_tracts))
#' }
#'
#' @export

nyc_tracts <- function(filter_by = NULL,
                      region = NULL,
                      resolution = c("low", "high")) {

  # make arguments lower case
  if (!is.null(filter_by)) {
    filter_by <- tolower(filter_by)
  }

  if (!is.null(region)) {
    region <- tolower(region)
  }

  # check argument validity
  # only one geography to filter by
  if (length(filter_by) > 1) {
    stop("Can only filter by one geography")
  }

  # must choose region(s) if filtering
  if (!is.null(filter_by) & is.null(region)) {
    stop("Please specify one or more region to filter by")
  }

  # must choose geography if regions are specified
  if (is.null(filter_by) & !is.null(region)) {
    stop("Please specify a geography to filter by")
  }

  # # geography must be boro, nta or puma
  # if (!is.null(filter_by) &
  #       !(filter_by %in% c("borough", "boro", "nta", "puma")) &
  #       !is.null(region)) {
  #   stop("Please choose a valid geography to filter by")
  # }

  # set low or high resolution
  resolution <- match.arg(resolution)

  # get low or high resolution sf file
  if (resolution == "low") {
    shp <- nycgeo::nyc_tract_simple
  } else if (resolution == "high") {
    shp <- nycgeo::nyc_tract
  }

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
  shp
}