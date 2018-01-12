`felippe-gomes` <- list(
  nome = "Felippe Gomes",
  url = "https://gomesfellipe.github.io",
  
  lista = function(){
    df <- safe_tidyfeed("https://gomesfellipe.github.io/index.xml")
    df %>%
      select(
        feed_title,
        feed_link,
        item_title,
        item_date_published,
        item_link
      ) %>%
      filter(str_sub(item_link, 1, 5) == "/post") %>%
      mutate(item_link = paste0("https://gomesfellipe.github.io", item_link))
  },
  
  post = function(url){
    safe_mercury(url)
  }
)