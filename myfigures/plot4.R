library(data.table)
library(dplyr)
library(lubridate)

## Download and unzip dataset
if(!file.exists("./data")){dir.create("./data")}
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, destfile="./data/electric_power_consumption.zip", mode="wb")
unzip("./data/electric_power_consumption.zip", exdir="./data")

## Read and extract relevant information
data <- tbl_df(read.table("./data/household_power_consumption.txt", 
                          sep = ";",
                          stringsAsFactors = FALSE,
                          na.strings = "?",
                          header = TRUE)
)
dataf <- filter(data, Date=="1/2/2007" | Date=="2/2/2007")
dataf$DateTime <- dmy(dataf$Date) + hms(dataf$Time)

## Construct plot 3
par(mfcol=c(2,2), mar=c(4,4,2,1))
plot(dataf$DateTime, dataf$Global_active_power, type="l",
     ylab="Global Active Power", xlab="")
plot(dataf$DateTime, dataf$Sub_metering_1, type="n",
     ylab="Energy sub metering", xlab="")
lines(x=dataf$DateTime, y=dataf$Sub_metering_1)
lines(x=dataf$DateTime, y=dataf$Sub_metering_2, col="red")
lines(x=dataf$DateTime, y=dataf$Sub_metering_3, col="blue")
legend("topright", lty=1, col=c("black","red","blue"), 
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),cex=0.65)
plot(dataf$DateTime, dataf$Voltage, type="l",
        ylab="Voltage", xlab="datetime")
plot(dataf$DateTime, dataf$Global_reactive_power, type="l",
     ylab="Gobal_reactive_power", xlab="datetime")
dev.copy(png, file="plot4.png",width=480,height=480)
dev.off()