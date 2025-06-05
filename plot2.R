# plot2.R

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

globalActivePower <- as.numeric(data_subset$Global_active_power)


# --- 2. Generate and Save Plot ---

png("plot2.png", width = 480, height = 480)

plot(
  datetime,
  globalActivePower,
  type = "l",
  xlab = "",
  ylab = "Global Active Power (kilowatts)",
  xaxt = "n"
)

tick_positions <- c(as.POSIXct("2007-02-01"), as.POSIXct("2007-02-02"), as.POSIXct("2007-02-03"))
tick_labels <- format(tick_positions, "%a")
axis.POSIXct(1, at = tick_positions, labels = tick_labels)

dev.off()