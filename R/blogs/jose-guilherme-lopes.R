`jose-guilherme_lopes` <- list(
  nome = "José Guilherme Lopes",
  url = "http://joseguilhermelopes.com.br/feed/",
  
  lista = function(){
    df <- safe_tidyfeed("http://joseguilhermelopes.com.br/feed/")
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

# a <- `jose-guilherme_lopes`$lista()
# b <- `jose-guilherme_lopes`$post(a$item_link[1])
