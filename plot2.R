## Plot 2: Global Active Power over time

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
  filename = "plot2.png",
  width = 480,
  height = 480
)

## Construct the line plot
plot(
  power$datetime,
  power$Global_active_power,
  type = "l",
  xlab = "",
  ylab = "Global Active Power (kilowatts)"
)

## Close the graphics device
dev.off()