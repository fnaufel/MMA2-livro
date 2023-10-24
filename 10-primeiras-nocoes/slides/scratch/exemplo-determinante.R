
library(keras)
library(tfruns)


# Flags -------------------------------------------------------------------

FLAGS <- flags(
  flag_numeric('learning_rate', 0.001),
  flag_numeric('decay', 0),
  flag_numeric('momentum', 0),
  flag_integer('batch_size', 128),
  flag_integer('epochs', 500)
)

# Funções para normalizar e desnormalizar ---------------------------------

# Fazer normalização das entradas em função dos extremos `minimo` e `maximo`,
# para produzir valores entre $-1$ e $1$.

# E normalizar saídas em função do menor determinante possível ($-100$) e do
# maior determinante possível ($100$) para produzir valores entre $-1$ e $1$:

normalizar <- function(
    x, 
    entrada_minima = -10, 
    entrada_maxima = 10,
    saida_minima = -1,
    saida_maxima = 1
) {

  saida_minima + (x - entrada_minima) * 
    (saida_maxima - saida_minima) / (entrada_maxima - entrada_minima)

}

desnormalizar <- function(
    y, 
    entrada_minima = -10, 
    entrada_maxima = 10,
    saida_minima = -1,
    saida_maxima = 1
) {

  entrada_minima + (y - saida_minima) * 
    (entrada_maxima - entrada_minima) / (saida_maxima - saida_minima)
}


# Gerar dados -------------------------------------------------------------

minimo <- -10
maximo <- 10
dados <- expand_grid(
  a = minimo:maximo,
  b = minimo:maximo,
  c = minimo:maximo,
  d = minimo:maximo
) %>% 
  mutate(res = a*d - b*c)


# Normalizar dados --------------------------------------------------------

dados_norm <- dados %>% 
  mutate(
    a = normalizar(a, -10, 10),
    b = normalizar(b, -10, 10),
    c = normalizar(c, -10, 10),
    d = normalizar(d, -10, 10),
    res = normalizar(res, -100, 100)
  )


# Particionar -------------------------------------------------------------

n_dados <- nrow(dados_norm)

prop_treino <- .8
n_treino <- (n_dados * prop_treino) %>% round(0)

dados_treino <- 
  dados_norm[1:n_treino, c('a', 'b', 'c', 'd')] %>% as.matrix()

metas_treino <- 
  dados_norm[1:n_treino, 'res'] %>% as.matrix()

dados_teste <- 
  dados_norm[(n_treino + 1):n_dados, c('a', 'b', 'c', 'd')] %>% as.matrix()

metas_teste <- 
  dados_norm[(n_treino + 1):n_dados, 'res'] %>% as.matrix()


# Criar modelo ------------------------------------------------------------

rede1 <- keras_model_sequential() %>% 
  layer_dense(40, activation = 'relu', input_shape = 4) %>% 
  layer_dense(20, activation = 'relu') %>% 
  layer_dense(1)


# Compilar ----------------------------------------------------------------

rede1 %>% 
  compile(
    optimizer = optimizer_rmsprop(
      learning_rate = FLAGS$learning_rate, 
      momentum = FLAGS$momentum
    ),
    loss = 'mse',
    metrics = 'mae'
  )


# Treinar -----------------------------------------------------------------

historico1 <- rede1 %>% fit(
  dados_treino, 
  metas_treino, 
  epochs = FLAGS$epochs,
  batch_size = FLAGS$batch_size,
  validation_split = 0.2
)

