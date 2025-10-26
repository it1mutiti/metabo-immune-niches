# 🧬 Metabo-Immune-Niches

### About AI-assisted developer tools (optional)

This repository may be used with optional AI developer tools (e.g., aider, cline, or VS Code AI extensions) **only for local debugging and documentation**.  
These tools use a locally stored environment variable `OPENAI_API_KEY` loaded from a private `.env` file that is **never committed**.  
**Important:** No analysis scripts, pipelines, or reproducibility steps require any OpenAI key. Reproduction can be performed fully offline using the documented environments and `make` targets.


[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.17447568.svg)](https://doi.org/10.5281/zenodo.17447568)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Reproducibility](https://img.shields.io/badge/Reproducibility-Verified-success)](https://zenodo.org/records/17447568)
[![Release](https://img.shields.io/github/v/release/it1mutiti/metabo-immune-niches)](https://github.com/it1mutiti/metabo-immune-niches/releases)
[![Reproducibility Check](https://github.com/it1mutiti/metabo-immune-niches/actions/workflows/reproducibility.yml/badge.svg)](https://github.com/it1mutiti/metabo-immune-niches/actions/workflows/reproducibility.yml)

---

**Verified reproducibility release (v1.0.0)**  
Validation proof SHA-256: `f97fc2b36b5826ca7ac48ce3e2b5c836209acca4bdb917bac0dd1e3b81a2266e`

Reproducible spatial transcriptomics workflow integrating metabolomic and immune niche profiling.

---

## 🚀 Quick Start

```bash
make segment2    # builds/validates reproducibility environment and logs


See docs/SOPs/README_REPRODUCTION.md

for full, publication-grade instructions.

📋 Environment Status
Component	Version	Notes
Project	metabo-immune-niches	Spatial + immune niche reproducibility pipeline
Conda Env	metabo-immune-niches	From environment/conda.lock
R Env	Managed via renv	From environment/renv.lock
Validated R version	≥ 4.4.3	Matches Bioconductor 3.20
Validated Python version	3.10+	Matches Conda lockfile
Last Validated	October 2025	Verified reproducibility

To check this on any machine:

bash environment/check_environment.sh

🧩 Setup Instructions
1️⃣ Prerequisites

Install the following tools before proceeding:

Tool	Minimum Version	Install Link
Git	2.30+	git-scm.com

Git LFS	3.0+	git-lfs.com

Conda / Mamba	23.0+	conda.io/miniconda.html

R	≥ 4.4	cran.r-project.org
2️⃣ Clone and Rebuild Environment
git clone https://github.com/it1mutiti/metabo-immune-niches.git
cd metabo-immune-niches
bash environment/rebuild_environment.sh


This script will:

Recreate the Conda environment from environment/conda.lock

Restore the R packages from environment/renv.lock

Validate that Seurat, GSVA, HDF5Array, and magick all load successfully

3️⃣ Verify Setup

Check everything’s working:

bash environment/check_environment.sh


You should see:

✅ All core R packages loaded successfully
✅ Environment status check complete

4️⃣ Updating (optional)

To update packages and refresh both lockfiles:

bash environment/update_environment.sh
git add environment/conda.lock environment/renv.lock
git commit -m "Update environment lockfiles"
git push

📂 Project Structure
metabo-immune-niches/
├── data/
│   ├── raw/ external/ interim/ processed/ metadata/
├── results/
│   ├── NSCLC/ GBM/ GASTRIC/ PDAC/ meta/
├── reports/
│   ├── figures/ tables/ qc/ html/
├── scripts/
│   ├── spatial/ sc_reference/ deconvolution/ stats/ meta/ mech/ utils/
├── environment/
│   ├── conda.environment.yml
│   ├── conda.lock
│   ├── renv.lock
│   ├── setup_environment.sh
│   ├── update_environment.sh
│   ├── rebuild_environment.sh
│   ├── check_environment.sh
├── config/ manifests/ workflow/ logs/
├── docs/
│   ├── manuscript/ SOPs/
└── README.md

🧠 Citation & Credits

If you use this workflow, please cite:

Mutiti, Irvine Tatenda (2025).
metabo-immune-niches: Verified Reproducibility Release v1.0.0.
Zenodo. https://doi.org/10.5281/zenodo.17447568

See CITATION.cff
 for machine-readable citation metadata.

🧰 License

Licensed under the MIT License — see LICENSE
.

🧪 Maintainer

Irvine Tatenda Mutiti
Independent Researcher
📧 it1mutiti@gmail.com

🧾 Provenance

This repository archives the complete reproducible environment, data provenance, and validation workflow for the metabo-immune-niches study.
It includes verified environment hashes, Makefile automation, and cross-language audit trails for computational reproducibility.


---
