#!/usr/bin/env Rscript
suppressPackageStartupMessages({
  if (!requireNamespace("SeuratDisk", quietly = TRUE)) {
    install.packages("remotes", repos = "https://cloud.r-project.org")
    remotes::install_github("mojaveazure/seurat-disk")
  }
  library(SeuratDisk)
})

args <- commandArgs(trailingOnly = TRUE)
if (length(args) != 2) {
  stop("Usage: Rscript convert_h5ad_to_h5seurat.R input.h5ad output.h5seurat")
}

input <- normalizePath(args[1])
output <- normalizePath(args[2], mustWork = FALSE)

if (!file.exists(input)) stop(paste("Input file not found:", input))
Convert(input, dest = "h5seurat", overwrite = TRUE, assay = "RNA")
file.rename(sub("\\.h5ad$", ".h5seurat", input), output)
cat("✅ Converted", input, "→", output, "\n")
