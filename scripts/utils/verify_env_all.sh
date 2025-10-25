#!/usr/bin/env bash
set -euo pipefail
mkdir -p results/logs

OUT="results/logs/env_check_$(date +%Y%m%d_%H%M%S).txt"

{
  echo "===== Segment 2 :: Unified Environment Verification ====="
  echo "UTC: $(date -u)"
  echo ""

  echo "[Shell Environment]"
  echo "OPENAI_API_KEY prefix: $(echo ${OPENAI_API_KEY:-unset} | cut -c1-20)"
  echo "OPENAI_MODEL: ${OPENAI_MODEL:-unset}"
  echo "PROJECT_ROOT: ${PROJECT_ROOT:-unset}"
  echo "R_PROFILE_USER: ${R_PROFILE_USER:-unset}"
  echo ""

  echo "[Python Environment]"
  echo "Python: $(python3 --version 2>&1)"
  echo "Conda env: $(conda env list | sed -n 's/\\*//p' | tr -s ' ' | cut -d' ' -f1-2)"
  echo "pip list (top 5):"
  pip list 2>/dev/null | head -n 5 || echo "pip not available"
  echo ""

  echo "[R Environment]"
  Rscript -e 'cat("R version:", as.character(getRversion()), "\nPlatform:", R.version$platform, "\n")'
  echo ""

  echo "[Bridge Test – reticulate]"
  Rscript -e 'suppressPackageStartupMessages(library(reticulate)); cat("Python from R:", py_config()$python, "\n")' 2>/dev/null || echo "reticulate not configured"
  echo ""

  echo "[Bash Audit Log Tail]"
  if [ -f results/logs/command_history.log ]; then
    tail -n 5 results/logs/command_history.log
  else
    echo "No Bash audit log found yet."
  fi
  echo ""

  echo "[R Audit Log Tail]"
  if [ -f results/logs/R_command_history.log ]; then
    tail -n 5 results/logs/R_command_history.log
  else
    echo "No R audit log found yet."
  fi
  echo ""

  echo "[Git Status]"
  echo "Commit: $(git rev-parse HEAD)"
  echo "Unstaged changes:"
  git status --porcelain
} | tee "$OUT"

echo ""
echo "OK :: Verification log → $OUT"
