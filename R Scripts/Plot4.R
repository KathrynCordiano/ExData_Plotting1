setwd("C:\\Users\\matr06580\\Data Science Course Notes\\Course 4 - Exploratory Data Analysis\\Projects\\Week 1 Project")
if(!file.exists("data.txt")){
  download.file(url="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                destfile = "data.txt")
  unzip("data.txt")
}

data <- read.csv("data.txt",
                 skip=66637,
                 nrows=2880,
                 na.strings="?",
                 header=F,
                 sep=";")
names(data) <- names(read.csv("data.txt", nrows=1,sep=";"))
data$DateTime <- as.POSIXct(paste(data$Date, data$Time, sep = " "),
                            format = "%d/%m/%Y %H:%M:%S")
data$Date <- as.Date(data$Date, format="%d/%m/%y")
data$Time <- strptime(data$Time, format="%H:%M:%S")

par(mfrow = c(2,2))
with(data, {
  plot(data$DateTime, data$Global_active_power, type="l", xlab = "", ylab = "Global Active Power")
  plot(data$DateTime, data$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")
  plot(data$DateTime, data$Sub_metering_1, col = "Black", type = "l", xlab = "", ylab = "Energy sub metering")
  lines(data$DateTime, data$Sub_metering_2, col = "Red")
  lines(data$DateTime, data$Sub_metering_3, col = "Blue")
  legend("topright", lty = 1, bty = "n", col=c("Black", "Red", "Blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(data$DateTime, data$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")
})

dev.copy(png, file = "plot4.png", width = 480, height = 480)
dev.off