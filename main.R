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

# secure::add_user("daniel", public_key = secure::local_key())
# secure::encrypt("MERCURY_KEY", key = "xxxxxxxxxxxxxxxx")
# secure::encrypt("NETLIFY_BUILD_HOOK", key = "xxxxxxxxxxxxxxx")
# secure::encrypt("SLACK", key = "")
# secure::encrypt("SLACK_TOKEN", key = "xxxxxxx")

slackr_setup(channel="#brbloggers", api_token = secure::decrypt("SLACK_TOKEN")$key,
             incoming_webhook_url=secure::decrypt("SLACK")$key)

message(sprintf("[%s]: Starting update",lubridate::now()))
slackr_msg(sprintf("[%s]: Starting update",lubridate::now()))

Sys.setenv(MERCURY_KEY = secure::decrypt("MERCURY_KEY")$key)


# Auxiliary functions -----------------------------------------------------

safe_tidyfeed <- possibly(tidyfeed, NA, quiet = TRUE)
safe_mercury <- possibly(function(x){
  req <- mercury(x)
  if(is.null(req$content)){
    return(NA)
  } else {
    return(req$content)
  }
}, NA, quiet = FALSE)

fix_file_name <- function(dir, item_link, feed_link){
  # transform item link
  item_link <- item_link %>%
    str_replace(fixed(feed_link), "") %>%
    str_replace("/$", "") %>%
    str_extract("/[^/]+$") %>%
    str_replace_all("%", "-") %>%
    str_replace_all("[\\(\\)]", "") %>%
    str_replace_all("^/", "")
  
  sprintf(
    "content/%s/%s", 
    dir, 
    item_link
  )
}

create_md_header <- function(title, date, blog, original_url){
  sprintf(
    '+++\ntitle = "%s"\ndate = "%s"\ncategories = ["%s"]\noriginal_url = "%s"\n+++\n',
    title,
    date,
    blog,
    original_url
  )
}

tratar_titulo <- function(x){
  stringr::str_replace_all(x, stringr::fixed('"'), "")
}

# Get all feeds
source("feeds.R", local = TRUE)

message(sprintf("%02d blogs are watched", length(feeds)))
slackr_msg(sprintf("%02d blogs are watched", length(feeds)))

# verify and create necessary folders
for(blog in names(feeds)){
  if(!dir.exists(sprintf("content/%s", blog))){
    dir.create(path = sprintf("content/%s", blog)) 
    message(sprintf("content/%s was created", blog))
  }
}

# Download feeds ----------------------------------------------------------

posts <- readRDS("data/posts.rds")


suppressMessages({
  all_feeds <- feeds %>%
    map(~safe_tidyfeed(.x$url))  
})

# modificações necessárias p/ cada blog
message("Baixando dados do blog curso-r")
all_feeds$`curso-r` <- try({all_feeds$`curso-r` %>%
    select(
      feed_title,
      feed_link,
      item_title,
      item_date_published,
      item_link
    )})

message("Baixando dados do blog paixao-por-dados")
all_feeds$`paixao-por-dados` <- try({all_feeds$`paixao-por-dados` %>%
    select(
      feed_title,
      feed_link,
      item_title,
      item_date_published,
      item_link
    )})

message("Baixando dados do blog analise-real")
all_feeds$`analise-real` <- try({all_feeds$`analise-real` %>%
    select(
      feed_title,
      feed_link,
      item_title,
      item_date_published,
      item_link
    )}) 

message("Baixando dados do blog dfalbel")
all_feeds$dfalbel <- try({all_feeds$dfalbel %>%
    select(
      feed_title,
      feed_link,
      item_title,
      item_date_published,
      item_link
    )})

message("Baixando dados do blog lurodrigo")
all_feeds$lurodrigo <- try({all_feeds$lurodrigo %>%
    select(
      feed_title,
      feed_link,
      item_title,
      item_date_published = item_date_updated,
      item_link
    )})

message("Baixando dados do blog cantinho do R")
all_feeds$`cantinho-do-r` <- try({all_feeds$`cantinho-do-r` %>%
    select(
      feed_title,
      feed_link,
      item_title,
      item_date_published,
      item_link
    )})

message("Baixando dados do blog IBPAD")
all_feeds$IBPAD <- try({all_feeds$IBPAD %>% 
    select(
      feed_title,
      feed_link,
      item_title,
      item_date_published,
      item_link
    )})

