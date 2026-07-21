## Plot 4: Four-panel household power consumption plot

file_path <- "household_power_consumption.txt"

if (!file.exists(file_path)) {
  stop("household_power_consumption.txt was not found in the working directory.")
}

## Read the complete dataset
power <- read.table(
  file_path,
  header = TRUE,
  sep = ";",
  na.strings = "?",
  stringsAsFactors = FALSE,
  colClasses = c(
    "character",
    "character",
    rep("numeric", 7)
  )
)

## Keep only February 1 and February 2, 2007
power <- power[
  power$Date %in% c("1/2/2007", "2/2/2007"),
]

## Combine Date and Time into one datetime variable
power$datetime <- as.POSIXct(
  paste(power$Date, power$Time),
  format = "%d/%m/%Y %H:%M:%S"
)

## Open PNG graphics device
png(
  filename = "plot4.png",
  width = 480,
  height = 480
)

## Arrange plots in two rows and two columns
par(mfrow = c(2, 2))

## Top-left: Global active power
plot(
  power$datetime,
  power$Global_active_power,
  type = "l",
  xlab = "",
  ylab = "Global Active Power"
)

## Top-right: Voltage
plot(
  power$datetime,
  power$Voltage,
  type = "l",
  xlab = "datetime",
  ylab = "Voltage"
)

## Bottom-left: Energy sub-metering
plot(
  power$datetime,
  power$Sub_metering_1,
  type = "l",
  xlab = "",
  ylab = "Energy sub metering"
)

lines(
  power$datetime,
  power$Sub_metering_2,
  col = "red"
)

lines(
  power$datetime,
  power$Sub_metering_3,
  col = "blue"
)

legend(
  "topright",
  legend = c(
    "Sub_metering_1",
    "Sub_metering_2",
    "Sub_metering_3"
  ),
  col = c("black", "red", "blue"),
  lty = 1,
  bty = "n",
  cex = 0.8
)

## Bottom-right: Global reactive power
plot(
  power$datetime,
  power$Global_reactive_power,
  type = "l",
  xlab = "datetime",
  ylab = "Global_reactive_power"
)

## Close the graphics device
dev.off()