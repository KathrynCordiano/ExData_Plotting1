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

hist(data$Global_active_power, xlab = "Global Active Power", ylab = "Frequency", col = "red", main = "Global Active Power")

dev.copy(png, file = "plot1.png", width = 480, height = 480)
dev.off