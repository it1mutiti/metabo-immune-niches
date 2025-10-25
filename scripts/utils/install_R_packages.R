#!/usr/bin/env Rscript
options(repos = c(CRAN = "https://packagemanager.posit.co/cran/__linux__/jammy/latest"))
if (!requireNamespace("renv", quietly = TRUE)) install.packages("renv", quiet = TRUE)
renv::init(bare = TRUE)
base_pkgs <- c("Matrix","data.table","dplyr","tibble","ggplot2","patchwork","cowplot","reshape2","readr","reticulate","Seurat","SeuratObject","GSVA","BiocManager")
install.packages(base_pkgs, Ncpus = max(1, parallel::detectCores()-1))
if (!requireNamespace("SeuratDisk", quietly=TRUE)) BiocManager::install("SeuratDisk", ask = FALSE)
if (!requireNamespace("remotes", quietly=TRUE)) install.packages("remotes")
# GitHub pins by commit for determinism
remotes::install_github("MarcElosua/SPOTlight@cb4f5f2", upgrade="never")
remotes::install_github("saeyslab/nichenetr@b61c7b1", upgrade="never")
renv::snapshot(prompt = FALSE)
sessionInfo()
