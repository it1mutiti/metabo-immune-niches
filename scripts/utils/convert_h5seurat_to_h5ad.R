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
  stop("Usage: Rscript convert_h5seurat_to_h5ad.R input.h5seurat output.h5ad")
}

input <- normalizePath(args[1])
output <- normalizePath(args[2], mustWork = FALSE)

if (!file.exists(input)) stop(paste("Input file not found:", input))
Convert(input, dest = "h5ad", overwrite = TRUE)
file.rename(sub("\\.h5seurat$", ".h5ad", input), output)
cat("✅ Converted", input, "→", output, "\n")
