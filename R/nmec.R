`nmec` <- list(
  nome = "NMEC",
  url = "pedrocostaferreira.github.io/atom.xml",
  
  lista = function(){
    df <- safe_tidyfeed("http://pedrocostaferreira.github.io/atom.xml")
    df <- df %>%
      select(
        feed_title,
        feed_link,
        item_title,
        item_date_published = item_date_updated,
        item_link
      ) %>%
      mutate(
        item_link = str_replace(
          item_link, 
          stringr::fixed("http://pedrocostaferreira.github.io//"), 
          "http://pedrocostaferreira.github.io/"
        )
      )
    
    
  },
  
  post = function(url){
    safe_mercury(url)
  }
)

# a <- `nmec`$lista()
# b <- `nmec`$post(a$item_link[1])