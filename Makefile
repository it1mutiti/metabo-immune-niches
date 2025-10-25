# ==============================
# Metabo-Immune-Niches — Segment 2
# Reproducibility Infrastructure Makefile
# ==============================

.PHONY: freeze provenance verify segment2

# ---- Step 2: Environment Freeze ----
freeze:
	@echo ">>> Freezing Python and R environments"
	./scripts/utils/run_freeze_all.sh

# ---- Step 3–4: Provenance & Runtime Metadata ----
provenance:
	@echo ">>> Hashing data and recording reproducibility metadata"
	./scripts/utils/hash_data.sh
	python3 scripts/utils/make_manifest.py
	python3 scripts/utils/make_repro_meta.py

# ---- Step 5: Unified Verification ----
verify:
	@echo ">>> Running unified environment verification"
	./scripts/utils/verify_env_all.sh

# ---- Full Segment 2 pipeline ----
segment2: freeze provenance verify
	@echo ""
	@echo "========================================"
	@echo "Segment 2 complete: Environment frozen, provenance logged, and verification passed."
	@echo "Logs → results/logs/"
	@echo "========================================"
