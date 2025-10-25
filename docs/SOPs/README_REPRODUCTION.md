Replace nothing—this is already customized with your name and email.

# 🧬 Metabo-Immune Niches — Segment 2 Reproducibility Bundle

**Project:** Metabo-Immune Niches  
**Segment:** 2 — Environment & Reproducibility Infrastructure  
**Author:** Irvine Tatenda Mutiti  
**Date:** 2025-10-25  
**Validation Hash:** `f97fc2b36b5826ca7ac48ce3e2b5c836209acca4bdb917bac0dd1e3b81a2266e`

---

## 📖 Purpose

This bundle allows any collaborator or reviewer to **reconstruct the exact computational environment** used for Segment 2 of the Metabo-Immune Niches project.  
All dependencies, R/Python packages, audit logs, and metadata are frozen for long-term verifiability.

The process is **deterministic**: if the steps below yield the same checksum, your environment is byte-for-byte identical to the verified 2025-10-25 state.

---

## 🧱 1. Repository Structure



metabo-immune-niches/
├── environment/ # Frozen Conda & R environments
├── manifests/ # File hashes & data manifests
├── results/logs/ # Provenance, audit & verification logs
├── scripts/utils/ # Reproducibility scripts
├── docs/SOPs/ # SOPs & documentation
├── Makefile # One-command automation
└── README_REPRODUCTION.md # This file (copy lives in docs/SOPs/)


---

## ⚙️ 2. Prerequisites

- **Conda or Mamba** (≥ 23.1)
- **R ≥ 4.5.0**
- **Git** (≥ 2.40)
- Linux or macOS shell environment (bash/zsh)

Optional but recommended:  
VS Code or a terminal editor for viewing `.env` and logs.

---

## 🧩 3. Recreate the Environment

### Step 1 — Clone or unpack
```bash
git clone https://github.com/<your_repo>/metabo-immune-niches.git
cd metabo-immune-niches


If you received an archive instead:

tar -xzvf metabo_immune_segment2_repro_bundle.tar.gz
cd metabo-immune-niches

Step 2 — Rebuild the Python environment
conda env create -f environment/python_env.yml
conda activate metabo-immune-niches

Step 3 — Rebuild the R environment
install.packages("renv", repos = "https://cloud.r-project.org")
renv::restore()

Step 4 — Verify reproducibility
make segment2


This command:

Re-freezes Python + R

Re-hashes any raw/external data

Captures host / Git / environment metadata

Runs R↔Python bridge and audit verifiers

A new verification log will appear under results/logs/env_check_<timestamp>.txt.

🧪 4. Integrity Validation

Confirm your environment matches the canonical verified state:

sha256sum results/logs/env_check_*.txt


Expected canonical output:

f97fc2b36b5826ca7ac48ce3e2b5c836209acca4bdb917bac0dd1e3b81a2266e  results/logs/env_check_20251025_173153.txt


✅ If the hash matches, your setup is bit-identical to the validated Segment 2 environment.

📚 5. Key Provenance Artifacts
File	Description
results/logs/ReproMetadata.json	Host / OS / Git / environment snapshot
results/logs/command_history.log	Chronological Bash command trail
results/logs/R_command_history.log	R-level execution and error log
results/logs/bridge_test.log	R↔Python reticulate connectivity
manifests/data_manifest.json	SHA-256 hashes of raw/external data
🔐 6. Audit & Trust

Cryptographic identity: SHA-256 fingerprints guarantee immutability.

Cross-language integrity: reticulate bridge validated.

Runtime auditability: all shell and R commands logged with timestamps.

Single-command reconstruction: via make segment2.

Together, these features satisfy Nature-grade reproducibility and FAIR data principles.

🧾 7. Contact

For replication or method inquiries:
Irvine Tatenda Mutiti — Independent Researcher
📧 it1mutiti@gmail.com

End of README_REPRODUCTION.md