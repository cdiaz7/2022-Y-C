# Required packages
# library(dplyr)
library(data.table)
# install.packages("magrittr") # package installations are only needed the first time you use it
# install.packages("dplyr")    # alternative installation of the %>%
library(magrittr) # needs to be run every time you start R and want to use %>%
library(dplyr)    # alternatively, this also loads %>%

# importando la base de datos
#ds_salaries <- read.csv("C:/Users/xx-re/OneDrive/Documentos/GitHub/DataScience-PUCRio-FB/Data/ds_salaries.csv")
# ds_salaries <- read.csv("~/GitHub/DataScience-PUCRio-FB/Data/DS_salarios/ds_salaries.csv")

ds_salaries <- read.csv("H:/CLASE CARLOS MAESTRIA 2022/IND 2622  FERNANDA  CIÊNCIA DE DADOS PARA 5ªf., 13-16 h/Preprocesamiento y posprocesamiento de datos/para hoy/tarea renato sabado/DataScience-PUCRio-FB-main(2)/DataScience-PUCRio-FB-main/Data/DS_salarios/ds_salaries.csv")

# sampling with bootstrap
ds_salaries

# ds_salaries_filtered <- ds_salaries[!is.na(as.numeric(ds_salaries$salary_currency)), ] # Delete rows
# ds_salaries_filtered["salary_currency"]                                          # Print data frame subset

# The dataset does not have missing values

ds_salaries_bootstrap <- transpose(sample(transpose(ds_salaries), size=500, replace = TRUE))

colnames(ds_salaries_bootstrap) <- colnames(ds_salaries)
ds_salaries_bootstrap

# The re-sample method was applied to original dataset with 30 sasmples, with reposition or bootstrap

# discretization numeric variable

# I define the mean salary here
(avg_salary <- mean(as.numeric(ds_salaries$salary_in_usd)))


ds_salaries_discretized <- ds_salaries_bootstrap %>%
  mutate(salary_discretized = ifelse(salary_in_usd < avg_salary,
                           "below average", "at or above average"))

ds_salaries_discretized$salary_discretized <- as.factor(ds_salaries_discretized$salary_in_usd)


#Feature Engineering
ds_salaries_discretized <- ds_salaries_discretized %>%
  mutate(feature_date = (2022 - as.numeric(work_year))*12 + (12-as.numeric(work_month)))
