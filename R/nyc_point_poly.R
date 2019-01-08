#' Find which administrative districts a set of points are within
#'
#' Point-in-polygon operation for NYC administrative boundaries. Use
#' `nyc_point_poly()` on a set of points to determine which administrative
#' district each point lies within.
#'
#' @param points An `sf` object containing only point features.
#' @param geography A character vector of administrative boundaries to append to
#'   points. Possible values are "borough", "puma", "cd", "nta", "school",
#'   "council", "police", "cong", "tract" and "block". If more than one
#'   geography is selected, names and codes for each geography is appended.
#'
#' @return An `sf` object of point features with administrative district names
#'   and and codes appended.
#'
#' @details Using `nyc_point_poly()` requires installing the [`sf`
#'   package](https://r-spatial.github.io/sf/).
#'
#' @examples
#' if (require(sf)) {
#'
#'   # generate 100 random points in nyc
#'   points <- st_sf(geometry = st_sample(nyc_boundaries(), 100))
#'
#'   nyc_point_poly(points = points, geography = c("borough", "nta", "cd"))
#' }
#'
#' @export

nyc_point_poly <- function(points, geography = c("borough", "puma", "nta",
                                                  "cd", "tract", "block",
                                                  "school", "police", "council",
                                                  "cong")
                            ) {

  # require sf be installed
  if (!requireNamespace("sf", quietly = TRUE)) {
    stop("Package \"sf\" needed for this function to work. Please install it.",
         call. = FALSE)
  }

  # all features must be points
  if (!all(sf::st_geometry_type(points) == "POINT")) {
    stop("All features of `sf` input data must be points.", call. = FALSE)
  }

  # validate geography selection
  geo <- match.arg(geography, several.ok = TRUE)

  # if crs doesn't match, transform points to 2263
  if (sf::st_crs(points) != sf::st_crs(nyc_boundaries())) {
    message("Trasnsforming points to EPSG 2263")
    points <- sf::st_transform(points, 2263)
  }

  # set up empty vector for geo variables
  geo_vars <- vector("character")

  # choose which variables to include depending on geograhies selected
  if (any(geo == "borough")) {
    geo_vars <- c("borough_name", "borough_id")
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
    geo_vars <- c(geo_vars, "borough_tract_block_id")
  }

  if (any(geo == "cong")) {
    geo_vars <- c(geo_vars, "cong_dist_name", "cong_dist_id")
  }

  if (any(geo == "cd")) {
    geo_vars <- c(geo_vars, "cd_name", "borough_cd_id")
  }

  if (any(geo == "council")) {
    geo_vars <- c(geo_vars, "council_dist_name", "council_dist_id")
  }

  if (any(geo == "police")) {
    geo_vars <- c(geo_vars, "police_precinct_name", "police_precinct_id")
  }

  if (any(geo == "school")) {
    geo_vars <- c(geo_vars, "school_dist_name", "school_dist_id")
  }

  # for only one selected geo return pts joined
  if (length(geo) == 1) {
    pts_poly <- get_pts_boundary(points, geo)
    return(reorder_pts_poly_vars(pts_poly, points, geo_vars))

  } else {

    # start with points
    pts_poly <- points

    if (any(geo %in% c("borough", "puma", "nta", "tract", "block", "cong"))) {
      pts_poly_block <- get_pts_boundary(points, "block")
    }

    # if geo is requested, find boundaries and bind with points sf object
    # continue for each of the geos not contatined in block boundaries

    if (any(geo == "cd")) {
      pts_poly_df <- sf::st_set_geometry(get_pts_boundary(points, "cd"), NULL)
      pts_poly <- bind_sfr(pts_poly, pts_poly_df)
    }

    if (any(geo == "council")) {
      pts_poly_df <- sf::st_set_geometry(get_pts_boundary(points, "council"), NULL)
      pts_poly <- bind_sfr(pts_poly, pts_poly_df)
    }

    if (any(geo == "police")) {
      pts_poly_df <- sf::st_set_geometry(get_pts_boundary(points, "police"), NULL)
      pts_poly <- bind_sfr(pts_poly, pts_poly_df)
    }

    if (any(geo == "school")) {
      pts_poly_df <- sf::st_set_geometry(get_pts_boundary(points, "school"), NULL)
      pts_poly <- bind_sfr(pts_poly, pts_poly_df)
    }

    # filter final sf object by geo_vars

    # if no non-block geos were requested, return blocks filtred by geo_vars
    # else if block geos found also, bind block pts to other geo pts
    # else just return pts

    if (identical(pts_poly, points)) {
        pts_poly_block[, geo_vars]
    } else if (exists("pts_poly_block")) {
       bind_sfr(pts_poly_block, pts_poly)[, geo_vars]
    } else {
      pts_poly[, geo_vars]
    }

  }
}