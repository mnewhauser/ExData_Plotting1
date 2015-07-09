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

##Plot 4##
par(mfrow= c(2,2))
with(data, {
  plot(date, gap, type= "l", ylab= "Global Active Power", xlab=" ")
  plot(date, data$Voltage, type= "l", xlab="datetime", ylab="Voltage")
  plot(date, sm1, type="l", ylab= "Energy sub metering")
  lines(date, sm2, type="l", ylab= "Energy sub metering", col="red")
  lines(date, sm3, type="l", ylab= "Energy sub metering", col="blue")
  legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, 
         col=c("black","red", "blue"), bty="n")
  plot(date, data$Global_reactive_power, type="l", xlab= "datetime", ylab= "Global_reactive_power")
})

##Save as png##
dev.copy(png,file="plot4.png", width=480, height=480)
dev.off()
