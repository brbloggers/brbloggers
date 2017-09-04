`r-python-e-redes` <- list(
  nome = "R Python e Redes",
  url = "http://neylsoncrepalde.github.io/feed.xml",
  
  lista = function(){
    df <- safe_tidyfeed("http://neylsoncrepalde.github.io/feed.xml")
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

# a <- `r-python-e-redes`$lista()
# b <- `r-python-e-redes`$post(a$item_link[1])
