library(stringr)


slides_raw = list.files(pattern = "*.html")

slides_name = slides_raw |>
  str_remove(pattern = ".html")


for(i in seq_along(slides_raw)){
  
  renderthis::to_pdf(slides_raw[[i]], to = paste0(slides_name[[i]], ".pdf"))
  
}