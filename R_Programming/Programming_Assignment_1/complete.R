complete <- function(directory, id = 1:332) {
  ids <- c()
  total_files <- matrix( ncol = 4)
  colnames(total_files) <- c("Date","sulfate","nitrate","ID")
  for(i in id) {
    if(i < 10) {
      file <- read.csv(paste(directory, "/00", i, ".csv", sep = ""))
    }else if(i < 100) {
      file <- read.csv(paste(directory, "/0", i, ".csv", sep = ""))
    }else {
      file <- read.csv(paste(directory, "/", i, ".csv", sep = ""))
    }
    total_files <- rbind(total_files, file)
    total_files <- na.omit(total_files)
  }
  rows <- 1 : nrow(total_files)
  for(i in rows) { 
    ids <- c(ids, total_files[i, "ID"])
  }
  tab <- table(ids)
  if(id[1] > id[length(id)]) {
    id <- rev(as.numeric(names(tab)))
    nobs <- rev(as.vector(tab))
  } else {
    id <- as.numeric(names(tab))
    nobs <- as.vector(tab)    
  }
  complete_observations <- data.frame(id, nobs)
  complete_observations
}