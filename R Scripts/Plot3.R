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

plot(data$DateTime, data$Sub_metering_1, col = "Black", type = "l", xlab = "", ylab = "Energy sub metering")
lines(data$DateTime, data$Sub_metering_2, col = "Red")
lines(data$DateTime, data$Sub_metering_3, col = "Blue")
legend("topright", lty = 1, col=c("Black", "Red", "Blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.copy(png, file = "plot3.png", width = 480, height = 480)
dev.off