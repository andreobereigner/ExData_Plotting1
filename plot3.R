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
# Plot 3
#--------------------------------------
png(filename="plot3.png", width=480, height=480, units="px", bg="transparent")

with(specDataset, plot(DateTime, Sub_metering_1, type="n", xlab="", ylab="Energy sub metering"))
lines(specDataset$DateTime, specDataset$Sub_metering_1, col="black")
lines(specDataset$DateTime, specDataset$Sub_metering_2, col="red")
lines(specDataset$DateTime, specDataset$Sub_metering_3, col="blue")
legend("topright", c( "Sub_metering_1", "Sub_metering_2", "Sub_metering_3" ), lty="solid", lwd=c(1,1,1), col = c("black","red","blue"))

dev.off()

