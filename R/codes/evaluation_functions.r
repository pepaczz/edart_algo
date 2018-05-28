get_evaluation_metrics <- function(models_data_files){
    # For each supplied model file return evaluation metrics
    #
    # args:
    #   models_data_files: vector of strings with names of model data output files
    #
    # returns:
    #   data.frame with metrics for each model
    #
    # example:
    #   models_data_files <- c("data\models_out\model_ref\out.csv")
    #   get_evaluation_metrics(models_data_files)
    
    data <- merge_model_data(models_data_files, return_gg_format = F)
    
    # extract names of models
    models_list <- names(data)[!names(data) %in% c("date","observed")]
    
    # create empty df
    results_df <- data.frame(model = character(), sse = double())
    
    # iterate over each supplied model
    for(model in models_list){
        # model <- models_list[1]
        
        # calculate sse
        sse = sum((data$observed - data[model][,1])^2, na.rm = T)
        
        # bind to results
        df_now <- data.frame(model = model, sse = sse)
        results_df <- rbind(results_df, df_now)
    }
    
    return(results_df)
    
}