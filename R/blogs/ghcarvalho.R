`ghcarvalho` <- list(
  nome = "R, data science, e ecologia.",
  url = "https://medium.com/feed/@ghcarvalho",
  
  lista = function(){
    df <- safe_tidyfeed("https://medium.com/feed/@ghcarvalho/")
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

# a <- `d-van`$lista()
# b <- `d-van`$post(a$item_link[1])