pollutantmean <- function(directory, pollutant, id = 1:332) {
  total_pollution_values <- numeric()
  for(i in id) {
    if(i < 10) {
      file <- read.csv(paste(directory, "/00", i, ".csv", sep = ""))
    }else if(i < 100) {
      file <- read.csv(paste(directory, "/0", i, ".csv", sep = ""))
    }else {
      file <- read.csv(paste(directory, "/", i, ".csv", sep = ""))
    }
    pollution_values <- file[, pollutant]
    pollution_values <- pollution_values[!is.na(pollution_values)]
    total_pollution_values <- c(total_pollution_values, pollution_values)
  }
  pollutant_mean <- mean(total_pollution_values)
  pollutant_mean
}