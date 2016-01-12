############################
# RadioUpload.R
# Project: RadioTelemetryTimePlots.Rproj

# File description: Upload radio telemetry data to create time plots

# Created: January 11, 2016
# R Version: 3.2.0
# GitHub: Yes
# Author: A Putt
############################

allradio <- read.csv("RadioTrackingUpload.csv",head=TRUE,colClasses=c(Date="character",kmblock="factor"))
allradio$posixdate <- as.POSIXlt(allradio$Date,format="%d-%b-%y")
allradio$dayofyear <- allradio$posixdate$yday
allradio$year      <- format(allradio$posixdate,format="%Y")
allradio$month     <- format(allradio$posixdate,format="%m")

# Get rid of NA rows 
allradio <- subset(allradio,Code != "NA")

# Determine the number of codes in 2014 and 2015
n2014 <- length(unique(subset(allradio,year==2014)$Code))
n2015 <- length(unique(subset(allradio,year==2015)$Code))

# Add km category column for plotting
allradio$kmlabel <- allradio$kmblock

library(plyr)
allradio$kmlabel <- revalue(allradio$kmlabel,c("0-10"=0,"10-20"=1,"20-30"=2,"30-40"=3,"40-47"=4,"47+"=4.7))
allradio$kmlabel <- as.numeric(levels(allradio$kmlabel)[allradio$kmlabel])
