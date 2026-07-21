## Plot 3: Energy sub-metering over time

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
  filename = "plot3.png",
  width = 480,
  height = 480
)

## Plot the first sub-metering variable
plot(
  power$datetime,
  power$Sub_metering_1,
  type = "l",
  xlab = "",
  ylab = "Energy sub metering"
)

## Add the other two sub-metering variables
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

## Add the legend
legend(
  "topright",
  legend = c(
    "Sub_metering_1",
    "Sub_metering_2",
    "Sub_metering_3"
  ),
  col = c("black", "red", "blue"),
  lty = 1
)

## Close the graphics device
dev.off()