##Laura's sample script for creating 1 benthic dataset in R from multiple coralnet outputs (exported annotations).

##TO CREATE THE BENTHIC DATASET:

  #set working directory to the folder that has all the image point CSV files

setwd("C:/Users/Laura/Dropbox/Bruno lab/Acropora/Acropora Recovery in Akumal- Summer 2016/2016_Akumal_Fieldwork/images_final")


##use packages to read in CSVs and bind all rows--- creates 1 dataset
library(dplyr)
library(plyr)
library(readr)

benthic <- list.files(full.names = TRUE) %>% 
  lapply(read_csv) %>% 
  bind_rows 
View(benthic)
str(benthic)
benthic$site <- as.factor(benthic$site)
benthic$spur <-as.factor(benthic$spur)

##Creating column for funcitonal group
unique(benthic$label)

fun.group <- function(x) { 
  if(x == "CTB") y <- "CTB"
  if(x == "SSID") y <- "coral"
  if(x == "Turf_algae") y <- "algae"
  if(x == "ORBFAV") y <- "coral"
  if(x == "STEINT") y <- "coral"
  if(x == "DEC") y <- "coral"
  if(x == "ALGA") y <- "algae"
  if(x == "Unk") y <- "unkown"
  if(x == "ZOAN") y <- "invert"
  if(x == "MILA") y <- "coral"
  if(x == "Clio") y <- "sponge"
  if(x == "ISOSIN") y <- "coral"
  if(x == "CCA") y <- "CCA"
  if(x == "Sponge") y <- "sponge"
  if(x == "ORBANN") y <- "coral"
  if(x == "DLAB") y <- "coral"
  if(x == "DL") y <- "coral"
  if(x == "ACRC") y <- "coral"
  if(x == "Macro") y <- "macro"
  if(x == "ACRP") y <- "coral"
  if(x == "Diad") y <- "invert"
  if(x == "Sand") y <- "substrate"
  if(x == "Lobph") y <- "macro"
  if(x == "DSUB") y <- "substrate"
  if(x == "GORGO") y <- "softcoral"
  if(x == "POP") y <- "coral"
  if(x == "MCAV") y <- "coral"
  if(x == "CON") y <- "coral"
  if(x == "Hali") y <- "macro"
  if(x == "MYL") y <- "coral"
  if(x == "PAST") y <- "coral"
  if(x == "AGT") y <- "coral"
  if(x == "CIST") y <- "coral"
  if(x == "ORBFRA") y <- "coral"
  if(x == "AGAR") y <- "coral"
  if(x == "SOFT_RUBB") y <- "substrate"
  if(x == "Dict") y <- "macro"
  if(x == "AGAAGA") y <- "coral"
  if(x == "DIS") y <- "coral"
  if(x == "MILC") y <- "coral"
  if(x == "LEPCU") y <- "coral"
  if(x== "ENGR1") y <-"softcoral"
  return(y)
}

benthic$functional <- sapply(benthic$label, fun.group)
View(benthic)

benthic$functional <-as.factor(benthic$functional)

write_csv(benthic,path="C:/Users/Laura/Dropbox/Bruno lab/Acropora/Acropora Recovery in Akumal- Summer 2016/2016_Akumal_Fieldwork/Akumal2016/benthic.csv", col_names=TRUE)

######Move the remaining code to the Akumal_mixmods RMD file #####

plyr::count(benthic$functional)
  #out of 5450 entries/rows

######Get the percent covers of each functional group
  
benthic %>%
  group_by(functional) %>%
  summarise (n = n()) %>%
  mutate(perc_cov = n / sum(n)*100)
#algae= 23%
#coral= 11.76%
#macro= 32%
#softcoral= 10.67%
#...so overall, algae accounts for 55% of benthic cover of these reefs...
  
######Get the percent covers of each label
benthic %>%
  group_by(label) %>%
  summarise (n = n()) %>%
  mutate(perc_cov = n / sum(n)*100)
