if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

# Bioconductor packages
BiocManager::install(c("GSVA", "ComplexHeatmap", "SpatialExperiment"),
                     ask = FALSE, update = FALSE)

# GitHub packages
if (!requireNamespace("remotes", quietly = TRUE))
    install.packages("remotes")
remotes::install_github("mojaveazure/seurat-disk")
remotes::install_github("MarcElosua/SPOTlight")
remotes::install_github("saeyslab/nichenetr")

# Snapshot environment for reproducibility
if (!requireNamespace("renv", quietly = TRUE)) install.packages("renv")
renv::init(bare = TRUE)
renv::snapshot(prompt = FALSE)
