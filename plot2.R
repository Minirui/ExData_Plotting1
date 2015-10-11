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
#setting to singel plot device
par(mfrow = c(1,1))
#Plot 2
png(file = "plot2.png")
plot(tWo.days$datetime ,tWo.days$Global_active_power,ylab = "Global Active Power (kilowatts)", xlab = "", type = "n" )
lines(tWo.days$datetime ,tWo.days$Global_active_power )
dev.off()