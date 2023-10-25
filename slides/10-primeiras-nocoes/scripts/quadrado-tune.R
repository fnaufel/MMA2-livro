library(tfruns)


# flags_list <- list(
#   optimizer = c('rmsprop', 'adam'),
#   learning_rate = c(0.001),
#   decay = c(0),
#   momentum = c(0),
#   batch_size = c(32, 64, 128),
#   epochs = c(300)
# )

# flags_list <- list(
#   optimizer = c('rmsprop', 'adam'),
#   learning_rate = c(0.002),
#   decay = c(0),
#   momentum = c(0),
#   batch_size = c(201),
#   epochs = c(500)
# )

flags_list <- list(
  size1 = c(200, 400, 600),
  optimizer = c('rmsprop'),
  learning_rate = c(0.001),
  momentum = c(0.1),
  batch_size = c(201),
  epochs = c(1500)
)

execs <- tuning_run(
  'quadrado-run.R',
  flags = flags_list,
  confirm = FALSE,
  echo = FALSE
)
