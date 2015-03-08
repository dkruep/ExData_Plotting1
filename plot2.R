#plot2
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

#plot2
#format plot data
edf$Global_active_power_numeric <- as.numeric(edf$Global_active_power)

plot(edf$DateTime, edf$Global_active_power_numeric, type='l', ylab="Global Active Power (kilowatts)", xlab="", yaxt="n")

#set axis labels
axis(side=2, at=c(0,2,4,6))
     
#print plot out to png
dev.copy(png, file='plot2.png', width=480, height=480)
dev.off()