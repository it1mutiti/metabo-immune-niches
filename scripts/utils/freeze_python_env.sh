#!/usr/bin/env bash
set -euo pipefail
mkdir -p environment results/logs
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
OUTFILE="environment/python_env_${TIMESTAMP}.yml"
LOGFILE="results/logs/python_freeze_${TIMESTAMP}.log"
{
  echo "===== Freezing Python environment ====="
  echo "Timestamp: $TIMESTAMP"
  conda env export | grep -v "^prefix:" > "$OUTFILE"
  echo "Environment snapshot -> $OUTFILE"
  echo ""
  conda list
} &> "$LOGFILE"
ln -sf "$(basename "$OUTFILE")" environment/python_env.yml
echo "OK :: Python freeze log -> $LOGFILE"
