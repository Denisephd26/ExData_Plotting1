## Load libraries
library(dplyr)

## Read file
electric <-read.table("household_power_consumption.txt", header=TRUE, sep=";", 
                      na.strings="?")

## subset to get date ranges we want
selecteddat <-subset(electric, Date == "1/2/2007" | Date == "2/2/2007")

## Get date_time variable and weekday
selecteddat$datetime <- strptime(paste(selecteddat$Date,selecteddat$Time), "%d/%m/%Y %H:%M:%S")

## Create plot 2
with(selecteddat,{
        plot(datetime,Global_active_power,ylab="Global Active Power (kilowatts)",type="l",xaxt="n",xlab="")
        r <- as.POSIXct(round(range(datetime),"days"))
        axis.POSIXct(1, at=seq(r[1],r[2],by="days"),format="%a")
})

## Export plot to PNG size 480x480
dev.copy(png,file="plot2.png")
dev.off()
