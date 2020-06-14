## Read from data file
library(sqldf)
fileToRead <- "household_power_consumption.txt"
queryString <- "SELECT * FROM file WHERE Date=='1/2/2007' OR Date=='2/2/2007'"
hpcDf <- read.csv.sql(file = fileToRead, sql = queryString, header = TRUE, sep = ";")
hpcDf[hpcDf =="?"] <- 0

## Plot1
png(file="plot1.png",width=480,height=480)
hist(hpcDf$Global_active_power,
     col = "red",
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)")
dev.off()