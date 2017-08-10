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

## Construct plot 2
plot(dataf$DateTime, dataf$Global_active_power, type="l",
     ylab="Global Active Power(kilowwatts)", xlab="")
dev.copy(png, file="plot2.png",width=480,height=480)
dev.off()