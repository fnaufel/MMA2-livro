
library(tidyverse)
library(tidymodels)
tidymodels_prefer()

library(keras)
library(tfruns)
library(scales)


# Flags -------------------------------------------------------------------

FLAGS <- flags(
  flag_integer('size1', 200),
  flag_numeric('learning_rate', 0.001),
  flag_numeric('momentum', 0.1),
  flag_integer('batch_size', 201),
  flag_integer('epochs', 1500),
  flag_string('optimizer', 'rmsprop')
)


# Gerar dados normalizados ------------------------------------------------

# Antes
# minimo <- -100
# maximo <- 100
# dados <- tibble(
#   x = rescale(minimo:maximo),
#   y = rescale(x^2)
# )
  
# Agora
minimo <- -100
maximo <- 100
dados <- tibble(
  x = rescale(minimo:maximo, c(-1, 1)),
  y = rescale(x^2, c(0, 1))
)

# Particionar -------------------------------------------------------------

# Não é preciso particionar aqui. Usar todos os dados no treino.

# dados_split <- dados %>% initial_split()
# 
# df_treino <- training(dados_split)
# df_teste <- testing(dados_split)

# dados_treino <- df_treino %>% pull(x) %>% as.matrix()
# metas_treino <- df_treino %>% pull(y) %>% as.matrix()
# 
# dados_teste <- df_teste %>% pull(x) %>% as.matrix()
# metas_teste <- df_teste %>% pull(y) %>% as.matrix()

dados_treino <- dados %>% pull(x) %>% as.matrix()
metas_treino <- dados %>% pull(y) %>% as.matrix()


# Criar modelo ------------------------------------------------------------

## Duas camadas ocultas ---------------------------------------------------

# rede <- keras_model_sequential() %>% 
#   layer_dense(40, activation = 'relu', input_shape = 1) %>% 
#   layer_dense(20, activation = 'relu') %>% 
#   layer_dense(1)

## 3 camadas oculta, com 100 ---------------------------------------

rede <- keras_model_sequential() %>%
  layer_dense(FLAGS$size1, activation = 'relu', input_shape = 1) %>%
  layer_dense(1)


# Compilar ----------------------------------------------------------------

if (FLAGS$optimizer == 'rmsprop') {
  opt <- optimizer_rmsprop(
    learning_rate = FLAGS$learning_rate, 
    momentum = FLAGS$momentum
  )
} else if (FLAGS$optimizer == 'adam') {
  opt <- optimizer_adam(
    learning_rate = FLAGS$learning_rate
  )
}

rede %>% 
  compile(
    optimizer = opt,
    loss = 'mse',
    metrics = 'mae'
  )


# Treinar -----------------------------------------------------------------

# TODO: Callback para salvar?
historico <- rede %>% fit(
  dados_treino, 
  metas_treino, 
  epochs = FLAGS$epochs,
  batch_size = FLAGS$batch_size,
  validation_split = 0.2,
  verbose = 0
)


  
