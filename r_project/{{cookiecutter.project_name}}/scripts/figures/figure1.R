# script for generating figures to be stored in ../paper/figures/

library(tikzDevice)
library(ggplot2)
library(readr)
library(here)

source(here("scripts", "utils.R"))

results <- read_csv(results_path("results.csv"))
file <- figures_path("plot.tex")

tikz(file, width = 3.3, height = 2.8, standAlone = TRUE)
ggplot(results, aes(x, y)) +
  geom_point() +
  theme_minimal()
dev.off()

render_and_crop(file)
