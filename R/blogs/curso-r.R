`curso-r` <- list(
  
  nome = "Curso-R",
  url = "http://curso-r.com/",
  
  lista = function(){
    df <- safe_tidyfeed("http://curso-r.com/blog/index.xml")
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