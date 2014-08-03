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
png(filename = "plot2.png", width = 480, height = 480, units = "px")
with(data, {
    plot(Date, Global_active_power, type = "n", xlab = "",
         ylab = "Global Active Power (kilowatts)")
    lines(Date, Global_active_power)
    })
dev.off()
Sys.setlocale("LC_TIME", sysloc)