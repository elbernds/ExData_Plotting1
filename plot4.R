## Read from data file
library(sqldf)
fileToRead <- "household_power_consumption.txt"
queryString <- "SELECT * FROM file WHERE Date=='1/2/2007' OR Date=='2/2/2007'"
hpcDf <- read.csv.sql(file = fileToRead, sql = queryString, header = TRUE, sep = ";")
hpcDf[hpcDf =="?"] <- 0

## Combine date and time variables to form a datetime class variable
hpcDf$Date <- paste(hpcDf$Date, hpcDf$Time)
hpcDf$Time <- NULL
library(lubridate)
hpcDf$Date <- parse_date_time(hpcDf$Date,"dmYHMS")

## Plot4
png(file="plot4.png",width=480,height=480)
par(mfcol = c(2,2), mar = c(5, 5, 4, 2))
## Graph 1
with(hpcDf, plot(Date, Global_active_power, type = "l",
                 xlab = "", ylab = "Gobal Active Power"))
## Graph 2
with(hpcDf, plot(Date, Sub_metering_1, type = "l",
                 xlab = "", ylab = "Energy sub metering"))
with(hpcDf, points(Date, Sub_metering_2, col = "red", type = "l"))
with(hpcDf, points(Date, Sub_metering_3, col = "blue", type = "l"))
legend("topright", pch = c(NA, NA, NA), lwd = 1, lty = 1,
       col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       merge=FALSE,
       bty="n",
       cex = 0.9)
## Graph 3
with(hpcDf, plot(Date, Voltage, type = "l",
                 xlab = "datetime", ylab = "Voltage"))
## Graph 4
with(hpcDf, plot(Date, Global_reactive_power, type = "l",
                 xlab = "datetime", ylab = "Global_reactive_power"))
dev.off()