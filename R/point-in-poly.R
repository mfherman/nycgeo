#' Find which administrative districts a set of points are within
#'
#' Point-in-polygon operation for NYC administrative boundaries. Use
#' `nyc_point_poly()` on a set of points to determine which administrative
#' district each point lies within.
#'
#' @param points An `sf` object containing only point features.
#' @param geography A character vector of administrative boundaries to append to
#'   points. Possible values are "borough", "puma", "cd" "nta", "tract", and
#'   "block". If more than one geography is selected, names and codes for each
#'   geography is appended.
#'
#' @return An `sf` object of point features with administrative district names
#'   and and codes appended.
#'
#' @details Using `nyc_point_poly()` requires installing the [`sf`
#'   package]("https://r-spatial.github.io/sf/").
#'
#' @examples
#' if (require(sf)) {
#'
#'   # generate 100 random points in nyc
#'   points <- st_sf(geometry = st_sample(nyc_boros(), 100))
#'
#'   nyc_point_poly(points = points, geography = c("borough", "nta", "block"))
#' }
#'
#' @export

nyc_point_poly <- function(points, geography) {

  # require sf be installed
  if (!requireNamespace("sf", quietly = TRUE)) {
    stop("Package \"sf\" needed for this function to work. Please install it.",
         call. = FALSE)
  }

  # all features must be points
  if (!all(sf::st_geometry_type(points) == "POINT")) {
    stop("All features of `sf` input data must be points.", call. = FALSE)
  }

  # if crs doesn't match, transform points to 2263
  if (sf::st_crs(points) != sf::st_crs(nyc_boros())) {
    message("Trasnsforming points to EPSG 2263")
    points <- sf::st_transform(points, 2263)
  }

  # validate geography selection
  geo <- tolower(geography)

  if (any(!(geo %in% c("boro", "borough", "puma", "cd",
                       "nta", "tract", "block")))) {
    stop("Select a valid geography", call. = FALSE)
  }

  # if only selected geo is cd
  if (length(geo) == 1 && geo == "cd") {
    cd_poly <- nyc_cds(resolution = "high")

    # join points to cds using st_within
    pts_cd_poly <- sf_to_sf_tibble(sf::st_join(points, cd_poly,
                                               join = sf::st_within))

    pts_cd_poly <- pts_cd_poly[, c(names(points)[names(points) != "geometry"],
                    "cd_name", "boro_cd_id", "geometry")]

    return(pts_cd_poly)

  # for all other geographies or if cd and another geo is selected
  } else {
    # get blocks sf
    poly <- nyc_blocks()

    # join points to blocks using st_within
    pts_poly <- sf_to_sf_tibble(sf::st_join(points, poly, join = sf::st_within))
  }

  # set up empty vector for geo variables
  geo_vars <- vector("character")

  # choose which variables to include depending on geograhies selected
  if (any(geo %in% c("boro", "borough"))) {
    geo_vars <- c("boro_name", "boro_id")
  }

  if (any(geo == "puma")) {
    geo_vars <- c(geo_vars, "puma_name", "puma_id")
  }

  if (any(geo == "nta")) {
    geo_vars <- c(geo_vars, "nta_name", "nta_id")
  }

  if (any(geo == "tract")) {
    geo_vars <- c(geo_vars, "tract_id")
  }

  if (any(geo == "block")) {
    geo_vars <- c(geo_vars, "boro_tract_block_id")
  }

  if (length(geo) > 1 && any(geo == "cd")) {
    cd_poly <- nyc_cds(resolution = "high")

    # join points to cds using st_within
    pts_cd_poly <- sf_to_sf_tibble(sf::st_join(points, cd_poly,
                                             join = sf::st_within))

    # select only cd vars
    pts_cd_poly <- pts_cd_poly[, c("cd_name", "boro_cd_id")]

    sf::st_geometry(pts_cd_poly) <- NULL

    # subset sf object to needed geo_vars, move geometry to last col
    pts_poly <- pts_poly[, c(names(points)[names(points) != "geometry"],
                             geo_vars, "geometry")]

    # bind cd columns
    pts_poly <- sf_to_sf_tibble(
      sf::st_sf(data.frame(pts_poly, pts_cd_poly), stringsAsFactors = FALSE)
      )

    return(pts_poly)
  }

  # subset final sf object to needed geo_vars, move geometry to last col
  pts_poly[, c(names(points)[names(points) != "geometry"],
               geo_vars, "geometry")]
}