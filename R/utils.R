#' Versão safe da função tidyfeed do pacote tidyxml
#'
safe_tidyfeed <- possibly(tidyfeed, NA, quiet = TRUE)

#' Versão safe da função mercury do pacote 
#' mercury.
#'
#'
safe_mercury <- possibly(function(x){
  req <- mercury(x)
  if(is.null(req$content)){
    return(NA)
  } else {
    return(req$content)
  }
}, NA, quiet = FALSE)

#' Função que arruma nome dos arquivos para salvar na pasta corretamente.
#' Ela faz alguns tratamentos como remoção de barras, percentuais e etc. 
#' Tudo que poderia dar problema para o rmarkdown.
#'
fix_file_name <- function(dir, item_link, feed_link){
  # transform item link
  item_link <- item_link %>%
    str_replace(fixed(feed_link), "") %>%
    str_replace("/$", "") %>%
    str_extract("/[^/]+$") %>%
    str_replace_all("%", "-") %>%
    str_replace_all("[\\(\\)]", "") %>%
    str_replace_all("^/", "")  %>%
    str_replace_all("=", "-")
  
  sprintf(
    "content/%s/%s", 
    dir, 
    item_link
  )
}

#' Função que cria o header do arquivo md para o blog.
#'
create_md_header <- function(title, date, blog, original_url){
  sprintf(
    '+++\ntitle = "%s"\ndate = "%s"\ncategories = ["%s"]\noriginal_url = "%s"\n+++\n',
    title,
    date,
    blog,
    original_url
  )
}

#' Função que faz tratamento do título para post. Atualmente remove as aspas que
#' estavam dando problema.
#'
#'
tratar_titulo <- function(x){
  stringr::str_replace_all(x, stringr::fixed('"'), "")
}