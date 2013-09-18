# Estimating Barangay Poverty Incidence through Geostatistics

September 2013

## About

This is an exploratory attempt to estimate poverty incidence at the
barangay level using geostatistical interpolation.

Official poverty estimates are generally available at higher geographic
levels. The idea explored here is whether the spatial pattern of poverty
incidence across municipalities can be used to produce approximate
estimates for smaller geographic areas through kriging.

The current example uses Cavite.

## Method

The procedure is roughly as follows:

1. Use municipal poverty incidence estimates as the observed values.
2. Represent municipalities spatially using their geographic locations.
3. Examine how differences in poverty incidence vary with distance.
4. Construct an empirical semivariogram.
5. Fit theoretical variogram models to the observed spatial dependence.
6. Use the fitted variogram for ordinary kriging.
7. Interpolate poverty incidence over barangay areas and a regular spatial
   grid.

Both spherical and exponential variogram models are examined in the R
code. The current implementation uses the exponential model for the final
kriging estimates.

The resulting estimates should be treated as experimental rather than as
official barangay poverty estimates.

## Files

- `kriging_napc.r`
  R code for preparing the spatial data, fitting the variogram and
  performing the kriging interpolation.

- `Estimating Barangay Poverty Incidence through Geostatistics.pdf`
  Presentation describing the approach and preliminary results.

- `Estimating Barangay Poverty Incidence through Geostatistics.pptx`
  Editable copy of the presentation.

- `Technical Notes on Kriging (for NAPC-PMSTS).docx`
  Technical notes accompanying the exercise.

- `POVKRIGE.RData`
  Saved R workspace used for the analysis.

The PNG files contain intermediate and final outputs for the Cavite
example, including:

- municipal poverty incidence;
- municipal centroids;
- the spatial h-scatterplot;
- the empirical semivariogram;
- fitted spherical and exponential variograms; and
- barangay and grid-based kriging estimates.

## R Code

The analysis was written in R using the spatial packages available at the
time, particularly `sp`, `maptools`, `gstat`, `spdep`, `spatstat`,
`spgrass6` and `raster`.

The script expects the municipal and barangay administrative boundary
files to be available under a `base` directory:

    base/opapp_admi_muni.shp
    base/opapp_admi_brgy.shp

The associated shapefile components and attribute tables are also
required.

To analyze another province, change the value of:

    prov_selected = "CAVITE"

in `kriging_napc.r`.

## Notes

Kriging was developed primarily for spatial interpolation of continuously
varying phenomena. Its application to poverty incidence over administrative
areas therefore requires care in interpretation.

The purpose of this exercise is to explore whether geostatistical methods
can provide useful information at geographic levels for which direct
poverty estimates are unavailable, and to provide a basis for further
testing and refinement.