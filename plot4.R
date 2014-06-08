#install.packages("xlsx")
#install.packages("XML")
#install.packages("data.table")
library(psych)
library(xlsx)
library(XML)
library(data.table)

Sys.setlocale("LC_TIME", "English")
setwd("C:/Users/_C_DataScienceCertification/04_ExploratoryDataAnalysis/Project01")

file01 <- "household_power_consumption.txt"
rawData <- read.table(file01, header=TRUE, sep=";", na.strings="?")

# Convert the Date column into dates.
rawData$Date <- as.Date(rawData$Date, format="%d/%m/%Y")

# Subset the raw dataset according to the specified dates.
specDataset <- subset(rawData[,], Date == as.Date("2007-02-01") | Date == as.Date("2007-02-02"))

# Create a new column DateTime and combine the Date and Time colum.
specDataset$DateTime <- paste(specDataset$Date, specDataset$Time, sep=" ")
specDataset$DateTime <- strptime(specDataset$DateTime, format="%Y-%m-%d %H:%M:%S")


#--------------------------------------
# Plot 4
#--------------------------------------
png(filename="plot4.png", width=480, height=480, units="px", bg="transparent")

par(mfrow = c(2, 2))

# Top Left (Global Active Power)
with(specDataset, plot(DateTime, Global_active_power, type="l", xlab="", ylab="Global Active Power"))

# Top Right (Voltage)
with(specDataset, plot(DateTime, Voltage, type="l", xlab="datetime", ylab="Voltage"))

# Bottom Left (Sub Meterings 1 - 3
with(specDataset, plot(DateTime, Sub_metering_1, type="n", xlab="", ylab="Energy sub metering"))
lines(specDataset$DateTime, specDataset$Sub_metering_1, col="black")
lines(specDataset$DateTime, specDataset$Sub_metering_2, col="red")
lines(specDataset$DateTime, specDataset$Sub_metering_3, col="blue")
legend("topright", c( "Sub_metering_1", "Sub_metering_2", "Sub_metering_3" ), bty="n", lty="solid", lwd=c(1,1,1), col = c("black","red","blue"))

# Bottom Right (Global Reactive Power)
with(specDataset, plot(DateTime, Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power"))

dev.off()
