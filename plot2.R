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

## Plot2
png(file="plot2.png",width=480,height=480)
with(hpcDf, plot(Date, Global_active_power, type = "l",
                 xlab = "", ylab = "Gobal Active Power (kilowatts)"))
dev.off()