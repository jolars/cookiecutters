# place scripts for running experiments here and store results in ../results/

library(readr)
library(here)

source(here("scripts", "utils.R"))

dataset <- read_csv(data_path("dataset.csv"))

model <- lm(y ~ x, data = dataset)

yhat <- predict(model)

results <- tibble(x = dataset$x, y = dataset$y, yhat = yhat)

write_csv(results, results_path("results.csv")
