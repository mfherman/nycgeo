#' NYC community district boundaries
#'
#' Get current boundaries for community districts (CDs) and joint interest areas
#' in New York City in the simple features {sf} format. Either get all CDs or a
#' subset of CDs filtered by borough.
#'
#' @param filter_by The geography to filter by. Possible values are
#'   "borough" or "cd. If `NULL`, all CDs are returned.
#' @param region A character vector of boroughs or CDs. Selected regions much
#'   match the geography indicated by `filter_by` argument.
#' @param resolution The resolution of the map. Defaults to lower resolution.
#'
#' @return An `sf` object of CD boundaries
#'
#' @details For more information about the metadata included with boundaries,
#'   see [cds_sf].
#'
#' @examples
#' if (require(sf)) {
#'
#'   # get sf boundaires
#'   all_nyc_cds <- nyc_cds()
#'
#'   queens_brooklyn_cds <- nyc_cds(
#'     filter_by = "boro",
#'     region = c("queens", "brooklyn")
#'   )
#'
#'   # plot boundaries
#'   plot(st_geometry(all_nyc_cds))
#'
#'   plot(st_geometry(queens_brooklyn_cds))
#' }
#' @export

nyc_cds <- function(filter_by = NULL,
                    region = NULL,
                    # add_acs_data = FALSE,
                    resolution = c("low", "high")) {

  # validate filter by
  if (!is.null(filter_by)) {
    filter_by <- tolower(filter_by)

    # geography must be boro or cd
    if(!(filter_by %in% c("boro", "borough", "cd"))) {
      stop("Please choose a valid geography to filter by")
    }
  }

  # set low or high resolution
  resolution <- match.arg(resolution)

  # get low or high resolution sf file
  if (resolution == "low") {
    shp <- nycgeo::cds_sf_simple
  } else if (resolution == "high") {
    shp <- nycgeo::cds_sf
  }

  # if filter is requested subset by region(s)
  if (!is.null(filter_by) || !is.null(region)) {
    shp <- filter_by_region(shp, filter_by, region)
  }

  shp

}