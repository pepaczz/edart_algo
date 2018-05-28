source("R/codes/constants.r")
source(file.path(R_CODES_FLD, "model_ref.r"))
source(file.path(R_CODES_FLD, "read_data.r"))
source(file.path(R_CODES_FLD, "plot_functions.r"))
source(file.path(R_CODES_FLD, "data_manipulation_functions.r"))
source(file.path(R_CODES_FLD, "evaluation_functions.r"))

require(ggplot2)
require(dplyr)

pred <- model_ref(write_to_file = T)


models_data_files <- c(file.path(MODEL_REF_DATA_FLD, "out.csv"))

gg_data <- merge_model_data(models_data_files, return_gg_format = T, filter_year = 2012)
ggplot(gg_data, aes(x = date, y = value, colour = model)) +
    geom_line()

get_evaluation_metrics(models_data_files)
