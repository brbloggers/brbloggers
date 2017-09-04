`cantinho-do-r` <- list(
  nome = "Cantinho do R",
  url = "https://cantinhodor.wordpress.com/feed/",
  
  lista = function(){
    df <- safe_tidyfeed("https://cantinhodor.wordpress.com/feed/")
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

# a <- `cantinho-do-r`$lista()
#b <- `cantinho-do-r`$post(a$item_link[1])