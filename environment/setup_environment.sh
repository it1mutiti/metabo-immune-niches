#!/usr/bin/env bash
set -euo pipefail

echo "================================================================="
echo "🚀 Setting up metabo-immune-niches environment"
echo "================================================================="

# -----------------------------------------------------------------------------
# STEP 0: Guarantee Conda shell hook is loaded (fixes 'Run conda init' issue)
# -----------------------------------------------------------------------------
if ! command -v conda >/dev/null 2>&1; then
    echo ">>> Loading Conda shell integration..."
    eval "$(/home/irvine/miniconda3/bin/conda shell.bash hook)" || {
        echo "❌ Conda shell hook failed. Please verify Miniconda path."
        exit 1
    }
fi

# -----------------------------------------------------------------------------
# STEP 1: Create Conda environment if needed
# -----------------------------------------------------------------------------
ENV_NAME="metabo-immune-niches"

if ! conda env list | grep -q "$ENV_NAME"; then
    echo ">>> Creating Conda environment: $ENV_NAME"
    conda create -y -n "$ENV_NAME" -c conda-forge -c bioconda \
        python=3.12 \
        r-base=4.4 \
        git git-lfs mamba \
        r-ggplot2 r-dplyr r-tibble r-matrix r-lme4 r-metafor r-upsetr \
        r-cowplot r-patchwork r-seurat r-seuratobject r-igraph \
        r-magick r-xml r-renv r-devtools r-remotes r-biocmanager \
        bioconductor-gsva bioconductor-hdf5array bioconductor-rhdf5
else
    echo ">>> Environment already exists — skipping creation."
fi

# -----------------------------------------------------------------------------
# STEP 2: Activate environment safely
# -----------------------------------------------------------------------------
echo ">>> Activating environment..."
eval "$(/home/irvine/miniconda3/bin/conda shell.bash hook)"
conda activate "$ENV_NAME"

# -----------------------------------------------------------------------------
# STEP 3: Ensure ImageMagick paths for R package magick
# -----------------------------------------------------------------------------
mkdir -p "$CONDA_PREFIX/etc/conda/activate.d"
cat > "$CONDA_PREFIX/etc/conda/activate.d/env_magick.sh" <<'EOF'
export PKG_CONFIG_PATH="$CONDA_PREFIX/lib/pkgconfig:$PKG_CONFIG_PATH"
export LD_LIBRARY_PATH="$CONDA_PREFIX/lib:$LD_LIBRARY_PATH"
EOF

# -----------------------------------------------------------------------------
# STEP 4: Install & verify R packages
# -----------------------------------------------------------------------------
echo ">>> Installing and synchronizing R packages..."
Rscript - <<'RSCRIPT'
if (!requireNamespace("renv", quietly = TRUE)) install.packages("renv", repos="https://cloud.r-project.org")
if (!requireNamespace("BiocManager", quietly = TRUE)) install.packages("BiocManager", repos="https://cloud.r-project.org")

BiocManager::install(version = "3.20", ask = FALSE, update = TRUE)

cran_pkgs <- c(
  "Seurat", "SeuratObject", "GSVA", "ggplot2", "patchwork", "cowplot",
  "Matrix", "dplyr", "tibble", "lme4", "metafor", "ComplexHeatmap",
  "UpSetR", "magick", "xml2"
)

for (pkg in cran_pkgs) {
  if (!requireNamespace(pkg, quietly = TRUE)) {
    message("Installing ", pkg, " ...")
    tryCatch(
      install.packages(pkg, repos="https://cloud.r-project.org"),
      error = function(e) message("⚠️  Failed to install ", pkg, ": ", e$message)
    )
  }
}

if (!requireNamespace("remotes", quietly = TRUE)) install.packages("remotes", repos="https://cloud.r-project.org")

remotes::install_github("MarcElosua/SPOTlight", upgrade="never")
remotes::install_github("saeyslab/nichenetr", upgrade="never")

renv::snapshot(prompt = FALSE)

cat("✅ R packages installed and snapshotted successfully.\n")
RSCRIPT

# -----------------------------------------------------------------------------
# STEP 5: Final verification
# -----------------------------------------------------------------------------
echo ">>> Verifying setup..."
Rscript - <<'RCHECK'
cat("\nR version info:\n")
print(R.version.string)
pkgs <- c("Seurat", "GSVA", "HDF5Array", "magick")
for (p in pkgs) {
  if (requireNamespace(p, quietly = TRUE)) {
    cat("✅", p, "loaded OK\n")
  } else {
    cat("❌", p, "missing\n")
  }
}
RCHECK

# -----------------------------------------------------------------------------
# DONE
# -----------------------------------------------------------------------------
echo "================================================================="
echo "✅ metabo-immune-niches environment setup complete!"
echo "================================================================="
