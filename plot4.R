# Downloading file
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "household_power_consumption.zip", method = "curl")

#Unzip
unzip("household_power_consumption.zip")
#Reading data from unzipped file
power.consumption <- read.table("household_power_consumption.txt", sep = ";",stringsAsFactors = FALSE, header = TRUE)
#Combining Date and Time
power.consumption$datetime <- paste(power.consumption$Date, power.consumption$Time)
#Converting to datetime 
power.consumption$datetime <- strptime(power.consumption$datetime, format = "%d/%m/%Y %H:%M:%S")
#Limiting to the two specified days
tWo.days <- power.consumption[which(power.consumption$datetime >= "2007-02-01" & power.consumption$datetime < "2007-02-03" ), ]
#Converting to numeric 
tWo.days[, cols <- names(tWo.days)[3:9]] <- lapply(tWo.days[, cols <- names(tWo.days)[3:9]], FUN = function(x) {  as.numeric(x, origin = "1970-01-01") })

#Plot 4
png(file = "plot4.png")

#setting to 4 plot device
par(mfrow = c(2,2))

plot(tWo.days$datetime ,tWo.days$Global_active_power,ylab = "Global Active Power (kilowatts)", xlab = "", type = "n" )
lines(tWo.days$datetime ,tWo.days$Global_active_power )

plot(tWo.days$datetime ,tWo.days$Voltage,ylab = "Voltage", xlab = "datetime", type = "n" )
lines(tWo.days$datetime ,tWo.days$Voltage )

plot(tWo.days$datetime ,tWo.days$Sub_metering_1,ylab = "Energy sub metering", xlab = "", type = "n" )
lines(tWo.days$datetime ,tWo.days$Sub_metering_1, col = "black" )
lines(tWo.days$datetime ,tWo.days$Sub_metering_2, col = "red" )
lines(tWo.days$datetime ,tWo.days$Sub_metering_3, col = "blue" )
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty = c(1,1,1), col = c("black", "red", "blue"), bty = "n", cex=0.95)

plot(tWo.days$datetime ,tWo.days$Global_reactive_power,ylab = "Global_reactive_power", xlab = "datetime", type = "n" )
lines(tWo.days$datetime ,tWo.days$Global_reactive_power )
dev.off()