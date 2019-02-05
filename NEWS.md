# nycgeo 0.1.0.9000

* Added school district (`nycgeo::school_sf`), police precinct(`nycgeo::police_sf`) , city council (`nycgeo::council_sf`), and U.S. Congressional (`nycgeo::cong_sf`) boundaries.
* Updated `nycgeo::nta_acs_data` to include properly aggregated data from `nycgeo::tract_acs_data`. Also, removed NTAs without population (e.g. parks, cemeteries, airports) from `nycgeo::tract_acs_data`.
* Fixed bug in `nyc_boundaries()` when filtering by CD.
* `nyc_point_poly()` now returns `county_fips` column when requesting tracts.
* Added tests.
* Added a `NEWS.md` file to track changes to the package.
* Added a package logo.
* Updated ACS datasets documentation.

# nycgeo 0.1.0

* Initial release!
