.onAttach <- function(libname, pkgname) {
  if (!isNamespaceLoaded("sf")) {
  packageStartupMessage("To work with the spatial data included in this package, you should also load the {sf} package with library(sf).")
  }
}

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

  if (!(filter_by %in% c("boro", "borough", "nta", "puma", "cd"))) {
    stop("Please choose a valid geography to filter by")
  }

  if (filter_by %in% c("boro", "borough")) {
    filter <- (tolower(shp$boro_name) %in% region) |
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


# don't think i need these anymore?

# filter_by_boro <- function(shp, borough = NULL) {
#   if (is.null(borough)) return(shp)
#
#   stopifnot(is.character(borough))
#
#   filter <- (tolower(shp$boro_name) %in% borough) |
#     (tolower(shp$county_name) %in% borough)
#
#   if (sum(filter, na.rm = TRUE) < 1) stop("No matches found for those boroughs.")
#
#   shp[filter, ]
# }
#
# filter_by_nta <- function(shp, nta = NULL) {
#   if (is.null(nta)) return(shp)
#
#   stopifnot(is.character(nta))
#
#   filter <- (tolower(shp$nta_id) %in% nta) |
#     (tolower(shp$nta_name) %in% nta)
#
#   if (sum(filter, na.rm = TRUE) < 1) stop("No matches found for those NTAs")
#
#   shp[filter, ]
# }
#
# filter_by_puma <- function(shp, puma = NULL) {
#   if (is.null(puma)) return(shp)
#
#   puma <- as.character(puma)
#
#   filter <- as.character(shp$puma_id) %in% puma
#
#   if (sum(filter, na.rm = TRUE) < 1) stop("No matches found for those PUMAs")
#
#   shp[filter, ]
# }
#
# filter_by_cd <- function(shp, cd = NULL) {
#   if (is.null(cd)) return(shp)
#
#   cd <- as.character(cd)
#
#   filter <- as.character(shp$boro_cd_id) %in% cd
#
#   if (sum(filter, na.rm = TRUE) < 1) stop("No matches found for those CDs")
#
#   shp[filter, ]
# }
