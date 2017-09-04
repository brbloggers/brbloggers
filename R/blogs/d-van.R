`d-van` <- list(
  nome = "Psiquiatria e neurociências clínicas",
  url = "https://medium.com/feed/d-van",
  
  lista = function(){
    df <- safe_tidyfeed("https://medium.com/feed/d-van")
    df %>%
      tidyr::unite("category", starts_with("item_category"), sep = " | ") %>%
      filter(stringr::str_detect(category, stringr::fixed("análise-de-dados"))) %>%
      select(
        feed_title,
        feed_link,
        item_title,
        item_date_published,
        item_link
      )
  },
  
  post = function(url){
    safe_mercury(url)
  }
)

# a <- `d-van`$lista()
# b <- `d-van`$post(a$item_link[1])