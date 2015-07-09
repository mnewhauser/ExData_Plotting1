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

##Plot 3##
sm1 <- data$Sub_metering_1
sm2 <- data$Sub_metering_2
sm3 <- data$Sub_metering_3

par(mfrow=c(1,1))
plot3 <- plot(date, sm1, type="l", ylab= "Energy sub metering")
plot3 <- lines(date, sm2, type="l", ylab= "Energy sub metering", col="red")
plot3 <- lines(date, sm3, type="l", ylab= "Energy sub metering", col="blue")
plot3 <- legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, 
                col=c("black","red", "blue"))

##Save as png##
dev.copy(png,file="plot3.png", width=480, height=480)
dev.off()
