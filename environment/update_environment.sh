#!/usr/bin/env bash
set -euo pipefail

echo "================================================================="
echo "🔄 Updating metabo-immune-niches environment"
echo "================================================================="

# -----------------------------------------------------------------------------
# STEP 0: Ensure Conda is loaded properly (non-interactive compatible)
# -----------------------------------------------------------------------------
if ! command -v conda >/dev/null 2>&1; then
    echo ">>> Loading Conda shell integration..."
    eval "$(/home/irvine/miniconda3/bin/conda shell.bash hook)" || {
        echo "❌ Could not load Conda. Verify Miniconda path."
        exit 1
    }
fi

ENV_NAME="metabo-immune-niches"

# -----------------------------------------------------------------------------
# STEP 1: Activate environment
# -----------------------------------------------------------------------------
echo ">>> Activating Conda environment..."
eval "$(/home/irvine/miniconda3/bin/conda shell.bash hook)"
conda activate "$ENV_NAME"

# -----------------------------------------------------------------------------
# STEP 2: Update Conda packages
# -----------------------------------------------------------------------------
echo ">>> Updating Conda packages..."
conda update -y --all
echo ">>> Exporting updated Conda lockfile..."
conda list --explicit > environment/conda.lock

# -----------------------------------------------------------------------------
# STEP 3: Update R and Bioconductor packages
# -----------------------------------------------------------------------------
echo ">>> Updating R and Bioconductor packages..."
Rscript - <<'RSCRIPT'
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager", repos="https://cloud.r-project.org")

BiocManager::install(version="3.20", ask=FALSE, update=TRUE, force=TRUE)

if (!requireNamespace("renv", quietly = TRUE))
  install.packages("renv", repos="https://cloud.r-project.org")

# Update all R packages managed by renv
renv::update(prompt = FALSE)
renv::snapshot(prompt = FALSE)

cat("✅ R and Bioconductor packages updated and lockfile refreshed.\n")
RSCRIPT

# -----------------------------------------------------------------------------
# STEP 4: Verify updates
# -----------------------------------------------------------------------------
echo ">>> Verifying package versions..."
Rscript -e '
cat("R version:\n"); print(R.version.string);
cat("\nKey packages:\n");
for (pkg in c("Seurat", "GSVA", "HDF5Array", "magick")) {
  if (requireNamespace(pkg, quietly=TRUE)) {
    cat("✅ ", pkg, " version: ", as.character(packageVersion(pkg)), "\n", sep="")
  } else {
    cat("❌ ", pkg, " missing!\n", sep="")
  }
}
'

# -----------------------------------------------------------------------------
# DONE
# -----------------------------------------------------------------------------
echo "================================================================="
echo "✅ Environment update complete."
echo "   Commit the new lockfiles with:"
echo "     git add environment/conda.lock renv.lock"
echo "     git commit -m 'Update environment lockfiles'"
echo "================================================================="
