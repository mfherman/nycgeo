#' Find administrative districts for a set of points
#'
#' blah blah blah
#'
#' @param points An `sf` object containing only point features.
#' @param geography A character vector of geographies to. Possible values are
#'   "borough", "puma", "nta", "tract", or "block".
#'
#' @return An `sf` object of point features with administrative district codes appended.
#'
#' @details blag blag
#'
#' @examples
#' if (require(sf)) {
#'   points <- st_sf(geometry = st_sample(nyc_boros(), 100))
#'   nyc_point_poly(points, c("boro", "nta", "block"))
#' }
#'
#' @export

nyc_point_poly <- function(points, geography) {

  # require sf be installed
  if (!requireNamespace("sf", quietly = TRUE)) {
    stop("Package \"sf\" needed for this function to work. Please install it.",
         call. = FALSE)
  }

  # if crs don't match transform points to 2263
  if (sf::st_crs(points) != sf::st_crs(nyc_boros())) {
    message("Trasnsforming points to EPSG 2263")
    points <- sf::st_transform(points, 2263)
  }

  # validate geography selection
  geo <- tolower(geography)

  if (!(any(geo %in% c("boro", "borough", "puma", "nta", "tract", "block")))) {
    stop("Select a valid geography", call. = FALSE)
  }

  # get blocks sf
  poly <- nyc_blocks()

  # if (any(geo == "cd")) {
  #   poly <- nyc_cds(resolution = "high")
  # } else {
  #   poly <- nyc_blocks()
  # }

  # join points to blocks using st_within
  pts_poly <- sf_to_sf_tibble(sf::st_join(points, poly, join = sf::st_within))

  # choose which variables to include in output depending on geograhies selected
  if (any(geo %in% c("boro", "borough"))) {
    vars <- c("boro_name", "boro_id")
  }

  if (any(geo == "puma")) {
    vars <- c(vars, "puma_name", "puma_id")
  }

  if (any(geo == "nta")) {
    vars <- c(vars, "nta_name", "nta_id")
  }

  if (any(geo == "tract")) {
    vars <- c(vars, "tract_id")
  }

  if (any(geo == "block")) {
    vars <- c(vars, "boro_tract_block_id")
  }

  # subset final sf object to needed vars, move geometry to last col
  pts_poly[, c(names(points)[names(points) != "geometry"], vars, "geometry")]

}