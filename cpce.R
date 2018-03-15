## Get unique values from CPCe file
## Julien Brun, NCEAS

library(dplyr)
library(purrr)
library(readxl)

unique_all <- data.frame()
for(i in length(list.files(paste(getwd(),'/data_cpce',sep='')))){
  dat.path <- paste(getwd(),'/data_cpce/'
                    ,list.files(paste(getwd(),'/data_cpce',sep=''))[i],sep='')
  cpce_data <-read_xlsx(dat.path)
  
  # Get the unique value
  unique_catgories <- cpce_data %>%
    select(1:3) %>%
    map(unique)
  
  # Make it a dataframe
  
  df_unique <- as.data.frame(unlist(unique_catgories))
  unique_all <- rbind(unique_all,df_unique)
}
write.csv(df_unique, "unique_cpce_categories.csv")

## 1 - 5 is at 2m
## 6 - 10 is at 0.5m
## 10 meter long transects
## gps to be given
## 10 random photo quads, randomly chose 5 to do CPCe
## 50 points in CPCe
