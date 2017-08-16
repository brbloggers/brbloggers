#' Versão nova do arquivo main. 
#' 
setwd("~/brbloggers/")

suppressPackageStartupMessages({
  library(purrr)
  library(stringr)
  library(tidyRSS)
  library(mercury)
  library(dplyr)
  library(readr)
  library(xml2)
  library(slackr)
})

# Carregar feeds e funções auxiliares ---------------------------------

source("feeds.R", local = TRUE)
source("R/utils.R", local = TRUE)

# Iniciar o processamento ---------------------------------------------
message(sprintf("[%s]: Starting update",lubridate::now()))
Sys.setenv(MERCURY_KEY = secure::decrypt("MERCURY_KEY")$key)


# Preparar pastas para salvar posts ---------------------------------------

message(sprintf("%02d blogs are watched", length(feeds)))

# aqui verificamos se todos os blogs já possuem a sua pasta e etc.
# verify and create necessary folders
for(blog in names(feeds)){
  if(!dir.exists(sprintf("content/%s", blog))){
    dir.create(path = sprintf("content/%s", blog)) 
    message(sprintf("content/%s was created", blog))
  }
}


