#!/usr/bin/env Rscript

init_logger <- function(name="pipeline", log_dir="results/logs") {
  dir.create(log_dir, showWarnings = FALSE, recursive = TRUE)
  timestamp <- format(Sys.time(), "%Y%m%d_%H%M%S")
  log_file <- file.path(log_dir, paste0(name, "_", timestamp, ".log"))
  log_con <- file(log_file, open="wt")

  info <- function(msg) {
    cat(sprintf("%s INFO %s | %s\n", Sys.time(), name, msg), file=log_con)
    flush(log_con)
  }

  info(sprintf("Git commit: %s",
               tryCatch(system("git rev-parse --short HEAD", intern=TRUE), error=function(e) "N/A")))
  if (file.exists("environment/conda.lock")) {
    digest <- tools::md5sum("environment/conda.lock")
    info(sprintf("Environment digest: %s", substr(digest, 1, 10)))
  }

  info("Logger initialized.")
  structure(list(info=info, file=log_file), class="logger")
}
