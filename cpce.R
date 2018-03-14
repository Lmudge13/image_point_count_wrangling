## Get unique values from CPCe file
## Julien Brun, NCEAS

library(dplyr)
library(purrr)
library(readxl)

cpce_data <-read_xlsx("~/GitHub/gitNCEAS/crescynt-training/data/CPCE_Rf44_T8_2015.xlsx", sheet = 1)

# Get the unique value
unique_catgories <- cpce_data %>%
  select(1:3) %>%
  map(unique)

# Make it a dataframe

df_unique <- as.data.frame(unlist(unique_catgories))

write.csv(df_unique, "unique_cpce_categories.csv")
