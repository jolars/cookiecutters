figures_path <- function(x) {
  here::here("paper", "figures", x)
}

tables_path <- function(x) {
  here::here("paper", "tables", x)
}

data_path <- function(x) {
  here::here("data", x)
}

results_path <- function(x) {
  here::here("results", x)
}

# runs latex on a tikz plot and crops the result
render_and_crop <- function(x) {
  wd <- getwd()
  on.exit({
    setwd(wd)
  })

  path <- normalizePath(dirname(x))

  full_file_path <- tools::file_path_as_absolute(x)
  file_wo_ext <- tools::file_path_sans_ext(basename(x))

  pdf_file <- paste0(file_wo_ext, ".pdf")

  # work in a temporary directory to avoid dealing with latex log files
  tmp_dir <- tempdir()
  setwd(tmp_dir)

  # render tex file to pdf
  tools::texi2pdf(full_file_path)

  # crop the pdf file
  success <- knitr:::plot_crop(pdf_file)

  # move the file into the original directory
  success <- file.copy(pdf_file, file.path(path, pdf_file), overwrite = TRUE)

  invisible(success)
}
