#!/usr/bin/env bash
set -euo pipefail
echo "===== Segment 2 :: Environment Freeze (all) ====="
START=$(date +%s)
bash scripts/utils/freeze_python_env.sh
Rscript scripts/utils/freeze_R_env.R
Rscript scripts/utils/freeze_bridge_test.R
END=$(date +%s)
echo "DONE in $((END-START))s"
