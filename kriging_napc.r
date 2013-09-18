# Clear the workspace
rm(list=ls())

# Install packages
#install.packages("maps")
#install.packages("maptools")
#install.packages("sp")
#install.packages("spdep")
#install.packages("gstat")
#install.packages("splancs")
#install.packages("spatstat")
#install.packages("lattice")
#install.packages("pgirmess")
#install.packages("RColorBrewer")
#install.packages("classInt")
#install.packages("spgwr")
#install.packages("spgrass6")
#install.packages("raster")


## Load spatial packages
library(maps)         # Projections
library(maptools)     # muni management
library(sp)           # muni management
library(spdep)        # Spatial autocorrelation
library(gstat)        # Geostatistics
library(splancs)      # Kernel Density
library(spatstat)     # Geostatistics
library(pgirmess)     # Spatial autocorrelation
library(RColorBrewer) # Visualization
library(classInt)     # Class intervals
library(spgwr)        # GWR
library(spgrass6)
library(raster)


# Function: Convert km to degrees
km2d <- function(km){
out <- (km/1.852)/60
return(out)
}
km2d(500) # 500 km
# Function: Convert degrees to km
d2km <- function(d){
out <- d*60*1.852
return(out)
}
d2km(1) # 1 degree

# Set directory
setwd("E:\\NAPC\\NAPC_GEOSTAT")
#setwd("C:\\Users\\Administrator\\Documents\\users\\miraflor\\NAPC_GEOSTAT")

# New CRS
new_crs <- "+proj=robin +lon_0=0 +x_0=0 +y_0=0 +ellps=WGS84 +datum=WGS84
+units=m +no_defs"
#new_crs <- "+proj=longlat +ellps=clrk66"
#new_crs <- "+proj=longlat +lon_0=0 +x_0=0 +y_0=0 +ellps=clrk66 +datum=clrk66"

# Set projection in R workspace:
#proj <- CRS("+proj=utm +zone=51 +datum=WGS84")
#muni <- readShapePoly("base\\opapp_admi_muni.shp",
#IDvar="MUNICODE", proj4string=CRS("+proj=longlat +ellps=clrk66"))
#dim(muni)
#names(muni)
#summary(muni)
#IDs <- muni$GEOCODE

brgy_poly <- readShapePoly("base\\opapp_admi_brgy.shp",
IDvar="BRGY_CODE", proj4string=CRS("+proj=longlat +ellps=clrk66"))
muni_poly <- readShapePoly("base\\opapp_admi_muni.shp",
IDvar="MUNICODE", proj4string=CRS("+proj=longlat +ellps=clrk66"))

# Transform CRS
brgy_poly <- spTransform(brgy_poly, CRS(new_crs))
muni_poly <- spTransform(muni_poly, CRS(new_crs))

muni_poly$POPDENSITY = muni_poly$POPULATION/muni_poly$LANDAREA
muni_poly$POVERTY_INCIDENCE = muni_poly$POVERTY_IN/100
muni_poly$POVERTY_INCIDENCE = muni_poly$POVERTY_IN/100
muni_poly$POOR <- (muni_poly$POVERTY_INCIDENCE)*muni_poly$POPULATION
muni_poly$GROSS_PROD <- (muni_poly$GROSS_PROD)*1000
muni_poly$PER_CAPITA <- muni_poly$GROSS_PROD/muni_poly$POPULATION
error <- is.nan(muni_poly$PER_CAPITA) 
muni_poly$PER_CAPITA[error] <- 0
muni_poly <- muni_poly[!(muni_poly$LON<=110), ]
muni_poly <- muni_poly[!(muni_poly$LAT<=0), ]
dim(muni_poly)

