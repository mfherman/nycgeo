# print message on attaching if `sf` is not loaded
.onAttach <- function(libname, pkgname) {
  if (!isNamespaceLoaded("sf")) {
    packageStartupMessage("To work with the spatial data included in this package, you should also load the {sf} package with library(sf).")
  }
}

# convert sf class to sf + tibble class
# only if sf and tibble are installed
sf_to_sf_tibble <- function(x) {
  if (requireNamespace("sf", quietly = TRUE) &&
      requireNamespace("tibble", quietly = TRUE)) {
    sf::st_as_sf(tibble::as_tibble(x))
  }
}

# function used in nyc_boundaries to filter sf objects by region
filter_by_region <- function(shp, filter_by = NULL, region = NULL) {

  if (is.null(region) && is.null(filter_by)) {
    return(shp)
  }

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

  region <- tolower(as.character(region))

  if (!(filter_by %in% c("borough", "nta", "puma", "cd"))) {
    stop("Please choose a valid geography to filter by")
  }

  if (filter_by == "borough") {
    filter <- (tolower(shp$borough_name) %in% region) |
      (tolower(shp$county_name) %in% region)
  } else if (filter_by == "nta") {
    filter <- (tolower(shp$nta_id) %in% region) |
      (tolower(shp$nta_name) %in% region)
  } else if (filter_by == "puma") {
    filter <- as.character(shp$puma_id) %in% region
  } else {
    filter <- as.character(shp$boro_cd_id) %in% region
  }

  if (sum(filter, na.rm = TRUE) < 1) {
    stop("No matches found for those regions")
  }

  shp[filter, ]
}