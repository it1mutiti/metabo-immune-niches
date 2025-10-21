#!/usr/bin/env Rscript

set_all_seeds <- function(seed=42) {
  set.seed(seed)
  if ("future" %in% loadedNamespaces()) {
    try(future::plan("sequential"), silent=TRUE)
  }
  message(sprintf("[seed] Global random seed set to %d", seed))
}
