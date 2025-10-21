#!/usr/bin/env bash
set -euo pipefail

echo "================================================================="
echo "♻️  Rebuilding metabo-immune-niches environment (non-interactive)"
echo "================================================================="

# Detect project root (assuming script lives in environment/)
PROJ_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$PROJ_DIR"

# === Python / Conda environment ==================================
if ! command -v conda &>/dev/null; then
  echo "❌ Conda not found. Please install Miniconda or Mamba first."
  exit 1
fi

if [ ! -f environment/conda.lock ]; then
  echo "❌ Missing environment/conda.lock — cannot rebuild Python environment."
  exit 1
fi

echo ">>> Recreating Conda environment from lockfile..."
ENV_NAME="metabo-immune-niches"
conda env remove -n "$ENV_NAME" -y &>/dev/null || true
conda create -n "$ENV_NAME" --file environment/conda.lock -y
source "$(conda info --base)/etc/profile.d/conda.sh"
conda activate "$ENV_NAME"
echo "✅ Conda environment rebuilt successfully."

# === R / renv environment ========================================
if [ ! -f environment/renv.lock ]; then
  echo "❌ Missing environment/renv.lock — skipping R restore."
else
  echo ">>> Restoring R packages via renv..."
  Rscript -e '
    if (!requireNamespace("renv", quietly=TRUE)) install.packages("renv", repos="https://cloud.r-project.org");
    renv::restore(lockfile="environment/renv.lock", prompt=FALSE);
    cat("✅ R environment restored from lockfile\n");
  '
fi

# === Sanity check =================================================
echo ">>> Running R package load sanity check..."
Rscript -e '
required_pkgs <- c("Seurat", "GSVA", "HDF5Array", "magick")
ok <- vapply(required_pkgs, requireNamespace, logical(1), quietly=TRUE)
if (all(ok)) {
  cat("✅ All core R packages loaded successfully:\n")
  print(required_pkgs)
} else {
  cat("⚠️  Some R packages failed to load:\n")
  print(required_pkgs[!ok])
  quit(status = 1)
}
sessionInfo()
'

echo "================================================================="
echo "✅ Environment successfully rebuilt and validated for metabo-immune-niches"
echo "================================================================="
