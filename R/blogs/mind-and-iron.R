`mind-and-iron` <- list(
  nome = "Mind & Iron",
  url = "http://ctlente.com/pt/index.xml",
  
  lista = function(){
    df <- safe_tidyfeed("http://ctlente.com/pt/index.xml")
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

# a <- `mind-and-iron`$lista()
# b <- `mind-and-iron`$post(a$item_link[1])
