## Load libraries
library(dplyr)

## Read file
electric <-read.table("household_power_consumption.txt", header=TRUE, sep=";", 
                      na.strings="?")

## subset to get date ranges we want
selecteddat <-subset(electric, Date == "1/2/2007" | Date == "2/2/2007")

## Get date_time variable and weekday
selecteddat$datetime <- strptime(paste(selecteddat$Date,selecteddat$Time), "%d/%m/%Y %H:%M:%S")


r <- as.POSIXct(round(range(selecteddat$datetime),"days"))
png("plot4.png")
par(mfcol=c(2,2))
with(selecteddat,{
        ## Create plot upper left
        plot(datetime,Global_active_power,ylab="Global Active Power",type="l",xaxt="n",xlab="")
        axis.POSIXct(1, at=seq(r[1],r[2],by="days"),format="%a")
        ## Create plot lower left 
        labelnames <- c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
        plot(datetime,Sub_metering_1,ylab="Energy sub metering",type="l",xaxt="n",xlab="")
        axis.POSIXct(1, at=seq(r[1],r[2],by="days"),format="%a")
        lines(datetime,Sub_metering_2,col="red")
        lines(datetime,Sub_metering_3,col="blue")
        legend("topright", legend=labelnames,col=c("black","red","blue"),
               lty=rep(1,3), bty = "n")
        ## Create plot upper right
        plot(datetime,Voltage, type="l",xaxt="n")
        axis.POSIXct(1, at=seq(r[1],r[2],by="days"),format="%a")
        ## Create plot lower right
        plot(datetime,Global_reactive_power, type="l",xaxt="n")
        axis.POSIXct(1, at=seq(r[1],r[2],by="days"),format="%a")
})

## Export plot to PNG size 480x480
dev.off()
