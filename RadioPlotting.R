############################
# RadioPlot.R
# Project: RadioTelemetryTimePlots.Rproj

# File description: Plot km location against time of detection

# Created: January 11, 2016
# R Version: 3.2.0
# GitHub: Yes
# Author: A Putt
############################

# Things to watch for:
# Make sure that the dates are all coming in ok, it was giving me problems
# Also watch for strange factors in the kmblock column. Because it is a number excel sometimes converts it to weird dates and such

source("RadioUpload.R")

# Create a function to plot one code

oneplotfunc <- function(radiodata,code) {   
  onecode <- subset(allradio,Code==code)
  onecode <- onecode[ order(onecode$posixdate),]
  par(oma=c(0,0,0,0))
  plot(onecode$posixdate,onecode$kmlabel,type="n",xlab="",ylab="",yaxt="n",ylim=c(0,5),cex=2,
       xlim=c(as.POSIXct(mindate),as.POSIXct(maxdate)),xaxt="n")
  axis(side=2,at=c(0,1,2,3,4,4.7),labels=c("0-10","10-20","20-30","30-40","40-47","47+"),las=1)
  axis.POSIXct(side=1,at=as.POSIXct(onecode$posixdate),labels=FALSE)
  text(x=as.POSIXct(onecode$posixdate),y=-0.5,labels=format(onecode$posixdate,format="%d-%b-%y"),srt=45,adj=1,xpd=TRUE)
  abline(h=0,lty=2,col="grey")
  abline(h=1,lty=2,col="grey")
  abline(h=2,lty=2,col="grey")
  abline(h=3,lty=2,col="grey")
  abline(h=4,lty=2,col="grey")
  abline(h=4.7,lty=2,col="grey")
  points(onecode$posixdate,onecode$kmlabel,pch=19,xlab="",ylab="",yaxt="n",type="b",ylim=c(0,5),cex=1.2)
  mtext(text=sprintf("Code: %s",onecode$Code[1]),side=3,adj=0)
}

# Determine the min and max dates that you want all plots to follow
mindate <- allradio$posixdate[order(allradio$posixdate)][1]
maxdate <- allradio$posixdate[order(allradio$posixdate)][nrow(allradio)]

# Find the codes to loop through
codes <- sort(unique(allradio$Code))

# Create all of the plots
for (i in 1:length(codes)) {
  windows()
  code <- codes[i]
  oneplotfunc(allradio,code)
}
