## Load libraries
library(lubridate)
library(chron)
library(dplyr)
library(sqldf)

## Read file
electric <-read.table("household_power_consumption.txt", header=TRUE, sep=";", 
                      na.strings="?")

## subset to get date ranges we want
selecteddat <-subset(electric, Date == "1/2/2007" | Date == "2/2/2007")

## Get date_time variable and weekday
selecteddat$datetime <- strptime(paste(selecteddat$Date,selecteddat$Time), "%d/%m/%Y %H:%M:%S")

## Create plot 3
with(selecteddat,{
        labelnames <- colnames(selecteddat)[7:9]
        plot(datetime,Sub_metering_1,ylab="Energy sub metering",type="l",xaxt="n",xlab="")
        r <- as.POSIXct(round(range(datetime),"days"))
        axis.POSIXct(1, at=seq(r[1],r[2],by="days"),format="%a")
        lines(datetime,Sub_metering_2,col="red")
        lines(datetime,Sub_metering_3,col="blue")
        legend("topright",col=c("black","red","blue"),lty=c(1,1,1), legend=labelnames)
})

## Export plot to PNG size 480x480
dev.copy(png,file="plot3.png")
dev.off()
