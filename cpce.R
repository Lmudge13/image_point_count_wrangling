## Get unique values from CPCe file
## Julien Brun, NCEAS

library(dplyr)
library(purrr)
library(readxl)


# Initialize the dataframe to stor all the files content
unique_all <- data.frame()

# Path to folder containing Excel files
excel_dir <- file.path(getwd(),'data_cpce')

# list the excel files
excel_files <- list.files(excel_dir, pattern = "xlsx", full.names = TRUE)

# Looping through the files
for(i in 1:length(excel_files)){
  # Read 
  cpce_data <-read_xlsx(excel_files[i])
  
  # Get the unique value
  unique_catgories <- cpce_data %>%
    select(1:3) %>%
    map(unique)
  
  # Make it a dataframe
  df_unique <- as.data.frame(unlist(unique_catgories))
  unique_all <- rbind(unique_all,df_unique)
}
write.csv(df_unique, "unique_cpce_categories.csv", row.names = FALSE)

## 1 - 5 is at 2m
## 6 - 10 is at 0.5m
## 10 meter long transects
## gps to be given
## 10 random photo quads, randomly chose 5 to do CPCe
## 50 points in CPCe
