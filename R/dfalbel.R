`dfalbel` = list(
  nome = "Como faz no R",
  url = "http://dfalbel.github.io/feed.xml",
  
  lista = function(){
    df <- safe_tidyfeed("http://dfalbel.github.io/feed.xml")
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

# a <- `dfalbel`$lista()
# b <- `dfalbel`$post(a$item_link[1])