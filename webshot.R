
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

slides <- c(
  '2',
  '3/1/4',
  '4',
  '5/1/8',
  '6/1/4',
  '7/1/7',
  '8/1/0',
  '9',
  '9/1/0',
  '9/1/1',
  '9/1/2',
  '9/1/3',
  '9/1/4',
  '9/1/5',
  '9/1/6',
  '10/1/3',
  '11',
  'references'
)

slides <- paste0(
  'file:///home/fnaufel/Documents/UFF/Ensino/Disciplinas/MMA/MMA2-livro/slides/10-primeiras-nocoes/slides-001.html#/',
  slides
)

capture(
  slides,
  '/home/fnaufel/Documents/UFF/Ensino/Disciplinas/MMA/MMA2-livro/slides/10-primeiras-nocoes/captured',
  delay = 5
)
