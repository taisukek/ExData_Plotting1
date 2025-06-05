# plot4.R

# --- 1. Data Loading and Preprocessing ---

# Read the full dataset
data <- read.table(
  "/Users/taisukek/Downloads/household_power_consumption.txt",
  header = TRUE,
  sep = ";",
  na.strings = "?",
  stringsAsFactors = FALSE
)

# Subset the data for the specified dates
data_subset <- data[data$Date %in% c("1/2/2007", "2/2/2007"), ]

# Create a proper datetime object
datetime <- strptime(paste(data_subset$Date, data_subset$Time, sep=" "), "%d/%m/%Y %H:%M:%S")

# Convert relevant columns to numeric
globalActivePower <- as.numeric(data_subset$Global_active_power)
globalReactivePower <- as.numeric(data_subset$Global_reactive_power)
voltage <- as.numeric(data_subset$Voltage)
subMetering1 <- as.numeric(data_subset$Sub_metering_1)
subMetering2 <- as.numeric(data_subset$Sub_metering_2)
subMetering3 <- as.numeric(data_subset$Sub_metering_3)


# --- 2. Generate and Save Plot ---

# Open the PNG device
png("plot4.png", width = 480, height = 480)

# Set up the 2x2 plot layout
par(mfrow = c(2, 2))

# Define tick positions and labels once to be reused
tick_positions <- c(as.POSIXct("2007-02-01"), as.POSIXct("2007-02-02"), as.POSIXct("2007-02-03"))
tick_labels <- format(tick_positions, "%a")

# --- Plot 1: Global Active Power (top-left) ---
plot(datetime, globalActivePower, type = "l", xlab = "", ylab = "Global Active Power", xaxt = "n")
axis.POSIXct(1, at = tick_positions, labels = tick_labels)

# --- Plot 2: Voltage (top-right) ---
plot(datetime, voltage, type = "l", xlab = "datetime", ylab = "Voltage", xaxt = "n")
axis.POSIXct(1, at = tick_positions, labels = tick_labels)

# --- Plot 3: Energy Sub-metering (bottom-left) ---
plot(datetime, subMetering1, type = "l", col = "black", xlab = "", ylab = "Energy sub metering", xaxt = "n")
lines(datetime, subMetering2, type = "l", col = "red")
lines(datetime, subMetering3, type = "l", col = "blue")
legend(
    "topright",
    bty = "n", # Remove legend box to match the image
    lty = 1,
    col = c("black", "red", "blue"),
    legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
)
axis.POSIXct(1, at = tick_positions, labels = tick_labels)

# --- Plot 4: Global Reactive Power (bottom-right) ---
plot(datetime, globalReactivePower, type = "l", xlab = "datetime", ylab = "Global_reactive_power", xaxt = "n")
axis.POSIXct(1, at = tick_positions, labels = tick_labels)

# Close the PNG device
dev.off()