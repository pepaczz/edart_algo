source("R/codes/constants.r")

model_ref <- function(file_in = DATA_IN_SP, 
                      file_out = file.path(MODEL_REF_DATA_FLD, "out.csv"),
                      write_to_file = T){
    # Reference model - prediction is just yesterday's values
    #
    # args:
    #   file_in: name of input file, default defined in constants.r
    #   file_out: name of output file, default defined in constants.r
    #   write_to_file: decide whether to write into file or not, default TRUE
    #
    # returns:
    #   data.frame with date and prediction
    
    # read data
    data <- read_fin_data(file_in = file_in)
    # data <- data[1:15, ] # debug purposes - only few rows

    data <- data[c("date", "volume")]   # select only date and volume
    
    # create prediction df
    prediction <- data["date"]
    prediction$volume <- c(NA, data$volume[1:(length(data$volume)-1)])
    
    # export to csv
    if(write_to_file){
        write.table(prediction, file = file_out, sep = ",", row.names = F)
    }
    
    return(prediction)
}


