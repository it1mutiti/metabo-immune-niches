#!/usr/bin/env Rscript
suppressPackageStartupMessages(library(reticulate))
dir.create("results/logs", showWarnings = FALSE, recursive = TRUE)
logfile <- "results/logs/bridge_test.log"
sink(logfile)
cat("===== reticulate bridge test =====\n")
success <- FALSE
try({
  print(py_config())
  success <- TRUE
})
cat("\nStatus:", if (success) "SUCCESS" else "FAILURE", "\n")
sink()
cat("OK :: Bridge test log ->", logfile, "\n")
