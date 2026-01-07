# script for generating tables to be stored in ../paper/tables/

library(readr)
library(tidyr)
library(dplyr)
library(forcats)

results <- read_csv("results/results.csv")

results %>%
  pivot_longer(everything()) %>%
  group_by(name) %>%
  summarize(mu = mean(value)) %>%
  write_csv("paper/tables/table1.csv")
