# script for processing datasets to be stored in ../data or ../data-research

library(readr)
library(tibble)

set.seed(1352)

x <- rnorm(100)
y <- rnorm(100)

write_csv(tibble(x = x, y = y), "data/dataset.csv")
