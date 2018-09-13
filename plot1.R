# this script will create plot1.png
setwd("~/Documents/datascience/eda/ExData_Plotting1")

url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zipFile <- "household_power_consumption.zip"
fileName <- "household_power_consumption.txt"
pngFile <- "plot1.png"

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
hist(filtered$Global_active_power, col = "red", main = "Global Active Power", 
                            xlab = "Global Active Power (kilowatts)")

# save png file
dev.off()