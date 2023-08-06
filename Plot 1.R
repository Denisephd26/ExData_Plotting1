## Read file
electric <-read.table("household_power_consumption.txt", header=TRUE, sep=";", 
                      na.strings="?")

## subset to get date ranges we want
selecteddat <-subset(electric, Date == "1/2/2007" | Date == "2/2/2007")

## Create plot
hist(selecteddat$Global_active_power,main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", col="red")

## Export plot to PNG size 480x480
dev.copy(png,file="plot1.png")
dev.off()
