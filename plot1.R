setwd("C://Users//matr06609//Documents//R Data")

##Download and clean data##
if (!file.exists("data.zip")) {
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                destfile="data.zip")
  unzip("data.zip")
}

data <- read.csv("household_power_consumption.txt",
                 skip=66637,
                 nrows=2880,
                 na.strings = "?",
                 header=F,
                 sep=";")

names(data) <- names(read.csv("household_power_consumption.txt", nrows=1, sep=";"))
data$DateTime <- as.POSIXct(paste(data$Date, data$Time, sep=" "),
                            format="%d/%m/%Y %H:%M:%S")
data$Time <- strptime(data$Time, format="%H:%M:%S")
gap <- data$Global_active_power
date <- data$DateTime

##Plot 1##
par(mfrow=c(1,1))
hist(gap, col="red", main= "Global Active Power", xlab= "Global Active Power (kilowatts)", ylab= "Frequency")

dev.copy(png,file="plot1.png", width=480, height=480)

dev.off()
