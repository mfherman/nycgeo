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

  if (!(filter_by %in% c("borough", "nta", "puma", "cd",
                         "school", "police", "cong", "council"))) {
    stop("Please choose a valid geography to filter by")
  }

  if (filter_by == "borough") {
    filter <- (tolower(shp$borough_name) %in% region) |
      (tolower(shp$county_name) %in% region)
  } else if (filter_by == "nta") {
    filter <- (tolower(shp$nta_id) %in% region) |
      (tolower(shp$nta_name) %in% region)
  } else if (filter_by == "puma") {
    filter <- shp$puma_id %in% region
  } else if (filter_by == "cd") {
    filter <- shp$borough_cd_id %in% region
  } else if (filter_by == "school") {
    filter <- shp$school_dist_id %in% region
  } else if (filter_by == "council") {
    filter <- shp$council_dist_id %in% region
  } else if (filter_by == "police") {
    filter <- (shp$police_precinct_id %in% region) |
      (tolower(shp$police_precinct_name) %in% region)
  } else if (filter_by == "cong") {
    filter <- shp$cong_dist_id %in% region
  }

  if (sum(filter, na.rm = TRUE) < 1) {
    stop("No matches found for those regions")
  }

  shp[filter, ]
}



# get boundary, join with points
get_pts_boundary <- function(points, geo) {
  poly <- nyc_boundaries(geography = geo, resolution = "high")
  sf_to_sf_tibble(sf::st_join(points, poly, join = sf::st_within))
}

# subset sf object to needed geo_vars, move geometry to last col
reorder_pts_poly_vars <- function(pts_poly, points, geo_vars) {
  pts_poly[, c(names(points)[names(points) != "geometry"], geo_vars, "geometry")]
}

# bind 2 objects and convert to sf - works if one or both are sf objects to begin
bind_sfr <- function(x, y) {
  sf_to_sf_tibble(sf::st_sf(data.frame(x, y), stringsAsFactors = FALSE))
}


