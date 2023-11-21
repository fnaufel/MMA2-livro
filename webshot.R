
capture <- function(
  slides,
  out_dir,
  delay = 10
) {
  
  files <- fs::path(out_dir, 'slide.png')
  
  webshot2::webshot(
    slides, files, delay = delay, vwidth = 1920, vheight = 1000
  )
  
}

