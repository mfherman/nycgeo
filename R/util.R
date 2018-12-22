# convert sf class to sf + tibble class
# only if sf and tibble are installed
sf_to_sf_tibble <- function(x) {
  if (requireNamespace("sf", quietly = TRUE) &&
      requireNamespace("tibble", quietly = TRUE)) {
    sf::st_as_sf(tibble::as_tibble(x))
  }
}