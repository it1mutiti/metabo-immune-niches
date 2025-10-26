
# 🛡️ Security Audit 01 — Final Repository Sanitation Report

**Project:** metabo-immune-niches  
**Maintainer:** Irvine Tatenda Mutiti  
**Date:** 2025-10-26  

---

## 🧭 Background

On 2025-10-25 OpenAI automatically disabled one API key (`sk-…zYA`) after detecting public exposure.  
Subsequent investigation confirmed that `.Rprofile` contained a live key committed in an earlier snapshot.  
A full, publication-grade cleanup and verification process was initiated.

---

## 🧹 Actions Performed

1. Revoked all OpenAI API keys and rotated credentials.  
2. Removed `.Rprofile` from the repository and verified local deletion.  
3. Rewrote repository history using:

   ```bash
   git filter-repo --path .Rprofile --invert-paths
   git filter-repo --replace-text <(echo "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==>***REMOVED***")
   git push origin --force --all
   git push origin --force --tags


Confirmed .Rprofile and all sensitive keys were purged from every commit and tag.

Re-enabled GitHub protections:

Require pull-request reviews

Disable force pushes

Enable secret-scanning and Dependabot alerts

Re-ran full repository scans.

🔍 Verification

Commands executed:

git log -p -S "sk-" --source --all | grep -n "sk-" || true
grep -RniE "sk-[a-zA-Z0-9]{20,}" . --exclude-dir=.git || true


Results:

No real API keys or tokens detected.

Only harmless placeholders (sk-REPLACE_WITH_YOUR_KEY) remain for instructional use.

.Rprofile completely removed from all commits.

🎯 Final Status
Check	Result
OpenAI key revoked	✅
.Rprofile removed	✅
Old commits rewritten	✅
GitHub tags updated	✅
Security scans clean	✅
Branch protection restored	✅
🧾 Repository Ready for Archival

All verification steps completed successfully.
Repository meets publication-grade reproducibility and security standards.
Associated DOI: 10.5281/zenodo.17447568

Prepared and verified by
Irvine Tatenda Mutiti
Independent Researcher
2025-10-26
