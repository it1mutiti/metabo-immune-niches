#!/usr/bin/env Rscript
suppressPackageStartupMessages({
  if (!requireNamespace("renv", quietly = TRUE))
    install.packages("renv", repos = "https://cloud.r-project.org")
})
cat("===== Freezing R environment via renv =====\n")
if (!dir.exists("renv")) {
  renv::init(bare = TRUE)
} else {
  cat("renv is already initialized.\n")
}
renv::snapshot(prompt = FALSE)
ts <- format(Sys.time(), "%Y%m%d_%H%M%S")
dir.create("environment", showWarnings = FALSE)
file.copy("renv.lock", file.path("environment", paste0("renv_", ts, ".lock")), overwrite = TRUE)
cat("OK :: renv.lock -> environment/renv_", ts, ".lock\n", sep = "")