message("Baixando dados do blog italocegatta")
all_feeds$italocegatta <- try({all_feeds$italocegatta %>% 
    select(
      feed_title,
      feed_link,
      item_title,
      item_date_published,
      item_link
    ) %>%
    mutate(item_link = paste0("https://italocegatta.github.io", item_link))
})

message("Baixando dados do blog r-python-e-redes")
all_feeds$`r-python-e-redes` <- try({all_feeds$`r-python-e-redes` %>% 
    select(
      feed_title,
      feed_link,
      item_title,
      item_date_published,
      item_link
    )})

message("Baixando dados do blog d-van")
all_feeds$`d-van` <- try({all_feeds$`d-van` %>%
    tidyr::unite("category", starts_with("item_category"), sep = " | ") %>%
    filter(stringr::str_detect(category, stringr::fixed("análise-de-dados"))) %>%
    select(
      feed_title,
      feed_link,
      item_title,
      item_date_published,
      item_link
    )
})

message("Baixando dados do blog Mind & Iron")
all_feeds$`mind-and-iron` <- try({all_feeds$`mind-and-iron` %>%
    filter(item_title != "") %>%
    select(
      feed_title,
      feed_link,
      item_title,
      item_date_published,
      item_link
    )
})

message("Baixando dados do blog José Guilherme Lopes")
all_feeds$`jose-guilherme-lopes` <- try({all_feeds$`jose-guilherme-lopes` %>%
    filter(item_title != "") %>%
    select(
      feed_title,
      feed_link,
      item_title,
      item_date_published,
      item_link
    )
})

all_feeds <- all_feeds %>%
  keep(is.data.frame) %>%
  map_df(~.x, .id = "blog") %>%
  filter(
    item_date_published > (lubridate::today() - 30) | # pegar o conteudo de posts recentes
      (!blog %in% unique(posts$blog)) # ou de blogs novos
  ) %>%
  mutate(item_content = map_chr(item_link, safe_mercury))

# tweaks para o IBPAD
try({
  feed_ibpad <- read_xml("http://www.ibpad.com.br/blog/analise-de-dados/feed/") %>%
    rvest::xml_nodes("item")
  dados_ibpad <- data_frame(
    item_link = feed_ibpad %>% xml_child("link") %>% xml_text(),
    item_content = feed_ibpad %>% xml_child("content:encoded") %>% xml_text()
  )
  
  # retornar dados do IBPAD
  all_feeds <- bind_rows(
    all_feeds %>% filter(blog != "IBPAD"),
    all_feeds %>% 
      filter(blog == "IBPAD") %>% 
      select(-item_content) %>% 
      left_join(dados_ibpad, by = "item_link")
  )
})

# Decide which posts will be written
new_posts <- setdiff(all_feeds, posts)

message(sprintf("%03d new posts", nrow(new_posts)))
slackr_msg(sprintf("%03d new posts", nrow(new_posts)))
if(nrow(new_posts) > 0){
  message(
    sprintf("%s\n", 
            paste0(new_posts$item_title, "já existe em posts?",  
                   new_posts$item_title %in% posts$item_title
            )
    )
  )
  
  slackr_msg(
    sprintf("%s\n", 
            paste0(new_posts$item_title, "já existe em posts?",  
                   new_posts$item_title %in% posts$item_title
            )
    )
  )
}

posts <- bind_rows(posts, new_posts)
saveRDS(posts, "data/posts.rds")

# Write feeds to directory ------------------------------------------------
if(nrow(new_posts) > 0){
  message("writing new posts")
  slackr_msg("writing new posts")
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
        rmarkdown::render(sprintf("%s.html", file_name), rmarkdown::md_document())
        
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
        slackr_msg("new post was written")  
      } else {
        message("PANDOC WAS NOT AVAILABLE")
        slackr_msg("PANDOC WAS NOT AVAILABLE")
      }
      
      # delete html file
      file.remove(sprintf("%s.html", file_name))
      
    }
    
  }
}

# adicionar perguntas mais recentes do stack-overflow

all_sopt <- readRDS("data/sopt.rds")
sopt <- tidyfeed("https://pt.stackoverflow.com/feeds/tag?tagnames=r&sort=newest") %>%
  select(-feed_last_updated)

new_sopt <- setdiff(sopt, all_sopt) %>%
  filter(item_date_updated > max(all_sopt$item_date_updated))

all_sopt <- bind_rows(all_sopt, new_sopt)
saveRDS(all_sopt, "data/sopt.rds")

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
slackr_msg(sprintf("[%s]: Finished",lubridate::now()))












