# plot1.R

# --- 1. Data Loading and Preprocessing ---

data <- read.table(
  "/Users/taisukek/Downloads/household_power_consumption.txt",
  header = TRUE,
  sep = ";",
  na.strings = "?",
  stringsAsFactors = FALSE
)

data_subset <- data[data$Date %in% c("1/2/2007", "2/2/2007"), ]
globalActivePower <- as.numeric(data_subset$Global_active_power)


# --- 2. Generate and Save Plot ---

png("plot1.png", width = 480, height = 480)

hist(
  globalActivePower,
  col = "red",
  main = "Global Active Power",
  xlab = "Global Active Power (kilowatts)",
  ylab = "Frequency"
)

dev.off()