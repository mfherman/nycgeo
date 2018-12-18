.onAttach <- function(libname, pkgname) {
  if (!isNamespaceLoaded("sf")) {
  packageStartupMessage("To work with the spatial data included in this package, you should also load the {sf} package with library(sf).")
  }
}

filter_by_boro <- function(shp, borough = NULL) {
  if (is.null(borough)) return(shp)

  stopifnot(is.character(borough))

  filter <- (tolower(shp$boro_name) %in% borough) |
    (tolower(shp$county_name) %in% borough)

  if (sum(filter, na.rm = TRUE) < 1) stop("No matches found for those boroughs.")

  shp[filter, ]
}

filter_by_nta <- function(shp, nta = NULL) {
  if (is.null(nta)) return(shp)

  stopifnot(is.character(nta))

  filter <- (tolower(shp$nta_id) %in% nta) |
    (tolower(shp$nta_name) %in% nta)

  if (sum(filter, na.rm = TRUE) < 1) stop("No matches found for those NTAs")

  shp[filter, ]
}

filter_by_puma <- function(shp, puma = NULL) {
  if (is.null(puma)) return(shp)

  puma <- as.character(puma)

  filter <- as.character(shp$puma_id) %in% puma

  if (sum(filter, na.rm = TRUE) < 1) stop("No matches found for those PUMAs")

  shp[filter, ]
}