# Select a province, delete the rest
#prov_selected = "BASILAN"
#prov_selected = "LANAO DEL SUR"
#prov_selected = "MAGUINDANAO"
#prov_selected = "SULU"
#prov_selected = "TAWI-TAWI"
#prov_selected = "ABRA"
#prov_selected = "APAYAO"
#prov_selected = "BENGUET"
#prov_selected = "IFUGAO"
#prov_selected = "KALINGA"
#prov_selected = "MOUNTAIN PROVINCE"
#prov_selected = "NATIONAL CAPITAL REGION"
#prov_selected = "ILOCOS NORTE"
#prov_selected = "ILOCOS SUR"
#prov_selected = "LA UNION"
#prov_selected = "PANGASINAN"
#prov_selected = "BATANES"
#prov_selected = "CAGAYAN"
#prov_selected = "ISABELA"
#prov_selected = "NUEVA VIZCAYA"
#prov_selected = "QUIRINO"
#prov_selected = "AURORA"
#prov_selected = "BATAAN"
#prov_selected = "BULACAN"
#prov_selected = "NUEVA ECIJA"
#prov_selected = "PAMPANGA"
#prov_selected = "TARLAC"
#prov_selected = "ZAMBALES"
#prov_selected = "BATANGAS"
prov_selected = "CAVITE"
#prov_selected = "LAGUNA"
#prov_selected = "QUEZON"
#prov_selected = "RIZAL"
#prov_selected = "MARINDUQUE"
#prov_selected = "OCCIDENTAL MINDORO"
#prov_selected = "ORIENTAL MINDORO"
#prov_selected = "PALAWAN"
#prov_selected = "ROMBLON"
#prov_selected = "CITY OF ISABELA (Not a Province)"
#prov_selected = "ZAMBOANGA DEL NORTE"
#prov_selected = "ZAMBOANGA DEL SUR"
#prov_selected = "ZAMBOANGA SIBUGAY"
#prov_selected = "ALBAY"
#prov_selected = "CAMARINES NORTE"
#prov_selected = "CAMARINES SUR"
#prov_selected = "CATANDUANES"
#prov_selected = "MASBATE"
#prov_selected = "SORSOGON"
#prov_selected = "AKLAN"
#prov_selected = "ANTIQUE"
#prov_selected = "CAPIZ"
#prov_selected = "GUIMARAS"
#prov_selected = "ILOILO"
#prov_selected = "NEGROS OCCIDENTAL"
#prov_selected = "BOHOL"
#prov_selected = "CEBU"
#prov_selected = "NEGROS ORIENTAL"
#prov_selected = "SIQUIJOR"
#prov_selected = "BILIRAN"
#prov_selected = "EASTERN SAMAR"
#prov_selected = "LEYTE"
#prov_selected = "NORTHERN SAMAR"
#prov_selected = "SAMAR (WESTERN SAMAR)"
#prov_selected = "SOUTHERN LEYTE"
#prov_selected = "BUKIDNON"
#prov_selected = "CAMIGUIN"
#prov_selected = "LANAO DEL NORTE"
#prov_selected = "MISAMIS OCCIDENTAL"
#prov_selected = "MISAMIS ORIENTAL"
#prov_selected = "COMPOSTELA VALLEY"
#prov_selected = "DAVAO DEL NORTE"
#prov_selected = "DAVAO DEL SUR"
#prov_selected = "DAVAO ORIENTAL"
#prov_selected = "COTABATO (NORTH COTABATO)"
#prov_selected = "COTABATO CITY (Not a Province)"
#prov_selected = "SARANGANI"
#prov_selected = "SOUTH COTABATO"
#prov_selected = "SULTAN KUDARAT"
#prov_selected = "AGUSAN DEL NORTE"
#prov_selected = "AGUSAN DEL SUR"
#prov_selected = "DINAGAT ISLANDS"
#prov_selected = "SURIGAO DEL NORTE"
#prov_selected = "SURIGAO DEL SUR"

# Retain only province selected
muni_poly <- muni_poly[muni_poly$PROVNAME==prov_selected, ]
dim(muni_poly)
brgy_poly <- brgy_poly[brgy_poly$PROVNAME==prov_selected, ]
dim(brgy_poly)

png(file=paste(prov_selected,"_POVINC_MUNI_SAE.png"),width=2500,height=3000,res=400,pointsize=2)
spplot(muni_poly,zcol="POVERTY_INCIDENCE",col.regions=rev(heat.colors(100)),main=paste(prov_selected,' - SAE'))
dev.off();

