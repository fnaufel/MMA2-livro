
# Gerar conjunto de treino
# 4 entradas, 1 saída
# Entradas: x1, x2, x3, x4
# Saídas: y
# 
# [
#   [[0, 0.2, 0.1, 0.7], [1]],
#   [[0, 0.6, 0.1, 0.3], [0]],
#   [[0, 0.4, 0.3, 0.3], [1]],
#   [[0, 0,   0.8, 0.2], [0]]
# ]
# 
minimo <- -1
maximo <- 1

x1 <- runif(100, minimo, maximo)
x2 <- runif(100, minimo, maximo)
x3 <- runif(100, minimo, maximo)
x4 <- runif(100, minimo, maximo)

# Saída: distância entre (x1, x2) e (x3, x4)
y <- sqrt((x1 - x3)^2 + (x2 - x4)^2)

# Saída: produto escalar
y <- (x1 * x3 + x2 * x4)

# Fazer vetores unitários
# Calcular produto escalar
# y = cosseno do ângulo
modulo1 <- sqrt(x1^2 + x2^2)
modulo2 <- sqrt(x3^2 + x4^2)
x1 <- x1 / modulo1
x2 <- x2 / modulo1
x3 <- x3 / modulo2
x4 <- x4 / modulo2
y <- x1*x3 + x2*x4

# Saída: soma
# Normalizar x
y <- x1 + x2 + x3 + x4
x1 <- scale(x1)
x2 <- scale(x2)
x3 <- scale(x3)
x4 <- scale(x4)

# Gerar dados de treino
cat(
  '[',
  paste0(
    '[[',
    paste(x1, x2, x3, x4, sep = ", "),
    '], [',
    y,
    ']]',
    collapse = ',\n'
  ),
  ']',
  sep = '\n'
)
