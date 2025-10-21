# 🧬 Metabo-Immune-Niches
[![Reproducibility Check](https://github.com/it1mutiti/metabo-immune-niches/actions/workflows/reproducibility.yml/badge.svg)](https://github.com/it1mutiti/metabo-immune-niches/actions/workflows/reproducibility.yml)


![Reproducibility](https://github.com/it1mutiti/metabo-immune-niches/actions/workflows/reproducibility.yml/badge.svg)

 metabo-immune-niches
Reproducible spatial transcriptomics workflow integrating metabolomic and immune niche profiling


📋 Environment Status
Component	Version	Notes
Project	metabo-immune-niches	Spatial + immune niche reproducibility pipeline
Conda Env	metabo-immune-niches	From environment/conda.lock
R Env	Managed via renv	From environment/renv.lock
Validated R version	≥ 4.4.3	Matches Bioconductor 3.20
Validated Python version	3.10+	Matches Conda lockfile
Last Validated	October 2025	

To check this on any machine:

bash environment/check_environment.sh

🚀 Quick Start
1️⃣ Prerequisites

Install the following tools before proceeding:

Tool	Minimum Version	Install
Git	2.30+	git-scm.com

Git LFS	3.0+	git-lfs.com

Conda / Mamba	23.0+	conda.io/miniconda.html

R	≥ 4.4	cran.r-project.org
2️⃣ Clone and rebuild environment
git clone https://github.com/<your-username>/metabo-immune-niches.git
cd metabo-immune-niches
bash environment/rebuild_environment.sh


This script will:

Recreate the Conda environment from environment/conda.lock

Restore the R packages from environment/renv.lock

Validate that Seurat, GSVA, HDF5Array, and magick all load successfully

3️⃣ Verify setup

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

Your Name et al. (2025). Metabo-immune-niches: a reproducible framework for multi-omic spatial immunometabolism.

🧰 License

Licensed under the MIT License — see LICENSE
.

🧪 Maintainer

Your Name
Irvine Tatenda Mutiti
📧 it1mutiti@gmail.com
