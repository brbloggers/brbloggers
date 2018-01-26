ibpad <- list(
  nome = "IBPAD",
  url = "http://www.ibpad.com.br/blog/analise-de-dados/feed/",
  
  lista = function(){
    x <- readr::read_lines("http://www.ibpad.com.br/blog/analise-de-dados/feed/")
    x <- x[-1]
    x <- paste(x, collapse = '')
    x <- xml2::read_xml(x)
    x <- xml2::as_list(x)
    
    id_items <- which(names(x$channel) == "item")
    
    df <- dplyr::data_frame(
      feed_title = unlist(x$channel$title),
      feed_link = attr(x$channel$link, "href"),
      item_title = map_chr(id_items, ~unlist(x$channel[[.x]]$title)),
      item_date_published = map_chr(id_items, ~unlist(x$channel[[.x]]$pubDate)),
      item_link = map_chr(id_items, ~unlist(x$channel[[.x]]$link))
    ) 
    
    df$item_date_published <- lubridate::dmy_hms(df$item_date_published)
    
    df
  },
  
  post = function(url){
    x <- httr::GET(url) %>%
      httr::content('text') %>%
      xml2::read_html() %>%
      rvest::html_node(".post-inner-content") %>%
      as.character()
    
    x
  }
)

# a <- ibpad$lista()
# b <- `ibpad`$post(a$item_link[1])
