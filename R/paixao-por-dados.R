`paixao-por-dados` = list(
  
  nome = "Paixão por Dados",
  
  url = "https://sillasgonzaga.github.io/feed.xml",
  
  lista = function(){
    df <- safe_tidyfeed("https://sillasgonzaga.github.io/feed.xml")
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