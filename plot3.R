load_data <- function(path) {
    classes<- c(rep("character", 2),rep("numeric", 7))
    selected_dates = c("1/2/2007", "2/2/2007")
    data <- read.table(path, header=TRUE, sep=";", na.strings = c("?",""), colClasses=classes)
    data <- subset(data, Date %in% selected_dates)
    data[, "Date"] <- as.Date(data[, "Date"], format = "%d/%m/%Y")
    data[, "datetime"] = paste(data[, "Date"], data[, "Time"])
    data$Time <- strptime(data$datetime, format = "%Y-%m-%d %H:%M:%S")
    data
}

data <- load_data("household_power_consumption.txt")
png(filename = "plot3.png", width = 480, height = 480)

with(data, {
    plot(Time, Sub_metering_1, 
         xlab = "",
         ylab = "Energy sub metering",
         type = "n"
    )
    
    lines(Time, Sub_metering_1, 
          xlab = "", 
          col = "black")
    
    lines(Time, Sub_metering_2, 
          xlab = "", 
          col = "red")
    lines(Time, Sub_metering_3, 
          xlab = "", 
          col = "blue")
    
    }
)

legend("topright", 
       pch = "_",
       col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))


    
dev.off()