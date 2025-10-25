#!/usr/bin/env bash
set -euo pipefail
mkdir -p manifests results/logs
echo "Hashing data/raw ..."
find data/raw -type f -print0 | xargs -0 sha256sum | sort > manifests/raw_data_hashes.txt || true
echo "Hashing data/external ..."
find data/external -type f -print0 | xargs -0 sha256sum | sort > manifests/external_data_hashes.txt || true
echo "OK :: manifests/raw_data_hashes.txt, manifests/external_data_hashes.txt"
