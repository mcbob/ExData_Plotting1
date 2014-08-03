data <- read.csv("../household_power_consumption.txt", skip = 66637,
                 nrows = 69517 - 66638, sep =";", as.is = TRUE,
                 col.names = c("Date", "Time", "Global_active_power",
                "Global_reactive_power", "Voltage", "Global_intensity", 
                "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
                na.strings = "?")
data$Date <- strptime(paste(data[,1], data[,2]), format = "%d/%m/%Y %H:%M:%S")
data <- data[-2]

sysloc <- Sys.getlocale("LC_TIME")
Sys.setlocale("LC_TIME","en_US.UTF-8")

png(filename = "plot4.png", width = 480, height = 480, units = "px")
par(mfcol = c(2, 2))
# Plot 1
with(data, {
    plot(Date, Global_active_power, type = "n", xlab = "",
         ylab = "Global Active Power")
    lines(Date, Global_active_power)
})

# Plot 2
with(data, {
    plot(Date, Sub_metering_1, type = "n", xlab = "",
         ylab = "Energy sub metering")
    lines(Date, Sub_metering_1)
    lines(Date, Sub_metering_2, col = "red")
    lines(Date, Sub_metering_3, col = "blue")
    })
legend("topright", col = c("black", "red", "blue"), lty = 1, lwd = 1, bty = "n",
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Plot 3
with(data, plot(Date, Voltage, type = "l", xlab = "datetime"))

# Plot 4
with(data, plot(Date, Global_reactive_power, type = "l", xlab = "datetime"))

dev.off()
Sys.setlocale("LC_TIME", sysloc)