# Keep only necessary variables
#muni_poly <- muni_poly[c("PROVNAME", "MUNINAME", "MUNICODE", "LAT", "LON", "POVERTY_IN")]
#brgy_poly <- brgy_poly[c("MUNINAME", "BRGY_CODE", "BRGYNAME", "RUR_URB")]

# Save RData
save(muni_poly, brgy_poly, file = "POVKRIGE.RData")
#unlink("POVKRIGE.RData")

# Load RData
#load("POVKRIGE.RData")

muni = muni_poly@data

## Create matrix of coordinates 
sp_point <- coordinates(muni_poly)
#sp_point <- matrix(NA, nrow=nrow(muni),ncol=2)
#sp_point[,1] <- jitter(muni$LON,.000001)
#sp_point[,2] <- jitter(muni$LAT,.000001)
#sp_point[,1] <- muni$LON
#sp_point[,2] <- muni$LAT
colnames(sp_point) <- c("LON","LAT")

#muni <- read.dbf(gsub(".shp", ".dbf", muni_poly), header=TRUE)
#muni <- read.delim("opapp_admi_muni.csv", sep=",")

## Create spatial object
muni.sp <- SpatialPointsDataFrame(coords=sp_point,muni,proj4string=CRS(new_crs))
#par(mar=rep(0,4))
#plot(muni.sp,pch=1,cex=log(muni.sp$POVERTY_INCIDENCE))
muni.sp <- spTransform(muni.sp, CRS(new_crs))

#plot(muni.sp, axes=T, col="red")
#plot(brgy_poly, axes=T, col="red")
png(file=paste(prov_selected,"_POVINC_CENTROIDS.png"),width=2500,height=3000,res=400,pointsize=2)
plot(muni_poly)
points(muni.sp,pch=1,cex=200*muni.sp$POVERTY_INCIDENCE)
dev.off();

# Lagged H-Scatterplot
png(file=paste(prov_selected,"_POVINC_H-SCATTER.png"),width=3000,height=1500,res=400,pointsize=2)
hscat(muni.sp$POVERTY_INCIDENCE~1, muni.sp, c(0, 1, 10000, 10001))
dev.off();

#png(file=paste(prov_selected,"_VARIOGRAM.png"),width=2500,height=1500,res=400,pointsize=2)

## Variogram plot
v.obj<-variogram(POVERTY_INCIDENCE~1, locations=coordinates(sp_point), data=muni.sp, cloud=F)
png(file=paste(prov_selected,"_SEMIVARIOGRAM.png"),width=3000,height=2500,res=400,pointsize=2)
plot(v.obj,type='b',pch=16)
dev.off()

## Assuming spherical model
v.sph <- fit.variogram(v.obj,vgm(psill=1, model='Sph', range=10000))
png(file=paste(prov_selected,"_KRIGING_SPHERICAL.png"),width=3000,height=2500,res=400,pointsize=2)
plot(v.obj, v.sph, pch = 16,cex=.5,col="green")
dev.off()

## Assuming exponential model
v.exp <- fit.variogram(v.obj,vgm(psill=1, model='Exp', range=10000))
png(file=paste(prov_selected,"_KRIGING_EXPONENTIAL.png"),width=3000,height=2500,res=400,pointsize=2)
plot(v.obj, v.exp, pch = 16,cex=.5,col="red")
dev.off()


# Choose exponential
v.fin = v.exp

## Ordinary kriging 
grd <- Sobj_SpatialGrid(muni.sp)$SG
#plot(grd,axes=T,col="grey")
#plot(brgy_poly,axes=T,col="white",border="gray")
#points(muni.sp)
#dev.off()

#kr <- krige(POVERTY_INCIDENCE~1, muni.sp, grd, model=v.fin)
#spplot(kr,col.regions=rev(terrain.colors(100)),
#names.attr=c("Predictions","Variance"), main=paste(prov_selected,' - Kriging'), pch=2,cex=2)
#spplot(kr,col.regions=rev(terrain.colors(100)),
#names.attr=c("Predictions","Variance"), cuts=99, main=paste(prov_selected,' Kriging'), pch=2,cex=2)
#spplot(kr, "var1.pred", col.regions = rev(topo.colors(20)))
#names.attr=c("Predictions","Variance"), main=paste(prov_selected,' - Kriging'), pch=2,cex=2)

