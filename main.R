#' Versão nova do arquivo main. 
#' 

suppressPackageStartupMessages({
  library(purrr)
  library(stringr)
  library(tidyRSS)
  library(mercury)
  library(dplyr)
  library(readr)
  library(xml2)
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

# ler posts antigos que já foram salvos

posts_salvos <- dir("content", recursive = TRUE, full.names = TRUE)

# obter posts recentes
new_posts <- feeds %>%
  map(~.x$lista) %>%
  map(~safely(.x, otherwise = NULL)) %>%
  map_df(~.x()$result, .id = "blog") %>%
  mutate(
    fname = paste0(fix_file_name(
      blog, 
      item_link, 
      feed_link
    ), ".md")
  ) %>%
  filter(! fname %in% posts_salvos) %>%
  mutate(
    post_fun = map(feeds[blog], ~.x$post),
    item_content = map2_chr(post_fun, item_link, ~.x(.y))
  ) %>%
  select(-post_fun, -fname) %>%
  filter(!is.na(item_content))


# Write feeds to directory ------------------------------------------------
if(nrow(new_posts) > 0){
  message("writing new posts")
  # slackr_msg("writing new posts")
  for(i in 1:nrow(new_posts)){
    if(!is.na(new_posts$item_content[i])){
      message(sprintf("writing post with link %s", new_posts$item_link[i]))
      file_name <- fix_file_name(
        new_posts$blog[i], 
        new_posts$item_link[i], 
        new_posts$feed_link[i]
      )
      
      # writing the html file
      write_lines(new_posts$item_content[i], sprintf("%s.html", file_name))
      
      # convert file to markdown
      if(rmarkdown::pandoc_available(error = FALSE)){
        rmarkdown::render(
          sprintf("%s.html", file_name), 
          rmarkdown::md_document(),
          output_file = sprintf("%s.md", file_name)
          )
        
        # add the header and rewrite
        md_file <- read_file(sprintf("%s.md", file_name)) 
        
        readr::write_lines(
          sprintf(
            "%s\n%s",
            create_md_header(
              new_posts$item_title[i] %>% tratar_titulo(), 
              new_posts$item_date_published[i], 
              new_posts$blog[i],
              new_posts$item_link[i]
            ),
            md_file
          ), 
          sprintf("%s.md", file_name)
        )
        
        message("new post was written")  
        # slackr_msg("new post was written")  
      } else {
        message("PANDOC WAS NOT AVAILABLE")
        # slackr_msg("PANDOC WAS NOT AVAILABLE")
      }
      
      # delete html file
      file.remove(sprintf("%s.html", file_name))
      
    }
    
  }
}

# adicionar perguntas mais recentes do stack-overflow

lista_sopt <- dir("content/sopt", full.names = TRUE)

sopt <- tidyfeed("https://pt.stackoverflow.com/feeds/tag?tagnames=r&sort=newest") %>%
  select(-feed_last_updated) %>%
  mutate(fname = sprintf("content/sopt/%s.md", str_extract(item_link, "[^/]*$")))

new_sopt <- sopt %>%
  filter(!fname %in% lista_sopt)

if(nrow(new_sopt) > 0){
  message("writing new posts")
  for(i in 1:nrow(new_sopt)){
    write_lines(
      sprintf(
        '+++\ntitle = "%s"\ndate = "%s"\ncategories = ["%s"]\noriginal_url = "%s"\nat_home="no"\n+++\n',
        new_sopt$item_title[i] %>% tratar_titulo,
        new_sopt$item_date_updated[i],
        "sopt",
        new_sopt$item_link[i]
      ), 
      path = sprintf("content/sopt/%s.md", str_extract(new_sopt$item_link[i], "[^/]*$"))
    )
  }  
}

message(sprintf("[%s]: Finished",lubridate::now()))
# slackr_msg(sprintf("[%s]: Finished",lubridate::now()))
