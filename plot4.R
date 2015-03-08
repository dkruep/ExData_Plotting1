#plot3
# unzip the file
sourceFile <- "exdata-data-household_power_consumption.zip" 
zipfileinfo <- unzip(sourceFile,list=TRUE)
unzip(sourceFile,exdir="hpwr")
#set file name
elecDataFileName <- './hpwr/household_power_consumption.txt'
#read entire set of data into data table
elecdf <- read.table(elecDataFileName, na.strings="?", sep=";", colClasses="character", header=TRUE, stringsAsFactors=FALSE)
#select only the 2 target dates of data
edf <- data.frame(elecdf[which(elecdf$Date=='1/2/2007' | elecdf$Date=='2/2/2007'),])
#convert date column to Date column
edf$Date <- as.Date(edf$Date,format="%m/%d/%Y")  

#concatenate the Date and Time fields
datetimes <- paste(edf$Date, edf$Time, sep=" ") 
edf$DateTime <- datetimes
#convert time to time value
datetimeformats <- strptime(edf$DateTime,format="%d/%m/%Y %H:%M:%S")
edf$DateTime <- datetimeformats

#plot 4
#format plot data
edf$Global_active_power_numeric <- as.numeric(edf$Global_active_power)
edf$Sub_metering_1_numeric <- as.numeric(edf$Sub_metering_1)
edf$Sub_metering_2_numeric <- as.numeric(edf$Sub_metering_2)
edf$Sub_metering_3_numeric <- as.numeric(edf$Sub_metering_3)
edf$Voltage_numeric <- as.numeric(edf$Voltage)
edf$Global_reactive_power_numeric <- as.numeric(edf$Global_reactive_power)



#plot4a (upper left)
plot(edf$DateTime, edf$Global_active_power_numeric, type='l', ylab="Global Active Power", xlab="", yaxt="n")
#set axis labels
axis(side=2, at=c(0,2,4,6))

#plot4b (lower left)
plot(edf$DateTime, edf$Sub_metering_1_numeric, type='l', ylab="Energy sub metering", xlab="", yaxt="n")
points(edf$DateTime, edf$Sub_metering_2_numeric, col="red", type='l')
points(edf$DateTime, edf$Sub_metering_3_numeric, col="blue", type='l')
#add legend
legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black","red","blue"), lty=1, bty="n")
#set axis labels
axis(side=2, at=c(0,10,20,30))

#plot4c (upper right)
plot(edf$DateTime, edf$Voltage_numeric, type='l', ylab="Voltage", xlab="datetime")


#plot4d (lower right)
plot(edf$DateTime, edf$Global_reactive_power_numeric, type='l', ylab="Global_reactive_power", xlab="datetime")


#set 2 by 2 grid of plots with progression by column, not row
par(mfcol=c(2,2), mar=c(4,4,2,2))


#plot it
dev.copy(png, file='plot4.png', width=480, height=480)
dev.off()
