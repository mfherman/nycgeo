% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/sf_data.R
\docType{data}
\name{council_sf}
\alias{council_sf}
\alias{council_sf_simple}
\title{NYC city council district boundaries}
\format{An sf object with 51 rows and 4 variables:
\describe{
\item{council_dist_id}{NYC city council district id}
\item{council_dist_name}{NYC city council district name}
\item{state_fips}{ANSI state FIPS code}
\item{geometry}{sfc_MULTIPOLYGON \cr
NAD83 / New York Long Island (ftUS); EPSG:2263}
}}
\source{
\url{https://www1.nyc.gov/site/planning/data-maps/open-data.page#other}
}
\usage{
council_sf

council_sf_simple
}
\description{
A simple features (sf) dataset containing the geometry of all city council
districts in New York City.
}
\keyword{datasets}
