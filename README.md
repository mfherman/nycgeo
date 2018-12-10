# nycgeo

[![Travis build status](https://travis-ci.org/mfherman/nycgeo.svg?branch=master)](https://travis-ci.org/mfherman/nycgeo)
[![lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![CRAN status](https://www.r-pkg.org/badges/version/nycgeo)](https://cran.r-project.org/package=nycgeo)
  
The `nycgeo` package contains spatial data files for various geographic and administrative boundaries in New York City. Data is in the [`sf` (simple features)](https://r-spatial.github.io/sf/) format and includes boundaries for boroughs (counties), neighborhood tabulation areas, community districts, public use microdata areas, census tracts, and census blocks.

## Installation

You can install the `nycgeo` from [GitHub](https://https://github.com/mfherman/nycgeo) with:

``` r
remotes::install_github("mfherman/nycgeo")
```

## Available Datasets

* `nyc_boro` - Boroughs
* `nyc_nta` - Neighborhood tabulation areas (NTAs)
* `nyc_tract` - Census tracts

## Future Datasets

* `nyc_block` - Census blocks
* `nyc_blockgroup` - Census block groups
* `nyc_cd` - Community districts (CDs)
* `nyc_puma` - Public use microdata areas (PUMAs)
* `nyc_council` - City Council districts
* `nyc_school` - School districts
* `nyc_police` - Police precincts
* `nyc_cong` - U.S. Congressional districts
* `nyc_assembly` - State Assembly districts
* `nyc_senate` - State Senate districts