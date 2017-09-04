ibpad <- list(
  nome = "IBPAD",
  url = "http://www.ibpad.com.br/blog/analise-de-dados/feed/",
  
  lista = function(){
    df <- safe_tidyfeed("http://www.ibpad.com.br/blog/analise-de-dados/feed/")
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
