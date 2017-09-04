`italocegatta` <- list(
  nome = "Ítalo Cegatta",
  url = "https://italocegatta.github.io/index.xml",
  
  lista = function(){
    df <- safe_tidyfeed("https://italocegatta.github.io/index.xml")
    df %>%
      select(
        feed_title,
        feed_link,
        item_title,
        item_date_published,
        item_link
      ) %>%
      mutate(item_link = paste0("https://italocegatta.github.io", item_link))
  },
  
  post = function(url){
    safe_mercury(url)
  }
)

# a <- `italocegatta`$lista()
# b <- `italocegatta`$post(a$item_link[1])
