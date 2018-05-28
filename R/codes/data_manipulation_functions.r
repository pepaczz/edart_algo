require(reshape2)
require(lubridate)
# models_data_files <- c(file.path(MODEL_REF_DATA_FLD, "out.csv"))

merge_model_data <- function(models_data_files,
                             return_gg_format = F,
                             filter_year = NULL,
                             start_date = NULL,
                             end_date = NULL){
    # Merges predictions from different models
    #
    # args:
    #   models_data_files: vector of strings with names of model data output files
    #   return_gg_format: if TRUE, melts data into ggplot format, default FALSE
    #   filter_year: integer or vector with integers specifying years to filter
    #   start_date: starting date for filter
    #   end_date: ending date for filter
    #
    # returns:
    #   data.frame with data from supplied models
    
    
    # get SP500 data
    data_0 <- read_fin_data()
    names(data_0) <- c("date", "observed")
    
    data_full <- data_0
    
    # filter selected year
    if(!is.null(filter_year)){
        # filter_year <- 2012
        data_full <- data_full[(year(data_full$date) %in% filter_year),]
    }
    
    # filter from starting date
    if(!is.null(start_date)){
        # start_date <- "2013-02-04"
        start_date <- as.Date(start_date)
        data_full <- data_full[data_full$date >= start_date,]
    }
    
    # filter until ending date
    if(!is.null(start_date)){
        # end_date <- "2013-08-04"
        end_date <- as.Date(end_date)
        data_full <- data_full[data_full$date <= end_date,]
    }
    
    # iterate over all required models to merge data
    for(data_file in models_data_files){
        
        # data_file <- models_data_files # debug here
        
        # extract model name
        model_nm <- basename(dirname(models_data_files))
        
        # read data from model and rename
        model_data_now <- read_fin_data(data_file)
        model_data_now <- model_data_now[c("date", "volume")]
        names(model_data_now) <- c("date", model_nm)
        
        # merge data together
        data_full <- merge(x = data_full, y = model_data_now, by = "date", all.x = T)
    }
    
    # melt to gg format if required
    if(return_gg_format){
        result <- melt(data_full, id.vars = "date", variable.name = "model")
    }else{
        result <- data_full
    }
    
    return(result)
}


