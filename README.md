# Estimating Barangay Poverty Incidence through Geostatistics

James Matthew Miraflor  
james.miraflor@gmail.com

September 2013

## Description

This is an exploratory attempt to produce barangay-level poverty estimates
using geostatistics, particularly ordinary Kriging, based on the 2009
Municipal-level Small Area Estimates (SAE) of Poverty Incidence.

The Province of Cavite is used as the initial test case.

The basic idea is to examine the spatial structure of municipal poverty
incidence and use the observed spatial dependence to interpolate poverty
incidence at locations within barangays.

The procedure is done by province since the observations should cover a
sufficiently contiguous geographic area for the geostatistical analysis.

The same procedure may subsequently be applied to other provinces.

## Method

The analysis proceeds roughly as follows:

1. Map the 2009 municipal SAE poverty incidence estimates.
2. Examine the spatial distribution of municipal poverty incidence.
3. Construct an H-scatterplot to examine spatial dependence at different
   distances.
4. Construct an empirical semivariogram.
5. Fit theoretical semivariogram models.
6. Compare spherical and exponential models.
7. Use the selected semivariogram model for ordinary Kriging.
8. Interpolate poverty incidence over barangay areas.
9. Produce barangay-level poverty estimates and corresponding maps.

The present Cavite run uses the exponential semivariogram model for the
Kriging estimates.

## Files

### Presentation

- `Estimating Barangay Poverty Incidence through Geostatistics.pptx`
- `Estimating Barangay Poverty Incidence through Geostatistics.pdf`

These contain a short presentation of the method and exploratory results.

### Maps and Figures

- `CAVITE _POVINC_MUNI_SAE.png`

  Municipal poverty incidence from the 2009 Small Area Estimates.

- `CAVITE _POVINC_H-SCATTER.png`

  H-scatterplot of Cavite municipal poverty incidence.

- `CAVITE _SEMIVARIOGRAM.png`

  Empirical semivariogram of poverty incidence.

- `CAVITE _KRIGING_EXPONENTIAL.png`

  Exponential semivariogram fit.

- `CAVITE _KRIGING_SPHERICAL.png`

  Spherical semivariogram fit.

- `CAVITE _POVINC_BRGY_krig-grid.png`

  Interpolated poverty-incidence surface produced through Kriging.

- `CAVITE _POVINC_BRGY_krig.png`

  Estimated barangay-level poverty incidence.

### R Files

- `kriging_napc.r`

  R code used for the analysis.

- `POVKRIGE.RData`

  Saved R workspace.

- `.Rhistory`

  R command history retained from the development of the analysis. This
  contains part of the exploratory process used in developing and testing
  the procedure.

### Documentation

- `Technical Notes on Kriging (for NAPC-PMSTS).docx`

  Some technical notes on the Kriging procedure and its possible use for
  poverty estimation.

## Data

The original output data containing barangay poverty estimates and estimated
poor population were also distributed as:

    brgy_povinc_krig.xlsx

A copy was made available at:

https://www.dropbox.com/s/7wnnushtwsy8h3e/brgy_povinc_krig.xlsx

The R code also requires the municipal and barangay administrative boundary
files used in the analysis.

## Running the Analysis

The analysis was written in R using the spatial packages available at the
time, including:

- `sp`
- `maptools`
- `spdep`
- `gstat`
- `splancs`
- `spatstat`
- `pgirmess`
- `spgwr`
- `spgrass6`
- `raster`

Run `kriging_napc.r` from the project directory.

The script currently uses:

    prov_selected = "CAVITE"

To run the same procedure for another province, change this value to the
desired province.

## Notes

These estimates are experimental.

Municipal poverty incidence is an areal statistic rather than a direct
measurement of an underlying continuous physical process, so the use of
Kriging for this purpose should be interpreted with caution.

The resulting values should therefore not be treated as official
barangay-level poverty estimates. The purpose of this exercise is to test
whether geostatistical interpolation can provide useful approximate
information for areas below the municipality level where direct poverty
estimates are not presently available.

The Cavite exercise is intended as a test case for further verification and
possible application to other provinces.

## Motivation

There is considerable interest in obtaining poverty estimates below the
municipality level for geographic targeting and local planning.

This exercise explores whether existing municipal SAE estimates, together
with their spatial relationships, can provide one possible way of producing
preliminary barangay-level estimates while more rigorous small-area
estimation methods are being investigated.