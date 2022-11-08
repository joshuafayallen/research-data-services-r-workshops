library(renderthis)




xaringan_to_pdf <- function(slide_path) {
  renderthis::to_pdf(slide_path,
                     to = paste0(path_sans_ext, ".pdf"),
                     complex_slides = complex)

  return(paste0(tools::file_path_sans_ext(slide_path), ".pdf"))
}

