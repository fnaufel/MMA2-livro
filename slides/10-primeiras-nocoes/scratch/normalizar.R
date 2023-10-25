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