kr <- krige(POVERTY_INCIDENCE~1, muni.sp, newdata=brgy_poly, model=v.fin)
png(file=paste(prov_selected,"_POVINC_BRGY_krig.png"),width=2500,height=3000,res=400,pointsize=2)
spplot(kr, "var1.pred", col.regions = rev(heat.colors(100)), main=paste(prov_selected,' - Kriging'), pch=2,cex=2)
dev.off()
kr <- krige(POVERTY_INCIDENCE~1, muni.sp, grd, model=v.fin)
png(file=paste(prov_selected,"_POVINC_BRGY_krig-grid.png"),width=2500,height=3000,res=400,pointsize=2)
spplot(kr, "var1.pred", col.regions = rev(heat.colors(100)), main=paste(prov_selected,' - Kriging'), pch=2,cex=2)
dev.off()

brgy = brgy_poly@data
write.table(brgy,file="barangay.csv",sep=",",row.names=F)
write.table(kr,file="brgy_povinc_krig.csv",sep=",",row.names=F)

detach(package:gstat)
library(gstat)

## Generate predictions
# k=.2
#idw.out <- idw(POVERTY_INCIDENCE~1,muni.sp,newdata=brgy_poly,idp=.2)
#png(file=paste(prov_selected,"_POVINC_BRGY_IDW-k2.png"),width=2500,height=3000,res=400,pointsize=2)
#spplot(idw.out[1],col.regions=rev(heat.colors(100)), main=paste(prov_selected,' - IDW Interpolation'),sub="k = 1/5")
#dev.off()
#idw.out <- idw(POVERTY_INCIDENCE~1,muni.sp,grd,idp=.2)
#png(file=paste(prov_selected,"_POVINC_BRGY_IDW-k2-grid.png"),width=2500,height=3000,res=400,pointsize=2)
#spplot(idw.out[1],col.regions=rev(heat.colors(100)), main=paste(prov_selected,' - IDW Interpolation'),sub="k = 1/5")
#dev.off()
# k=1
#idw.out <- idw(POVERTY_INCIDENCE~1,muni.sp,newdata=brgy_poly,idp=1)
#png(file=paste(prov_selected,"_POVINC_BRGY_IDW-k1.png"),width=2500,height=3000,res=400,pointsize=2)
#spplot(idw.out[1],col.regions=rev(heat.colors(100)), main=paste(prov_selected,' - IDW Interpolation'),sub="k = 1")
#dev.off()
#idw.out <- idw(POVERTY_INCIDENCE~1,muni.sp,grd,idp=1)
#png(file=paste(prov_selected,"_POVINC_BRGY_IDW-k1-grid.png"),width=2500,height=3000,res=400,pointsize=2)
#spplot(idw.out[1],col.regions=rev(heat.colors(100)), main=paste(prov_selected,' - IDW Interpolation'),sub="k = 1")
#dev.off()
# k=5
#idw.out <- idw(POVERTY_INCIDENCE~1,muni.sp,newdata=brgy_poly,idp=5)
#png(file=paste(prov_selected,"_POVINC_BRGY_IDW-k5.png"),width=2500,height=3000,res=400,pointsize=2)
#spplot(idw.out[1],col.regions=rev(heat.colors(100)), main=paste(prov_selected,' - IDW Interpolation'),sub="k = 5")
#dev.off()
#idw.out <- idw(POVERTY_INCIDENCE~1,muni.sp,grd,idp=1)
#png(file=paste(prov_selected,"_POVINC_BRGY_IDW-k5-grid.png"),width=2500,height=3000,res=400,pointsize=2)
#spplot(idw.out[1],col.regions=rev(heat.colors(100)), main=paste(prov_selected,' - IDW Interpolation'),sub="k = 5")
#dev.off()

#r = raster(idw.out)
#zonal(r, brgy_poly, stat='mean') 
#zonal(r, muni, stat='mean') 