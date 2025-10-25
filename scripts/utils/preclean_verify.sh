#!/usr/bin/env bash
# ============================================================
# Segment 2.5 — Pre-Clean Verification Script
# Author: Irvine Tatenda Mutiti
# Project: metabo-immune-niches
# Purpose: Verify integrity of Segment 2 before Git cleanup
# ============================================================

echo "🔍  Starting Segment 2.5 Pre-Clean Verification..."
echo "===================================================="
echo

PROJECT_ROOT="$(pwd)"
BACKUP_PATH=~/Desktop/metabo-immune-niches_SEGMENT2_VERIFIED_backup_$(date +%F).tar.gz
CHECKSUM="f97fc2b36b5826ca7ac48ce3e2b5c836209acca4bdb917bac0dd1e3b81a2266e"
ERRORS=0

# --- 1️⃣  Structure check ---
echo "📁 Checking key directories and files..."
for f in docs/SOPs/README_REPRODUCTION.md environment/python_env.yml Makefile logs results/logs; do
    if [ -e "$f" ]; then
        echo "   ✅ $f exists"
    else
        echo "   ❌ Missing: $f"
        ERRORS=$((ERRORS+1))
    fi
done
echo

# --- 2️⃣  Validation proof check ---
echo "🔑 Verifying validation proof checksum..."
if grep -q "$CHECKSUM" docs/SOPs/README_REPRODUCTION.md 2>/dev/null; then
    echo "   ✅ Validation proof found in README_REPRODUCTION.md"
else
    echo "   ⚠️  Checksum not found in docs/SOPs/README_REPRODUCTION.md"
    ERRORS=$((ERRORS+1))
fi
echo

# --- 3️⃣  Log files sanity check ---
echo "🧾 Inspecting provenance and environment logs..."
LOGCOUNT=$(find logs results/logs -type f | wc -l)
if [ "$LOGCOUNT" -gt 5 ]; then
    echo "   ✅ $LOGCOUNT log files detected"
else
    echo "   ⚠️  Few logs detected ($LOGCOUNT) — check provenance completeness"
fi
echo

# --- 4️⃣  .git presence check ---
echo "🧱 Checking for .git directory..."
if [ -d .git ]; then
    GITSIZE=$(du -sh .git | cut -f1)
    echo "   ✅ .git folder found (${GITSIZE})"
else
    echo "   ⚠️  No .git folder detected (already cleaned?)"
fi
echo

# --- 5️⃣  Create safety backup ---
echo "💾 Creating verified backup archive..."
tar -czf "$BACKUP_PATH" "$PROJECT_ROOT" 2>/dev/null
if [ -f "$BACKUP_PATH" ]; then
    echo "   ✅ Backup created at: $BACKUP_PATH"
else
    echo "   ❌ Backup creation failed!"
    ERRORS=$((ERRORS+1))
fi
echo

# --- 6️⃣  Summary ---
echo "===================================================="
if [ "$ERRORS" -eq 0 ]; then
    echo "✅ All critical checks passed. Safe to proceed with Git cleanup."
else
    echo "⚠️  $ERRORS issue(s) detected. Review above before removing .git."
fi
echo "===================================================="
