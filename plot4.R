# this script will create plot4.png
setwd("~/Documents/datascience/eda/ExData_Plotting1")

url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zipFile <- "household_power_consumption.zip"
fileName <- "household_power_consumption.txt"
pngFile <- "plot4.png"

# download and extract the household file
if (!file.exists(zipFile)) {
    download.file(url, zipFile, method = "curl")
    unzip(zipFile, exdir = "./")
}

# load the data
hhpc <- read.table(fileName, header=T, sep=";", na.strings="?")
hhpc$DateTime<-paste(hhpc$Date, hhpc$Time)
hhpc$DateTime<-strptime(hhpc$DateTime, "%d/%m/%Y %H:%M:%S")

# filter by dates
filtered <- subset(hhpc, hhpc$DateTime >= strptime("2007-02-01", "%Y-%m-%d") & hhpc$DateTime < strptime("2007-02-03", "%Y-%m-%d"))
rm(hhpc)

# open png device
png(filename = pngFile, width = 480, height = 480)

# plot
par(mfrow=c(2,2))

# do plot2
plot(filtered$DateTime, filtered$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

# do the date time / voltage
plot(filtered$DateTime, filtered$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")

# do plot 3
plot(filtered$DateTime, filtered$Sub_metering_1, type="l", col = "black", xlab="", ylab="Energy sub metering")
lines(filtered$DateTime, filtered$Sub_metering_2, col = "red")
lines(filtered$DateTime, filtered$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"), lty="solid")

# do the datetime / global re-active power
plot(filtered$DateTime, filtered$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global Reactive Power")

# save png file
dev.off()