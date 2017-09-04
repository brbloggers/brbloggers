`lurodrigo` <- list(
  nome = "Luiz Rodrigo",
  url = "http://lurodrigo.com/feed.R_pt.xml",
  
  lista = function(){
    df <- safe_tidyfeed("http://lurodrigo.com/feed.R_pt.xml")
    df %>%
      select(
        feed_title,
        feed_link,
        item_title,
        item_date_published = item_date_updated,
        item_link
      )
  },
  
  post = function(url){
    safe_mercury(url)
  }
)

# a <- `lurodrigo`$lista()
# b <- `lurodrigo`$post(a$item_link[1])