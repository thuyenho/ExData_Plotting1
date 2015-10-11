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
png(filename = "plot1.png", width = 480, height = 480)
hist(data$Global_active_power, 
     main="Global Active Power", 
     col = 'red',
     xlab = "Global Active Power (kilowatts)")

dev.off()