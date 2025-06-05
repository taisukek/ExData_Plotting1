# plot3.R

# --- 1. Data Loading and Preprocessing ---

data <- read.table(
  "/Users/taisukek/Downloads/household_power_consumption.txt",
  header = TRUE,
  sep = ";",
  na.strings = "?",
  stringsAsFactors = FALSE
)

data_subset <- data[data$Date %in% c("1/2/2007", "2/2/2007"), ]

datetime <- strptime(paste(data_subset$Date, data_subset$Time, sep=" "), "%d/%m/%Y %H:%M:%S")

subMetering1 <- as.numeric(data_subset$Sub_metering_1)
subMetering2 <- as.numeric(data_subset$Sub_metering_2)
subMetering3 <- as.numeric(data_subset$Sub_metering_3)


# --- 2. Generate and Save Plot ---

png("plot3.png", width = 480, height = 480)

plot(
  datetime,
  subMetering1,
  type = "l",
  col = "black",
  xlab = "",
  ylab = "Energy sub metering",
  xaxt = "n"
)

lines(datetime, subMetering2, type = "l", col = "red")
lines(datetime, subMetering3, type = "l", col = "blue")

legend(
  "topright",
  legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
  col = c("black", "red", "blue"),
  lty = 1
)

tick_positions <- c(as.POSIXct("2007-02-01"), as.POSIXct("2007-02-02"), as.POSIXct("2007-02-03"))
tick_labels <- format(tick_positions, "%a")
axis.POSIXct(1, at = tick_positions, labels = tick_labels)

dev.off()