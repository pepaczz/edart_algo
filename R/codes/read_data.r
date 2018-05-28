source("R/codes/constants.r")


read_fin_data <- function(file_in = DATA_IN_SP, date_volume_only = T){
    # read sp500 data from a file
    #
    # args:
    #   file_in: csv to read from, default defined in constants.r
    #   date_volume_only: only date and volume will be returned, default TRUE
    #
    # returns:
    #   dataframe
    
    # read from csv
    data <- read.csv2(file_in, header = T, sep = ",", dec = ".", stringsAsFactors = F)
    
    names(data) <- tolower(names(data)) # column names in lowercase
    data$date <- as.Date(data$date)     # convert to Date format
    
    # extract only date and volume if necessary
    if(date_volume_only){
        data <- data[c("date", "volume")]
    }
    
    return(data)
}
