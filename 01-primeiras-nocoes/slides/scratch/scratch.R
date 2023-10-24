
library(tidyverse)
library(tidymodels)
tidymodels_prefer()
library(keras)
library(tfruns)
library(scales)

# Comparar duas melhores do diretório runs
ls_runs(
  completed,
  order = 'metric_val_mae',
  decreasing = FALSE
) %>% 
  head(2) %>% 
  compare_runs()


# Copiar duas melhores do diretório runs para best-runs
ls_runs(
  order = 'metric_val_mae',
  decreasing = FALSE
) %>% 
  head(2) %>% 
  copy_run(to = 'best-runs/')


# Comparar duas melhores do diretório best-runs
ls_runs(
  order = 'metric_val_mae',
  decreasing = FALSE,
  runs_dir = 'best-runs'
) %>% 
  head(2) %>% 
  compare_runs()


# Diretório best-runs
ls_runs(
  order = 'metric_val_mae',
  decreasing = FALSE,
  runs_dir = 'best-runs'
) %>% 
  select(everything()) %>% 
  View()


