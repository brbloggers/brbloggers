`cantinho-do-r` <- list(
  nome = "Cantinho do R",
  url = "https://analisereal.com/feed/",
  
  lista = function(){
    df <- safe_tidyfeed("https://analisereal.com/feed/")
    df %>%
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

# a <- `analise-real`$lista()
# b <- `analise-real`$post(a$item_link[1])