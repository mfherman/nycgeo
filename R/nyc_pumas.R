#' NYC public use microdata area boundaries
#'
#' Get current boundaries for public use microdata area (PUMAs) in New York City
#' in the simple features {sf} format. Either get all PUMAs or a subset of PUMAs
#' filtered by borough or PUMA.
#'
#' @param filter_by The geography to filter by. Possible values are "borough" or
#'   "puma". If `NULL`, all PUMAs are returned.
#' @param region A character vector of boroughs or PUMAs. Selected regions much
#'   match the geography indicated by `filter_by` argument.
#' @param add_acs_data If `TRUE`, selected demographic, social, and economic
#'   data from the U.S. Census Bureau American Community Survey is appended to
#'   PUMA boundaries.
#' @param resolution The resolution of the map. Defaults to lower resolution.
#'
#' @return An `sf` object of PUMA boundaries
#'
#' @details For more information about the metadata included with boundaries,
#'   see [pumas_sf].
#'
#' @examples
#' if (require(sf)) {
#'
#'   # get sf boundaires
#'   all_nyc_pumas <- nyc_pumas()
#'
#'   greenpoint_williamsburg_puma <- nyc_pumas(
#'     filter_by = "puma",
#'     region = "4001",
#'     resolution = "high"
#'     )
#'
#'   queens_brooklyn_pumas <- nyc_pumas(
#'     filter_by = "boro",
#'     region = c("queens", "brooklyn"),
#'     add_acs_data = TRUE
#'   )
#'
#'   # plot boundaries
#'   plot(st_geometry(all_nyc_pumas))
#'
#'   plot(st_geometry(greenpoint_williamsburg_puma))
#'
#'   plot(queens_brooklyn_pumas["med_age_est"])
#' }
#' @export

nyc_pumas <- function(filter_by = NULL,
                      region = NULL,
                      add_acs_data = FALSE,
                      resolution = c("low", "high")) {


  # validate filter by
  if (!is.null(filter_by)) {
    filter_by <- tolower(filter_by)

    # geography must be boro or puma
    if (!is.null(filter_by) &&
        !(filter_by %in% c("boro", "borough", "puma"))) {
      stop("Please choose a valid geography to filter by")
    }
  }

  # set low or high resolution
  resolution <- match.arg(resolution)

  # get low or high resolution sf file
  if (resolution == "low") {
    shp <- nycgeo::pumas_sf_simple
  } else if (resolution == "high") {
    shp <- nycgeo::pumas_sf
  }

  # if filter is requested subset by region(s)
  if (!is.null(filter_by) || !is.null(region)) {
    shp <- filter_by_region(shp, filter_by, region)
  }

  # append census data?
  if (add_acs_data) {
    shp <- merge(shp, nycgeo::pumas_acs_data, by = "geoid", all.x = TRUE)
    shp <- sf_to_sf_tibble(shp)
  }
  shp
}