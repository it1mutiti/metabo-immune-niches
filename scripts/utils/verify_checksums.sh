#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../" && pwd)"
MODE="${1:-}"
[[ -z "$MODE" ]] && { echo "Usage: $0 [--init|--check|--update]"; exit 1; }

list_files() {
  find "$1" -type f \
    ! -name "MANIFEST.sha256" \
    ! -path "*/.ipynb_checkpoints/*" \
    ! -path "*/__pycache__/*" | sort
}

process_dir() {
  local d="$1"
  [[ -d "$d" ]] || return
  local mf="$d/MANIFEST.sha256"
  case "$MODE" in
    --init)
      [[ -f "$mf" ]] || { echo "[INIT] $d"; list_files "$d" | xargs -r sha256sum > "$mf"; }
      ;;
    --check)
      [[ -f "$mf" ]] || { echo "[MISSING] $mf"; return 1; }
      (cd "$d" && sha256sum -c MANIFEST.sha256)
      ;;
    --update)
      echo "[UPDATE] $d"; list_files "$d" | xargs -r sha256sum > "$mf"
      ;;
  esac
}

status=0
for base in data/raw data/spatial data/sc; do
  [[ -d "$ROOT/$base" ]] || continue
  while IFS= read -r d; do
    process_dir "$d" || status=1
  done < <(find "$ROOT/$base" -mindepth 1 -maxdepth 1 -type d)
done
[[ "$MODE" == "--check" ]] && exit $status || exit 0
